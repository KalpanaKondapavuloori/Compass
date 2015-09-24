/**
 * Module dependencies.
 */

var express = require('express');
var http = require('http');
var path = require('path');
var log = require('util').log;

var methodOverride = require('method-override');
var bodyParser = require('body-parser');
var multer = require('multer');
var cookieParser = require('cookie-parser');
var session = require('cookie-session');
var csrf = require('csurf');
var access = require('./middleware/access');
var favicon = require('serve-favicon');

var config = require('./config/app');
var db = require('./utils/db');
var defaultFlowConfig = require('./config/flow');
var merge = require('lodash').merge;

var setupRoutes = function(app) {
    log('Setting up application routes...');

    var routes = ['users', 'roles', 'access', 'projects', 'issues', 'queues'];
    routes.forEach(function(file) {
        log('Configuring ' + file + ' routes...');
        require('./routes/' + file).register(app);
        log('Done configuring ' + file + ' routes.');
    });

    log('Setting up redirects...');
    app.get('/', function(req, res) {
        res.redirect(302, '/issues');
    });
    log('Redirect setup done.');

    log('Route setup done.');
};

var setupMiddleware = function(app) {
    log('Setting up application middleware...');

    var middleware = ['access', 'config', 'flowConfig'];
    middleware.forEach(function(file) {
        log('Configuring ' + file + ' middleware...');
        require('./middleware/' + file).setup(app);
        log('Done configuring ' + file + ' middleware.');
    });

    log('Middleware setup done.');
};

var setupProjects = function(app, callback) {
    log('Configuring projects...');
    db._query('SELECT * FROM projects', null, function(err, projects) {
        if (err)
            throw new Error('Failed to retrieve project settings.');

        for (var i = projects.length - 1; i >= 0; --i) {
            var project = projects[i];
            project.config = project.flow_config.toString();

            if (!project.config) {
                project.config = defaultFlowConfig;
            } else {
                try {
                    project.config = JSON.parse(project.config);
                    var config = {};
                    merge(config, defaultFlowConfig);
                    merge(config, project.config);
                    project.config = config;
                } catch (err) {
                    log('Failed to parse project configuration. Using default config.');
                    project.config = defaultFlowConfig;
                }
            }

            app.set('project-' + project.id, project.config);
            log('Project configuration done.');
            callback();
        }
    });
};

var configExpress = function(callback) {
    log('Configuring Express Server...');

    var app = express();

    // all environments
    app.set('port', process.env.PORT || 7000);
    app.set('views', path.join(__dirname, 'views'));
    app.set('view engine', 'ejs');

    app.disable('x-powered-by');

    app.use(favicon(__dirname + '/public/img/favicon.png'));
    //app.use(methodOverride());
    app.use(session({
        keys: config.session.keys,
        name: config.session.name
    }));
    app.use(bodyParser.json());
    app.use(bodyParser.urlencoded({
        extended: true
    }));
    app.use(multer());
    app.use(csrf({
        ignoreMethods: ['GET', 'HEAD', 'OPTIONS', 'DELETE']
    }));
    app.use(express.static(path.join(__dirname, 'public')));

    setupMiddleware(app);
    setupRoutes(app);

    setupProjects(app, function() {
        log('Express configured.');
        callback(app);
    });

};

var listen = function(app) {
    log('Starting server...');
    app.listen(app.get('port'), function() {
        console.log('Server listening on port ' + app.get('port'));
    });
};

configExpress(function(app) {
    listen(app);
});
