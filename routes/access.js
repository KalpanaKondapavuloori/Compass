/**
 * role related routes
 */

var async = require('async');
var bcrypt = require('bcrypt');

var db = require('../utils/db');
var msgLib = require('../config/msg');
var accessUtil = require('../utils/access');

var isEmailValid = function(email) {
    var matches = email.match(/[\w\.+]+@\w+\.[\w\.]+/g);
    return (matches && matches[0] && matches[0] == email);
};

var login = function(app, req, res) {
    var requiredFields = ['email', 'pass'];

    var missingFields = [];
    var values = {};

    for (var i = 0; i < requiredFields.length; ++i) {
        var val = req.body[requiredFields[i]];
        if (val !== null && val !== undefined && val.length)
            values[requiredFields[i]] = val;
        else
            missingFields.push(requiredFields[i]);
    }

    var err;
    if (missingFields.length)
        err = 'Following fields require a value:<br> ' + missingFields.join('<br>');
    else if (!isEmailValid(values.email))
        err = 'Invalid email address.';

    if (err) {
        return res.render('access/login', {
            err: err
        });
    }

    req.session = req.session || {};

    async.parallel({
            user: function(next) {
                db._query('SELECT users.id, users.password, users.role, users.name, users.project, projects.name as projectName FROM users INNER JOIN projects on users.project = projects.id WHERE users.email = ? AND users.active = ?', [values.email, 1], function(err, results) {
                    if (err)
                        return next(new Error('Server error occurred. Try again later.' + err.message));
                    if (!results || !results[0])
                        return next(new Error('The user with the specified email is inactive or does not exist.'));
                    if (!results[0].password)
                        return next(new Error('This account does not have a password set. Check your email for instructions on how to set a password.'));

                    bcrypt.compare(values.pass, results[0].password, function(err, valid) {
                        if (err || !valid)
                            return next(new Error('Incorrect password.'));

                        var user = {
                            id: results[0].id,
                            name: results[0].name,
                            email: req.body.email,
                            role: results[0].role,
                            project: {
                                id: results[0].project,
                                name: results[0].projectName,
                            }
                        };

                        return next(null, user);
                    });
                });
            },
            roles: function(next) {
                db._query('SELECT * FROM roles', [], function(err, data) {
                    if (err)
                        return next(err);

                    var roles = [];
                    if (data && data.length) {
                        data.forEach(function(role) {
                            roles.push({
                                id: role.id,
                                name: role.name,
                                permissions: role.permissions
                            });
                        });
                    }

                    return next(null, roles);
                });
            }
        },
        function(err, data) {
            if (err)
                return res.render('access/login', {
                    err: err.message
                });

            req.session.user = data.user;

            data.roles.forEach(function(role) {
                var roleMatch = role.id == req.session.user.role;

                if (roleMatch) {
                    req.session.user.role = {
                        id: role.id,
                        name: role.name
                    }
                    try {
                        req.session.permissions = role.permissions && JSON.parse(role.permissions);
                    } catch (err) {
                        req.session.permissions = {};
                    }
                }

                delete role.permissions;
            });
            req.session.roles = data.roles || [];

            return res.render('access/redirect', {
                url: req.body.redirectTo && req.body.redirectTo.length ? req.body.redirectTo : '/issues'
            });
        });
};

var getLogin = function(req, res) {
    /*
    if (res.locals.isAuthenticated) {
        res.redirect('/dashboard');
    }
    */
    if (req.query.msg) {
        var msg = msgLib.access[req.query.msg] || msgLib['default'];
        res.locals.err = msg;
    }

    if (req.query.redirectTo) {
        res.locals.redirectTo = req.query.redirectTo;
    }

    res.render('access/login', res.locals);
};

var logout = function(req, res) {
    delete req.session.user;
    res.redirect('/access/login?msg=logoutok');
};

var showResetPassword = function(req, res) {
    if (!req.query.code)
        return res.render('access/reset', res.locals);

    res.locals.code = req.query.code;
    res.locals.isReset = true;
    res.render('access/activate', res.locals);
};

var showActivateAccount = function(req, res) {
    res.locals.code = req.query.code;
    res.render('access/activate', res.locals);
};

var destroyPasswordCode = function(code, callback) {
    db.remove('password_reset', ['code'], [code], callback);
};

var codeBasedPasswordReset = function(req, res) {
    var view = 'access/activate';
    var type = req.body.isReset ? 'reset' : 'activate';

    res.locals.isReset = type !== 'activate';

    var password1 = req.body.pass1;
    var password2 = req.body.pass2;

    if (!password1.length || !password2.length)
        return res.render(view, {
            err: 'Password cannot be empty.'
        });

    if (password1 !== password2)
        return res.render(view, {
            err: 'Passwords should match.'
        });

    var code = req.body.code;
    if (!code)
        return res.render(view, {
            err: 'Invalid code.'
        });

    db.select('password_reset', ['*'], ['code'], [code], [], function(err, data) {
        if (err)
            return res.render(view, {
                err: 'Server error. Try later.'
            });
        if (!data || !data[0])
            return res.render(view, {
                err: 'Invalid code.'
            });

        bcrypt.genSalt(10, function(err, salt) {
            bcrypt.hash(password1, salt, function(err, hash) {
                if (err)
                    return res.render(view, {
                        err: 'Server error. Try later.'
                    });

                db.update('users', ['password'], [hash], ['id'], [data[0].user], function(err, data) {
                    if (err)
                        return res.render(view, {
                            err: 'Server error. Try later.'
                        });

                    destroyPasswordCode(code, function(err, data) {
                        res.redirect('/access/login?msg=' + type + 'ok');
                    });
                });
            });
        });
    });
};

var resetPassword = function(req, res) {
    if (!req.body.email)
        return res.render('access/reset', {
            err: 'Email cannot be empty.'
        });

    db.select('users', ['id', 'name'], ['email', 'active'], [req.body.email, true], null, function(err, userData) {
        if (err)
            return res.render('access/reset', {
                err: 'Server error. Try later.'
            });

        if (!userData || !userData[0])
            return res.render('access/reset', {
                err: 'No user account is associated with that email.'
            });

        accessUtil.generateCode({
            id: userData[0].id,
            name: userData[0].name
        }, req.body.email, 'resetPassword', null, function(err, data) {
            if (err)
                return res.render('access/reset', {
                    err: 'Server error. Failed to send email. Try later.'
                });

            return res.render('access/reset', {
                info: 'Password reset email has been sent. Check your mail for instructions.'
            });
        });
    });
};

var setPassword = function(req, res) {
    codeBasedPasswordReset(req, res);
};

module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/access/', getLogin);
        app.get('/access/login', getLogin);

        var wrappedLogin = function(req, res) {
            login(app, req, res);
        };

        app.post('/access/', wrappedLogin);
        app.post('/access/login', wrappedLogin);

        app.get('/access/logout', logout);

        app.get('/access/reset', showResetPassword);
        app.get('/access/activate', showActivateAccount);

        app.post('/access/reset', resetPassword);
        app.post('/access/setPassword', setPassword);
    }
};
