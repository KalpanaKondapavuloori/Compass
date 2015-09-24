var flowConfig = function(app, req, res, next) {
    var project = req.session && req.session.user && req.session.user.project;
    if (project)
        res.locals.projectConfig = app.get('project-' + project.id);

    next();
};

exports.setup = function(app) {
    app.use(function(req, res, next) {
        flowConfig(app, req, res, next);
    });
};
