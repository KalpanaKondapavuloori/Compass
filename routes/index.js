/*
 * GET home page.
 */

var index = function(req, res) {
    res.render('index', {
        title: 'Express'
    });
};

module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/', index);
    }
};
