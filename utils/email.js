/**
 * Email utility
 * Provides methods to send mails.
 */

var ejs = require('ejs');
var nodemailer = require('nodemailer');

var config = require('../config/email');
var db = require('./db');

var messages = config.messages;
config = config.settings;

var getEmailIdsFromRoleForProject = function(roles, project, callback) {
    if (!roles.length || !project)
        return callback(null, {});

    var roleMappedQ = roles.map(function(item) {
        return '?';
    }).join(',');

    db._query('SELECT id, name FROM roles WHERE name IN (' + roleMappedQ + ')', roles, function(err, roleIds) {
        if (err)
            return callback(err);

        var vals = roleIds.map(function(item) {
            return item.id;
        });
        vals.unshift(project);

        db._query('SELECT id, name, email, role FROM users WHERE project = ? AND role IN (' + roleMappedQ + ')', vals, function(err, data) {
            var emailByRole = {};
            if (data && data.length) {
                var rolesById = {};
                roleIds.forEach(function(item) {
                    rolesById[item.id] = item.name;
                });

                data.forEach(function(item) {
                    var roleName = rolesById[item.role];
                    emailByRole[roleName] = emailByRole[roleName] || [];
                    emailByRole[roleName].push(item.email);
                });
            }
            callback(err, emailByRole);
        });
    });
};

var compileMessages = function(messages) {
    var keys = Object.keys(messages);

    for (var i = 0; i < keys.length; ++i) {
        var key = keys[i];
        if (!messages[key].subject || !messages[key].text)
            throw new Error('Invalid email template. ' + key + ' should have subject and text fields.');

        messages[key].subject = ejs.compile(messages[key].subject);
        messages[key].text = ejs.compile(messages[key].text);

        if (messages[key].html)
            messages[key].html = ejs.compile(messages[key].html);
    }

    return messages;
};

var send = function(to, key, obj, project, callback) {
    if (typeof obj === 'function') {
        callback = obj;
        obj = null;
    }

    var template = messages[key];

    if (!template)
        return callback(new Error('No such email template.'));

    var cc = template.cc || '';
    getEmailIdsFromRoleForProject(cc.split(','), project, function(err, ccList) {
        if (err) {
            console.log('Error getting CC List. Not CCing anyone.');
            ccList = {};
        }

        var ccListKeys = Object.keys(ccList);
        ccList = ccListKeys.map(function(item) {
            return ccList[item]
        });
        ccList = ccList || null;

        //flatten ccList
        if (ccList.length) {
            ccList = ccList.reduce(function(a, b) {
                return a.concat(b);
            });

            //remove duplicates
            ccList = ccList.filter(function(e, i, s) {
                return s.indexOf(e) == i;
            });
        }

        var transporter = nodemailer.createTransport({
            service: config.service,
            auth: {
                user: config.user,
                pass: config.pass
            },
            debug: true
        });

        var sendObj = {
            from: config.user,
            to: to,
            subject: template.subject(obj),
            text: template.text(obj)
        };

        if (template.html)
            sendObj.html = template.html(obj);

        if (ccList)
            sendObj.cc = ccList;

        transporter.sendMail(sendObj, function(err, data) {
            if (err)
                return callback && callback(new Error('Failed to send mail.'));

            callback && callback();
        });
    });
};

compileMessages(messages);

module.exports = {
    send: send
};
