/**
 * Access Control Middleware
 */

var authenticate = function(req, res, next) {
    var session = req.session;
    if (session && session.user && session.user.id) {
        res.locals = res.locals || {};
        res.locals.user = {
            name: session.user.name,
            id: session.user.id,
            imgurl: session.user.imgurl,
            role: session.user.role.name
        };
        res.locals.isAuthenticated = true;
    } else {
        res.locals.user = null;
        res.locals.isAuthenticated = false;
    }

    next();
};

var control = function(req, res, next) {
    // publicRoutes should always have a trailing slash
    var publicRoutes = ['/', '/index/', '/access/', '/access/login/', '/access/activate/', '/access/reset/', '/access/setPassword/'];

    if (res.locals.isAuthenticated || (publicRoutes.indexOf(req.path) > -1 || publicRoutes.indexOf(req.path + '/') > -1))
        return next();

    res.redirect('/access/login?msg=authrequired&redirectTo=' + req.originalUrl);
};

var handleCSRFError = function(err, req, res, next) {
    if (err.code !== 'EBADCSRFTOKEN')
        return next(err);

    // handle CSRF token errors here
    res.status(403);
    res.send('Invalid CSRF Token. Session Terminated.');
};

var generateCSRFToken = function(req, res, next) {
    // Generate csrf token and push to locals if request is a GET/POST
    if (req.method == 'GET' || req.method == 'POST')
        res.locals._csrf = req.csrfToken();

    next();
};

exports.setup = function(app) {
    //Check login state and make user available to templates
    app.use(authenticate);
    app.use(control);

    // handle csrf
    app.use(handleCSRFError);
    app.use(generateCSRFToken);
};
