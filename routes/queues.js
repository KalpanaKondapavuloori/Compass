var db = require('../utils/db');
var async = require('async');

var paginate = require('../middleware/pager').paginate;

var msgLib = require('../config/msg');

var permissions = function(req, res, next) {
    res.locals.permissions = req.session.permissions && req.session.permissions.queues ? req.session.permissions.queues : {
        create: false,
        read: true,
        update: false,
        del: false
    };

    next();
};

var list = function(req, res) {
    res.locals.pageTitle = 'Queues';
    db._query("SELECT q.id,q.name,p.name as project FROM compassdb.queues q inner join compassdb.projects p on q.project=p.id ORDER BY id ASC LIMIT " + res.locals.pagerDetails.from + "," + res.locals.pagerDetails.pageSize, [true], function(err, data) {
        if (err)
            return res.render('queues/index', {
                err: err
            });

        res.render('queues/index', {
            queues: data
        });
    });
}
var profile = function(req, res) {
    var uid = req.params.id;
    if (!uid)
        return res.render('queues/index', {
            err: 'No such queue'
        });

    if (req.query.msg) {
        var msg = msgLib.access[req.query.msg] || msgLib['default'];
        res.locals.msg = msg;
    }

    async.parallel({
        projects: function(callback) {
            db._query('SELECT * FROM projects', [], function(err, data) {
                if (err)
                    return callback(err);
                callback(null, data);
            });
        },
        queuedata: function(callback) {
            if (uid == 'new')
                return callback(null, 'new');
            db.select('queues', ['id', 'name', 'project'], ['id'], [uid], null, function(err, queuedata) {
                if (err)
                    return callback(err);
                return callback(null, queuedata);
            });
        }
    }, function(err, data) {
        var queue = data.queuedata && data.queuedata[0];
        if (!queue && !err)
            err = 'No such queue.';

        if (err)
            return res.render('queues/new', {
                err: err
            });

        if (data.data == 'new')
            return res.render('queues/new', {
                projects: data.projects
            });

        if (req.query.page)
            res.locals.toPage = req.query.page;

        res.render('queues/new', {
            profile: data.queuedata[0],
            projects: data.projects
        });
    });
};
var create = function(req, res) {
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
        return res.render('queues/new');

    project = req.body['project'] || 1;
    project = parseInt(project) || 1;
    name = req.body['name'];

    db.insert('queues', ['name', 'created_by', 'created_on', 'project'], [name, req.session.user.name, new Date(), project], function(err, data) {
        if (err)
            return res.render('queues/new');

        return res.redirect('/queues');
    });
};

var update = function(req, res) {
    var uid = req.params.id;
    uid = uid && parseInt(uid);

    if (!uid || isNaN(uid))
        return res.render('queues/index', {
            err: 'No such queue.'
        });
    var hasAllFields = true;
    ['name', 'project'].every(function(item) {
        var val = req.body[item];
        if (!val || val == '') {
            console.log('Invalid value for ' + item);
            hasAllFields = false;
        }
        return hasAllFields;
    });

    if (!hasAllFields)
        return res.render('queues/new', {
            err: 'Name and project are mandatory fields.'
        });

    name = req.body['name'];
    project = req.body['project'] || 1;
    project = parseInt(project) || 1;


    db.update('queues', ['name', 'project', 'modified_on', 'modified_by'], [name, project, new Date(), req.session.user.name], ['id'], [uid], function(err, data) {
        if (err)
            return res.render('queues/new', {
                err: err
            });

        return res.redirect('/queues/' + uid + '?msg=queuesaveok');
    });
};
var remove = function(req, res) {
    var uid = req.params.id;
    if (!uid)
        return res.render('queues/index', {
            err: 'No such role'
        });

    db.remove('queues', ['id'], [uid], function(err, data) {
        if (err)
            return res.render('queues/index', {
                err: err
            });

        res.status(200).json({
            success: true
        });
    });
};
module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/queues', permissions, paginate, list);
        app.get('/queues/:id', permissions, profile);
        app.post('/queues', permissions, create);
        app.post('/queues/:id', permissions, update);
        app.delete('/queues/:id', permissions, remove);
    }

};
