/**
 * Config middleware
 * Puts commonly used config variables in res.locals
 */

var app = require('../config/app');

var pageSize = function(req, res, next) {
    res.locals.pageSize = app.pagination.pageSize || 10;
    next();
};

exports.setup = function(app) {
    app.use(pageSize);
};
