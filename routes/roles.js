/**
 * role related routes
 */

var db = require('../utils/db');
var paginate = require('../middleware/pager').paginate;

var msgLib = require('../config/msg');

var permissions = function(req, res, next) {
    res.locals.permissions = req.session.permissions && req.session.permissions.roles ? req.session.permissions.roles : {
        create: false,
        read: true,
        update: false,
        del: false
    };

    next();
};

var list = function(req, res) {
    // Get all roles from db
    res.locals.pageTitle = 'Roles';
    db._query("SELECT id,name from roles ORDER BY id ASC LIMIT " + res.locals.pagerDetails.from + "," + res.locals.pagerDetails.pageSize, function(err, data) {
        if (err)
            return res.render('roles/index', {
                err: err
            });
        res.render('roles/index', {
            roles: data
        });
    });
};

var remove = function(req, res) {
    var uid = req.params.id;
    if (!uid)
        return res.render('roles/index', {
            err: 'No such role'
        });

    db.remove('roles', ['id'], [uid], function(err, data) {
        if (err)
            return res.render('roles/index', {
                err: err
            });

        res.status(200).json({
            success: true
        });
    });
};

var profile = function(req, res) {
    var uid = req.params.id;
    res.locals.pageTitle = 'Roles';
    res.locals.errOnly = true;

    if (!uid)
        return res.render('roles/profile', {
            err: 'No such user'
        });

    if (uid == 'new')
        return res.render('roles/profile', {
            errOnly: false,
            pageTitle: 'New Role'
        });

    if (req.query.msg) {
        var msg = msgLib.access[req.query.msg] || msgLib['default'];
        res.locals.msg = msg;
    }

    db._query('SELECT id, name, permissions from roles WHERE id = ?', [uid], function(err, data) {
        var role = data && data[0] && data[0];
        if (!role && !err)
            err = new Error('No such role.');

        if (err)
            return res.render('roles/profile', {
                err: err.message
            });

        res.locals.pageTitle = role.name + ' Role';
        res.locals.errOnly = false;

        role.permissions = role.permissions.toString();

        if (req.query.page)
            res.locals.toPage = req.query.page;

        res.render('roles/profile', {
            profile: role
        });
    });
};


var create = function(req, res) {
    res.locals.errOnly = true;
    res.locals.pageTitle = 'New Role';

    var hasAllFields = true;
    ['name'].every(function(item) {
        var val = req.body[item];
        if (!val || val == '') {
            console.log('Invalid value for this' + item);
            hasAllFields = false;
        }
        return hasAllFields;
    });

    if (!hasAllFields)
        return res.render('roles/profile', {
            err: 'Name is a mandatory field.'
        });

    var role = req.body['role'] || 2;
    role = parseInt(role) || 2;
    var name = req.body['name'];

    var jsonPerms;
    if (req.body.permissions) {
        try {
            jsonPerms = JSON.parse(req.body.permissions);
        } catch (err) {
            return res.render('roles/profile', {
                err: 'Permissions not a valid JSON string.'
            });
        }
    }

    db.insert('roles', ['name', 'permissions', 'created_by', 'created_on'], [name, JSON.stringify(jsonPerms), req.session.user.name, new Date()], function(err, data) {
        if (err)
            return res.render('roles/profile', {
                err: err
            });

        return res.redirect('/roles');
    });
};

var update = function(req, res) {
    var uid = req.params.id;
    res.locals.pageTitle = 'Update Role';
    res.locals.errOnly = true;

    uid = uid && parseInt(uid);

    if (!uid || isNaN(uid))
        return res.render('roles/index', {
            err: 'No such role'
        });

    var hasAllFields = true;
    ['name'].every(function(item) {
        var val = req.body[item];
        if (!val || val == '') {
            console.log('Invalid value for ' + item);
            hasAllFields = false;
        }
        return hasAllFields;
    });

    if (!hasAllFields)
        return res.render('roles/err', {
            err: 'Name is a mandatory field'
        });

    role = req.body['role'] || 2;
    role = parseInt(role) || 2;
    name = req.body['name'];

    var jsonPerms;
    if (req.body.permissions) {
        try {
            jsonPerms = JSON.parse(req.body.permissions);
        } catch (err) {
            return res.render('roles/profile', {
                err: 'Permissions not a valid JSON string.'
            });
        }
    }

    db.update('roles', ['name', 'permissions', 'modified_on', 'modified_by'], [name, JSON.stringify(jsonPerms), new Date(), req.session.user.name], ['id'], [uid], function(err, data) {
        if (err) {
            return res.render('roles/profile', {
                err: err
            });
        }
        return res.redirect('/roles/' + uid + '?msg=rolesaveok');
    });
};

module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/roles', permissions, paginate, list);

        app.delete('/roles/:id', permissions, remove);

        app.get('/roles/:id', permissions, profile);
        app.post('/roles/:id', permissions, update);

        app.post('/roles', permissions, create);
    }
};
