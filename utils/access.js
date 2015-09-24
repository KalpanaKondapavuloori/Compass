/**
 * Access utils
 */

var crypto = require('crypto');
var db = require('./db');
var mail = require('./email');

module.exports = {
    generateCode: function(user, email, template, project, callback) {
        var code = crypto.randomBytes(16).toString('hex');
        db.insert('password_reset', ['code', 'user'], [code, user.id], function(err, data) {
            if (err)
                return callback(err);

            mail.send(email, template, {
                code: code,
                fullName: user.name
            }, project);

            return callback(null, true);
        });
    }
};
