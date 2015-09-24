/**
 * User related routes
 */

var async = require('async');
var db = require('../utils/db');

var accessUtil = require('../utils/access');
var paginate = require('../middleware/pager').paginate;

var msgLib = require('../config/msg');

var permissions = function(req, res, next) {
    res.locals.permissions = req.session.permissions && req.session.permissions.users ? req.session.permissions.users : {
        create: false,
        read: true,
        update: false,
        del: false
    };

    next();
};

var list = function(req, res) {
    // Get all users from db
    res.locals.pageTitle = 'Users';
    db._query("SELECT users.id, users.name, users.email, users.active, roles.name AS role FROM users INNER JOIN roles ON users.role = roles.id ORDER BY id ASC LIMIT " + res.locals.pagerDetails.from + "," + res.locals.pagerDetails.pageSize, function(err, data) {
        if (err)
            return res.render('users/index', {
                err: err
            });
        res.render('users/index', {
            profiles: data
        });
    });
};
var remove = function(req, res) {
    var uid = req.params.id;
    if (!uid)
        return res.render('users/index', {
            err: 'No such user'
        });
    db.update('users', ['active'], [0], ['id'], [uid], function(err, data) {
        if (err)
            return res.render('users/index', {
                err: err
            });

        res.status(200).json({
            success: true
        });
    });
};

var profile = function(req, res) {
    var uid = req.params.id;
    res.locals.pageTitle = 'Users';
    res.locals.errOnly = true;

    if (req.query.msg) {
        var msg = msgLib.access[req.query.msg] || msgLib['default'];
        res.locals.msg = msg;
    }

    if (!uid)
        return res.render('users/profile', {
            err: 'No such user'
        });

    if (req.query.page)
        res.locals.toPage = req.query.page;

    async.parallel({
        projects: function(callback) {
            db._query('SELECT * FROM projects', [], function(err, data) {
                if (err)
                    return callback(err);
                callback(null, data);
            });
        },
        roles: function(callback) {
            db._query('SELECT * FROM roles', [], function(err, data) {
                if (err)
                    return callback(err);
                callback(null, data);
            });
        },
        userdata: function(callback) {
            if (uid == 'new')
                return callback(null, 'new');
            db.select('users', ['id', 'name', 'email', 'role', 'project', 'phone', 'active'], ['id'], [uid], null, function(err, userdata) {
                if (err)
                    return callback(err);
                return callback(null, userdata);
            });
        }
    }, function(err, data) {
        if (err)
            return res.render('users/profile', {
                err: err
            });

        if (data.userdata != 'new' && (!data.userdata[0] || !data.userdata[0].name))
            return res.render('users/profile', {
                err: 'No such user.'
            });

        res.locals.pageTitle = 'New User';
        res.locals.errOnly = false;

        if (data.userdata == 'new')
            return res.render('users/profile', {
                roles: data.roles,
                projects: data.projects
            });

        res.locals.pageTitle = data.userdata[0].name;

        if (req.session && req.session.user && req.session.user.id && req.session.user.id == uid)
            res.locals.canEdit = true;

        res.render('users/profile', {
            profile: data.userdata[0],
            roles: data.roles,
            projects: data.projects
        });
    });
};

var create = function(req, res) {
    res.locals.pageTitle = 'New User';
    res.locals.errOnly = true;

    var hasAllFields = true;
    ['name', 'email'].every(function(item) {
        var val = req.body[item];
        if (!val || val == '')
            hasAllFields = false;
        return hasAllFields;
    });

    if (!hasAllFields)
        return res.render('users/profile', {
            err: 'Name and email are mandatory fields'
        });

    role = parseInt(req.body['role']);

    if ((isNaN(role) || role == 0) && res.locals.projectConfig) {
        var flowConfig = res.locals.projectConfig;
        if (flowConfig && flowConfig.users && flowConfig.users.defaults && flowConfig.users.defaults.role) {
            console.log('defaults');
            req.session.roles.every(function(item) {
                var isDefaultRole = (item.name == flowConfig.users.defaults.role);
                if (isDefaultRole)
                    role = item.id;
                return !isDefaultRole;
            });
        }
    }

    project = parseInt(req.body['project']);
    if (isNaN(project) || project == 0) {
        project = req.session.user.project.id;
    }

    name = req.body['name'];
    email = req.body['email'];
    phone = req.body['phone'];
    var active = req.body.active ? 1 : 0;

    db.insert('users', ['name', 'role', 'created_by', 'created_on', 'email', 'project', 'phone', 'active'], [name, role, req.session.user.id, new Date(), email, project, phone, active], function(err, data) {
        if (err) {
            if (err.code == 'ER_DUP_ENTRY')
                return res.render('users/profile', {
                    err: 'User with specified email already exists.'
                });

            return res.render('users/profile', {
                err: 'Server error. Failed to create user. Try later.'
            });
        }

        accessUtil.generateCode({
            id: data.insertId,
            name: name
        }, email, 'newUser', project, function(err, data) {
            if (err)
                return res.render('users/profile', {
                    err: 'Server error. Failed to generate/send activation code. Try later.'
                });

            return res.redirect('/users');
        });
    });
};

