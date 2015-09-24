/**
 * User related routes
 */

var merge = require('lodash').merge;

var db = require('../utils/db');

var paginate = require('../middleware/pager').paginate;

var msgLib = require('../config/msg');
var defaultFlowConfig = require('../config/flow');

var permissions = function(req, res, next) {
    res.locals.permissions = req.session.permissions && req.session.permissions.projects ? req.session.permissions.projects : {
        create: false,
        read: true,
        update: false,
        del: false
    };

    next();
};

var list = function(req, res) {
    res.locals.pageTitle = 'Projects';
    db._query("SELECT * from compassdb.projects ORDER BY id ASC LIMIT " + res.locals.pagerDetails.from + "," + res.locals.pagerDetails.pageSize, [true], function(err, data) {
        if (err)
            return res.render('projects/index', {
                err: err
            });

        res.render('projects/index', {
            profiles: data
        });
    });

};

var profile = function(req, res) {
    res.locals.pageTitle = 'Projects';
    res.locals.errOnly = true;
    var uid = req.params.id;

    if (!uid)
        return res.render('projects/index', {
            err: 'No such user'
        });

    if (req.query.msg) {
        var msg = msgLib.access[req.query.msg] || msgLib['default'];
        res.locals.msg = msg;
    }

    res.locals.errOnly = false;
    if (uid == 'new')
        return res.render('projects/profile');

    db.select('projects', ['*'], ['id'], [uid], null, function(err, data) {
        var project = data && data[0];
        if (!project && !err)
            err = 'No such project.';

        if (err)
            return res.render('projects/profile', {
                err: err
            });

        project.config = project.flow_config.toString();

        res.render('projects/profile', {
            profile: project,
            errOnly: false,
            pageTitle: project.name + ' Project'
        });
    });
};

var remove = function(req, res) {
    var uid = req.params.id;
    if (!uid)
        return res.render('projects/index', {
            err: 'No such project'
        });

    db.remove('projects', ['id'], [uid], function(err, data) {
        if (err)
            return res.render('projects/index', {
                err: err
            });

        res.status(200).json({
            success: true
        });
    });
};

var update = function(app, req, res) {
    res.locals.errOnly = true;
    res.locals.pageTitle = 'Update Project';

    var uid = req.params.id;
    uid = uid && parseInt(uid);

    if (!uid || isNaN(uid))
        return res.render('projects/index', {
            err: 'No such project'
        });

    var hasAllFields = true;
    ['name', 'description'].every(function(item) {
        var val = req.body[item];
        if (!val || val == '') {
            console.log('Invalid value for ' + item);
            hasAllFields = false;
        }
        return hasAllFields;
    });

    if (!hasAllFields)
        return res.render('projects/profile', {
            err: 'Name and description are mandatory fields.'
        });

    name = req.body['name'];
    description = req.body['description'];
    modified_by = req.session.user.id;
    modified_on = new Date();

    var config = req.body.config;
    if (config) {
        try {
            config = JSON.parse(config);
        } catch (err) {
            return res.render('projects/profile', {
                err: 'Config not a valid JSON string.'
            });
        }
    }

    var flowConfig = {};
    merge(flowConfig, defaultFlowConfig);
    merge(flowConfig, config);
    app.set('project-' + uid, flowConfig);

    db.update('projects', ['name', 'description', 'flow_config', 'modified_by', 'modified_on'], [name, description, JSON.stringify(flowConfig), modified_by, modified_on], ['id'], [uid], function(err, data) {
        if (err) {
            return res.render('projects/profile', {
                err: err
            });
        }
        return res.redirect('/projects/' + uid + '?msg=projectsaveok');
    });
};

var create = function(req, res) {
    res.locals.errOnly = true;
    res.locals.pageTitle = 'New Project';

    var name = req.body["name"];
    var description = req.body["description"];
    var created_on = modified_on = new Date();
    var created_by = modified_by = req.session.user.id;
    //console.log("Hello");
    //return res.redirect('/projects');

    db.insert('projects', ['name', 'description', 'created_on', 'created_by', 'modified_on', 'modified_by'], [name, description, created_on, created_by, modified_on, modified_by], function(err, data) {
        if (err)
            return res.render('projects/profile', {
                err: err
            });

        return res.redirect('/projects');
    });
};

module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/projects', permissions, paginate, list);
        app.post('/projects', permissions, create);

        app.get('/projects/:id', permissions, profile);
        app.delete('/projects/:id', permissions, remove);
        app.post('/projects/:id', permissions, function(req, res) {
            update(app, req, res);
        });
    }
};
