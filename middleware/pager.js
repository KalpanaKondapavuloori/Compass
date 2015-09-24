/**
 * Pagination middleware
 */

var db = require('../utils/db');

var config = require('../config/app').pagination;

var routeMap = {
    '/users': 'users',
    '/roles': 'roles',
    '/issues': 'issues',
    '/projects': 'projects',
    '/queues': 'queues'
};

var paginate = function(req, res, next) {
    var collection = routeMap[req.path];
    if (!collection)
        return next();

    var page = parseInt(req.query.page);
    page = isNaN(page) ? 1 : page;

    var countQuery = 'SELECT count FROM collection_meta WHERE collection = ?';
    db._query(countQuery, [collection], function(err, data) {
        if (err)
            return res.render(collection + '/index', {
                err: err
            });

        res.locals.pagerDetails = {
            from: (page - 1) * config.pageSize,
            totalRecords: data[0] ? data[0].count : 0,
            currentPage: page,
            pageSize: config.pageSize,
            buttonCount: config.buttons,
            url: collection + '?'
        };

        next();
    });
};

module.exports = {
    paginate: paginate
};