var update = function(req, res) {
    var uid = req.params.id;
    uid = uid && parseInt(uid);

    if (!uid || isNaN(uid))
        return res.render('users/index', {
            err: 'No such user'
        });

    if (req.body.action && req.body.action == 'status') {
        return db.update('users', ['active'], [req.body.active || 0], ['id'], [uid], function(err, data) {
            if (err)
                return res.json({
                    err: 'Failed to update user.'
                });

            return res.json({
                success: true,
                data: {
                    status: req.body.active
                }
            });
        });
    }

    res.locals.pageTitle = 'Update User';
    res.locals.errOnly = true;

    var hasAllFields = true;
    ['name', 'email'].every(function(item) {
        var val = req.body[item];
        if (!val || val == '') {
            console.log('Invalid value for ' + item);
            hasAllFields = false;
        }
        return hasAllFields;
    });

    if (!hasAllFields)
        return res.render('users/profile', {
            err: 'Name and email are mandatory fields.'
        });

    role = parseInt(req.body['role']);

    if ((isNaN(role) || role == 0) && res.locals.flowConfig) {
        var flowConfig = res.locals.flowConfig;
        if (flowConfig && flowConfig.users && flowConfig.users.defaults && flowConfig.users.defaults.role) {
            req.session.roles.every(function(item) {
                var isDefaultRole = (item.name == flowConfig.users.defaults.role);
                if (isDefaultRole)
                    role = item.id;
                return !isDefaultRole;
            });
        }
    }

    project = parseInt(req.body['project']);
    if (isNaN(project) || project == 0) {
        project = req.session.user.project.id;
    }

    name = req.body['name'];
    email = req.body['email'];
    phone = req.body['phone'];
    active = req.body['active'];
    if (active == "on") {
        activeStatus = "1";
        console.log("active.." + activeStatus);
    } else {
        activeStatus = "0";
        console.log("active.." + activeStatus);
    }

    res.locals.pageTitle = name;

    db.update('users', ['name', 'role', 'email', 'project', 'modified_on', 'modified_by', 'phone', 'active'], [name, role, email, project, new Date(), req.session.user.id, phone, activeStatus], ['id'], [uid], function(err, data) {
        if (err && err.code == 'ER_DUP_ENTRY')
            return res.render('users/profile', {
                err: 'User with specified email already exists.'
            });

        if (err)
            return res.render('users/profile', {
                err: 'Server error. Failed to update user. Try later.'
            });

        return res.redirect('/users/' + uid + '?msg=usersaveok');
    });
};

var listRole = function(req, res) {
    //var role = req.query['role'] || 1;
    var project = req.session && req.session && req.session.users && req.session.users.project && req.session.users.project.id || 1;
    var role = req.params.role || 'Developer';

    db._query('SELECT users.id, users.name FROM users INNER JOIN roles on users.role = roles.Id WHERE roles.name = ? and users.project = ?', [role, project], function(err, data) {
        if (err) {
            res.json({
                err: err
            });
        } else {
            res.json({
                success: true,
                data: data
            });
        }
    });
};

module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/users/list/:role', permissions, listRole);
        app.get('/users', permissions, paginate, list);
        app.post('/users', permissions, create);

        app.get('/users/:id', permissions, profile);
        app.post('/users/:id', permissions, update);
    }
};
