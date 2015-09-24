var async = require('async');
var merge = require('lodash').merge;
var moment= require('moment');

var db = require('../utils/db');
var msgLib = require('../config/msg');
var paginate = require('../middleware/pager').paginate;
var mail = require('../utils/email');

var list = function(req, res) {
    console.log("Request object",req.query);
    res.locals.pageTitle = 'Issues';
    var role = req.session.user.role.name;
    var project = req.session && req.session.user && req.session.user.project && req.session.user.project.id;

    var listConfig = res.locals.projectConfig;
    listConfig = listConfig && listConfig.issues && listConfig.issues.list;

    var displayQueue = listConfig.queue[role];
    if (!displayQueue)
        displayQueue = listConfig.queue['*'];

    function getIssuesForQueue(queueId) {
        var query = "i.id,i.created_on,external_id as issueid,external_url as url,external_category as category,external_severity as extseverity,p.name as project,tenant,q.name as queue,subject, i.description, severity,status, ia.assigned_to as current_owner FROM compassdb.issues i inner join compassdb.projects p on i.project=p.id inner join compassdb.queues q on q.id=i.queue inner join issue_activity ia on i.id=ia.issue where q.id = ? and p.id = ? AND ia.isCurrent = ? AND status!='Deleted'";
        var values = [queueId, project, true];
        if (queueId === undefined) {
            query = "i.id,i.created_on,external_id as issueid,external_url as url,external_category as category,external_severity as extseverity,p.name as project,tenant,q.name as queue,subject, i.description, severity,status, ia.assigned_to as current_owner FROM compassdb.issues i inner join compassdb.projects p on i.project=p.id inner join compassdb.queues q on q.id=i.queue inner join issue_activity ia on i.id=ia.issue where p.id = ? AND ia.isCurrent = ? AND status!='Deleted'"
            values = [project, true];
        }

        if (req.query.mine) {
            query += ' AND ia.assigned_to = ?';
            values.push(req.session.user.id);
            delete req.query.mine;
        }

        var queryParts = [];
        res.locals.search = {
            status: '',
            queue: '',
            text: '',
            external_id: '',
            tenant: '',
            id: '',
            fromdate:'',
            todate:''
        };
        for (var key in req.query) {
            if (['page', 'mine','fromdate','todate','subject'].indexOf(key) == -1 && req.query.hasOwnProperty(key)) {
                var modKey = (key == 'queue' ? 'q.name' : key) + ' = ?';
                modKey = (key == 'id' ? 'i.id = ?' : modKey);

                if (req.query[key] && req.query[key].length) {
                    queryParts.push(modKey);
                    values.push(req.query[key]);
                    res.locals.search[key] = req.query[key];
                }
            }
        }
        query += queryParts.length ? ' AND ' + queryParts.join(' AND ') : '';
        var fromDate=new moment(req.query.fromdate,"MM/DD/YYYY hh:mm a");
        var toDate=new moment(req.query.todate,"MM/DD/YYYY hh:mm a");
        if(fromDate.isValid()&&toDate.isValid()){
            if(fromDate>toDate){
                return res.render('issues/index', {
                    err: "From date should not be grater then To date"
                });
            }else{
                query+=" AND UNIX_TIMESTAMP(i.created_on)>= ? AND UNIX_TIMESTAMP(i.created_on)<= ?";
                values.push(fromDate.unix(),toDate.unix());
                res.locals.search.fromdate = req.query.fromdate;
                res.locals.search.todate = req.query.todate;
            }
        }else if(fromDate.isValid()){
            query+=" AND UNIX_TIMESTAMP(i.created_on)>= ?";
            values.push(fromDate.unix());
            res.locals.search.fromdate = req.query.fromdate;
        }else if(toDate.isValid()){
            query+=" AND UNIX_TIMESTAMP(i.created_on)<= ?";
            values.push(toDate.unix());
            res.locals.search.todate = req.query.todate;
        }

        if (req.query.subject && req.query.subject.length) {
            query += ' AND (i.subject LIKE ? OR i.description LIKE ?)'
            values.push('%' + req.query.subject + '%');
            values.push('%' + req.query.subject + '%');
            res.locals.search.text = req.query.subject;
        }

        var countQuery = query;
        countQuery = 'SELECT count(*), ' + query;

        query += ' ORDER BY issueid DESC LIMIT ' + res.locals.pagerDetails.from + ',' + res.locals.pagerDetails.pageSize;
        query = 'SELECT ' + query;
        db._query(query, values, function(err, data) {
            if (err) {
                return res.render('issues/index', {
                    err: err
                });
            }
            db._query(countQuery, values, function(err, countData) {
                if (err) {
                    return res.render('issues/index', {
                        err: err
                    });
                }

                // Change pager details to support queries
                res.locals.pagerDetails.totalRecords = countData && countData[0] && countData[0]['count(*)'];
                var queryKeys = Object.keys(req.query);
                res.locals.pagerDetails.url = 'issues?' + queryKeys.map(function(item) {
                    return item == 'page' ? '' : item + '=' + req.query[item];
                }).join('&') + '&';

                var users = data.map(function(item) {
                    return item.current_owner;
                }).filter(function(item) {
                    return item !== null && item !== undefined;
                });

                function handleUsers(users) {
                    if (users && users.length) {
                        var userKeys = {};
                        users.forEach(function(item) {
                            userKeys[item.id] = item.name;
                        });

                        data.forEach(function(item) {
                            if (item.current_owner !== undefined && userKeys[item.current_owner])
                                item.currentOwner = userKeys[item.current_owner];
                            item.currentOwner = item.currentOwner || '';
                        });
                    } else {
                        data.forEach(function(item) {
                            item.currentOwner = '';
                        });
                    }

                    res.render('issues/index', {
                        issues: data
                    });
                };

                if (users.length) {
                    db._query('SELECT id, name FROM users WHERE active = true AND id IN (' + users.map(function() {
                        return '?';
                    }) + ')', users, function(err, users) {
                        if (err) {
                            return res.render('issues/index', {
                                err: err
                            });
                        }
                        handleUsers(users);
                    });
                } else
                    handleUsers();
            });
        });
    };

    if (displayQueue != '*') {
        db._query('select id from queues where project = ? and name = ?', [project, displayQueue], function(err, results) {
            if (err)
                return res.render('issues/index', {
                    err: err
                });

            var queueId = results && results[0] && results[0].id;
            if (!queueId)
                return res.render('issues/index', {
                    err: 'No such queue'
                });

            getIssuesForQueue(queueId);
        });
    } else
        getIssuesForQueue();
}

var getQueues = function(projectConfig, callback) {
    if (!callback && projectConfig && projectConfig.call) {
        callback = projectConfig;
        projectConfig = null;
    }

    db._query('SELECT * FROM queues', [], function(err, data) {
        if (err)
            return callback(err);

        if (projectConfig) {
            var flowConfig = projectConfig;
            if (flowConfig && flowConfig.issues && flowConfig.issues.fields && flowConfig.issues.fields.defaults && flowConfig.issues.fields.defaults.queue) {
                var defaultQueue = flowConfig.issues.fields.defaults.queue.toLowerCase();
                data.every(function(item) {
                    var isDefaultQueue = item.name.toLowerCase() == defaultQueue;
                    if (isDefaultQueue) {
                        item['default'] = true;
                    }
                    return !isDefaultQueue;
                });
            }
        }

        callback(null, data);
    });
};

var details = function(req, res) {
    res.locals.errOnly = true;

    //   var statusdata = ["Dev", "Testing", "Released", "Hold"];

    var uid = req.params.id;
    var currentOwner = '';
    if (!uid)
        return res.render('issues/create', {
            err: 'No such issue'
        });

    async.parallel({
        queues: function(callback) {
            getQueues(res.locals.projectConfig, callback);
        },
        issuedata: function(callback) {
            if (uid == 'new')
                return callback(null, 'new');

            db.select('issues', ['*'], ['id'], [uid], 'LIMIT 1', function(err, issuedata) {
                if (err)
                    return callback(err);
                return callback(null, issuedata);
            });
        },
        activitydata: function(callback) {
            if (uid == 'new')
                return callback(null, 'new');
            db._query('SELECT * FROM compassdb.issue_activity WHERE issue_activity.issue = ? ORDER BY issue_activity.created_on DESC', [uid], function(err, activitydata) {
                if (err)
                    return callback(err);

                var users = [];
                activitydata.forEach(function(item) {
                    if (users.indexOf(item.assigned_by) == -1)
                        users.push(item.assigned_by);
                    if (users.indexOf(item.assigned_to) == -1)
                        users.push(item.assigned_to);
                });

                db._query('SELECT id,name FROM users WHERE active = true AND id IN (' + users.map(function() {
                    return '?';
                }).join(',') + ')', users, function(err, users) {
                    var userKeys = {};
                    users.forEach(function(user) {
                        userKeys[user.id] = user.name;
                    });

                    activitydata.forEach(function(item) {
                        item.assigned_to = userKeys[item.assigned_to];
                        item.assigned_by = userKeys[item.assigned_by];

                        var isCurrent = item.isCurrent == 1;
                        if (isCurrent)
                            currentOwner = item.assigned_to;
                    });

                    return callback(null, activitydata);
                });
            });
        }
    }, function(err, data) {
        if (err)
            return res.render('issues/create', {
                err: err
            });

        if (data.issuedata != 'new' && (!data.issuedata[0]))
            return res.render('issues/create', {
                err: 'No such issues.'
            });

        res.locals.errOnly = false;
        res.locals.pageTitle = 'New Issue';

        if (data.issuedata == 'new') {
            var flowConfig = req.session && req.session.user && req.session.user.project && req.session.user.project.flowConfig;
            var defaultStatus = (flowConfig && flowConfig.issues && flowConfig.issues.fields && flowConfig.issues.fields.defaults && flowConfig.issues.fields.defaults.status) || '';

            var defaultForm = {
                subject: '',
                externalID: '',
                tenant: '',
                externalURL: '',
                description: '',
                externalCategory: '',
                externalSeverity: '',
                queue: null,
                severity: '',
                status: defaultStatus
            };

            if (req.session.incompleteForm) {
                for (var key in req.session.incompleteForm) {
                    if (req.session.incompleteForm.hasOwnProperty(key))
                        defaultForm[key] = req.session.incompleteForm[key];
                }
            }

            delete req.session.incompleteForm;

            return res.render('issues/details', {
                queues: data.queues,
                err: req.query.msg ? msgLib.issues[req.query.msg] : null,
                data: defaultForm
            });
        }

        res.locals.pageTitle = data.issuedata[0].external_id + ': ' + data.issuedata[0].subject;
        res.render('issues/details', {
            issue: data.issuedata[0],
            queues: data.queues,
            activity: data.activitydata,
            currentOwner: currentOwner
        });
    });
};

var create = function(req, res) {
    var project = req.session.user.project.id;

    //project = parseInt(project) || 1;
    //  queue = getQueueId(project, "Need to Work", next) || 1;
    //queue = "Need to Work";

    var defaultQueue;

    function createIssue() {
        var mandatoryFields = ['subject', 'externalID', 'tenant', 'description', 'queue'];

        mandatoryFields = mandatoryFields.filter(function(item) {
            var val = req.body[item];
            return (!val.length || (item == 'queue' && !parseInt(val)));
        });

        req.session.incompleteForm = req.body;
        if (mandatoryFields.length)
            return res.redirect('/issues/new?msg=mandatoryFields');

        delete req.session.incompleteForm;

        var externalId = req.body['externalID'];
        var externalUrl = req.body['externalURL'];
        var externalcategory = req.body['externalCategory'];
        var externalseverity = req.body['externalSeverity'];

        var subject = req.body['subject'];
        var description = req.body['description'];

        var tenant = req.body['tenant'];
        var severity = req.body['severity'];
        var status = "New";
        var queue = req.body.queue || defaultQueue;

        db.insert('issues', ['external_id', 'external_url', 'external_category', 'external_severity', 'subject', 'description', 'tenant', 'project', 'severity', 'status', 'queue', 'created_by', 'created_on'], [externalId, externalUrl, externalcategory, externalseverity, subject, description, tenant, project, severity, status, queue, req.session.user.name, new Date()], function(err, data) {
            if (err || !(data && data.insertId))
                return res.render('issues', {
                    err: 'Server error. Failed to create issue. Try later.'
                });

            addNewIssueAssignment(data.insertId, 'New Issue Created', null, req.session.user.name, function(err, data) {
                if (err)
                    return res.render('issues', {
                        err: 'Server error. Failed to create issue activity. Try later.'
                    });

                return res.redirect('/issues');
            });
            // changeCurrentOwner(externalId,status);
        });
    }

    if (!req.body.queue || !req.body.queue.length) {
        getQueues(res.locals.projectConfig, function(err, data) {
            if (!err && data && data.length) {
                data.every(function(item) {
                    var isDefault = item['default'];
                    if (isDefault)
                        defaultQueue = item;
                    return !isDefault;
                });
                createIssue();
            } else
                createIssue();
        });
    } else
        createIssue();
};
var update = function(req, res) {
    var uid = req.params.id;
    uid = uid && parseInt(uid);

    if (!uid || isNaN(uid))
        return res.render('issues/index', {
            err: 'No such issues'
        });

    var incomingForm = {};
    var incomingFields = [];
    var incomingValues = [];

    incomingForm['queue'] = req.body['queue'] || 1;
    incomingForm['queue'] = parseInt(incomingForm['queue']) || 1;
    incomingForm['project'] = req.session.user.project.id;
    incomingForm['external_id'] = req.body['externalID'];
    incomingForm['external_url'] = req.body['externalURL'];
    incomingForm['external_category'] = req.body['externalCategory'];
    incomingForm['external_severity'] = req.body['externalSeverity'];

    incomingForm['subject'] = req.body['subject'];
    incomingForm['description'] = req.body['description'];
    incomingForm['tenant'] = req.body['tenant'];
    incomingForm['severity'] = req.body['severity'];

    incomingForm['modified_on'] = new Date();
    incomingForm['modified_by'] = req.session.user.name;

    for (var key in incomingForm) {
        if (incomingForm.hasOwnProperty(key)) {
            if (incomingForm[key] !== null && incomingForm[key] !== undefined) {
                incomingFields.push(key);
                incomingValues.push(incomingForm[key]);
            }
        }
    }

    db.update('issues', incomingFields, incomingValues, ['id'], [uid], function(err, data) {
        if (err)
            return res.render('issues/error');

        return res.redirect('/issues/' + uid);
    });
};

/*
var assignIssueToDeveloper = function(req, res) {
    var issueId = req.query["issueId"];
    var comments = req.query["comments"];
    var created_by = modified_by = req.session.user.name;
    var assigned_by = req.session.user.id;

    var assigned_to = req.query["assignee"];

    var created_on = modified_on = new Date();
    if (!(issueId instanceof Array)) {
        issueId = [issueId];
    }
    issueId.forEach(function(id) {
        addNewIssueAssignment(id, comments, assigned_to, assigned_by, req.session.user.name);
        changeIssueStatus(id, "Open");
        changeIssueQueue(id, "Need To Work", "Dev", comments, req.session.user.project.id, req.session.user.name);
    });
    //   changeCurrentOwner(issueId,"Open");
    return res.redirect('/issues');

}


var assignIssueToQA = function(req, res) {
    var comments = req.body["comments"];
    var issueId = req.body["issueId"];
    var steps = req.body["testcase"];
    var environment = req.body["environment"];
    addTestCases(issueId, environment, steps, comments, req.session.user.name)
    changeIssueQueue(issueId, "Dev", "QA", comments, req.session.user.project.id, req.session.user.name);
    changeIssueStatus(issueId, "QA-pending");
    changeCurrentOwner(issueId, "QA-pending");
    res.json({
        success: true
    });
}

var takeIssue = function(req, res) {
    var issueId = req.body["issueId"];
    //var comments = req.body["comments"];
    var assigned_by = null;

    if (!(issueId instanceof Array)) {
        issueId = [issueId];
    }
    issueId.forEach(function(id) {
        db._query('select assigned_to from issue_activity where issue = ? and isCurrent = 1 order by created_on desc', [id], function(err, results) {
            if (err)
                return res.render('issues/index', {
                    err: err
                });
            assigned_by = results[0].assigned_to;
            addNewIssueAssignment(issueId, "", req.session.user.id, assigned_by, req.session.user.name);
        });
    });

    return res.redirect('/issues');
}

var addTestCases = function(issueId, environment, steps, comments, user) {
    db.insert('issue_test_case', ['issue', 'environment', 'steps', 'comments', 'created_by', 'created_on', 'modified_by', 'modified_on'], [issueId, environment, steps, comments, user, new Date(), user, new Date()], function(err, data) {
        if (err) {
            return false;
        } else {
            return true;
        }
    });
}

var changeIssueStatus = function(issueId, toStatus, user) {
    db.update('issues', ['status', 'modified_by', 'modified_on'], [toStatus, user, new Date()], ['id'], [issueId], function(err, data) {
        if (err) {
            return false;
        }
        return true;
    });
}

var changeCurrentOwner = function(issueid, status) {
    async.waterfall([

        function(callback) {
            if (status == 'New' || status == 'Fixed') {
                user = "Anusha Saravanan";
                db.update('issues', ['current_owner'], [user], ['external_id'], [issueid], function(err, data) {
                    if (err) {
                        return false;
                    }
                    return true;
                });
            } else if (status == 'Released') {
                user = "Client";
                callback(null, user);
            } else {
                user = db._query('SELECT name from users where users.id IN (SELECT assigned_to FROM issues, issue_activity where issues.id = issue_activity.issue AND issue_activity.issue = ? AND issue_activity.isCurrent = 1 order by issue_activity.created_on desc)', [issueid], function(err, results) {
                    if (err) {
                        return res.render('issues/index', {
                            err: err
                        });
                    }
                    user = results[0] && results[0].name;
                    callback(null, user);
                });
            }
        },

        function(user) {
            db.update('issues', ['current_owner'], [user], ['id'], [issueid], function(err, data) {
                if (err) {
                    return false;
                }
                return true;
            });
        }
    ], function(err, result) {
        // result now equals 'done'
    });
}

var changeIssueQueue = function(issueId, fromQueue, toQueue, comments, project, user, callback) {
    async.parallel({
        fromQueueId: function(next) {
            getQueueId(project, fromQueue, next);
        },
        toQueueId: function(next) {
            getQueueId(project, toQueue, next);
        }
    }, function(err, data) {
        if (err)
            return callback(err);

        db.insert('issue_queues', ['from_queue', 'to_queue', 'comments', 'created_by', 'created_on', 'modified_by', 'modified_on', 'issue'], [data.fromQueueId, data.toQueueId, comments, user, new Date(), user, new Date(), issueId], function(err, dbData) {
            if (err) {
                console.log("Issue queue update error : " + err);
            } else {
                db.update('issues', ['queue', 'modified_by', 'modified_on'], [data.toQueueId, user, new Date()], ['id'], [issueId], function(err, data) {
                    if (err) {
                        return false;
                    }
                    return true;
                });
            }
        });
    });
}

var releaseIssue = function(req, res) {
    var issueId = req.body["issueId"];
    var comments = req.body["comments"];

    if (!(issueId instanceof Array)) {
        issueId = [issueId];
    }
    issueId.forEach(function(id) {
        changeIssueQueue(issueId, "To Be Released", "Released", comments, req.session.user.project.id, req.session.user.name);
    });


    // changeCurrentOwner(issueId,"Released");

    return res.redirect('/issues');
};

var reopenIssue = function(req, res) {
    var issueId = req.body["issueId"];
    var comments = req.body["comments"];

    if (!(issueId instanceof Array)) {
        issueId = [issueId];
    }
    issueId.forEach(function(id) {
        changeIssueQueue(issueId, "Released", "Need To Work", comments, req.session.user.project.id, req.session.user.name);
    });
    // changeCurrentOwner(issueId,"New");

    return res.redirect('/issues');
};

var resolveIssue = function(req, res) {
    var result = req.body["result"];
    var issueid = req.body["issueId"];
    var comments = req.body["comments"];

    if (result == "pass") {
        changeIssueStatus(issueid, "Fixed", req.session.user.name);
        changeIssueQueue(issueid, "QA", "To Be Released", comments, req.session.user.project.id, req.session.user.name);
        //  changeCurrentOwner(issueid,"Fixed");
        changeIssueQueue(issueid, "QA", "To Be Released", comments, req.session.user.project.id, req.session.user.name);
        // changeCurrentOwner(issueid,"Fixed");
        res.status(200).json({
            success: true
        });
    } else {
        // If the issue fails assign it back to developer
        var developer = null;

        var runQuery = function() {
            changeIssueStatus(issueid, "Failed", req.session.user.name);
            changeIssueQueue(issueid, "QA", "Dev", comments, req.session.user.project.id, req.session.user.name);
            addNewIssueAssignment(issueid, comments, developer, req.session.user.id, req.session.user.name);
            res.status(200).json({
                success: true
            });
        }

        db._query('select assigned_by from issue_activity where issue = ? and isCurrent = 1', [issueid], function(err, results) {
            if (err)
                return res.render('issues/index', {
                    err: err
                });
            developer = results[0].assigned_by;
            runQuery();
        });
    }
}
*/

var getQueueId = function(projectId, queueName, next) {
    db._query('select * from queues where project = ? and name = ?', [projectId, queueName], function(err, results) {
        next(err, results && results[0] && results[0].id);
    });
};

var addNewIssueAssignment = function(issueId, comments, assigned_to, user, callback) {
    // Before a new assignment we need to cancel all previous assignment of that issue by making is current = 0.
    db.update('issue_activity', ['isCurrent', 'modified_by', 'modified_on'], [0, user, new Date()], ['issue'], [issueId], function(err, data) {
        if (err)
            return callback(err);

        db.insert('issue_activity', ['issue', 'comments', 'assigned_to', 'assigned_by', 'isCurrent', 'created_by', 'created_on', 'modified_by', 'modified_on'], [issueId, comments, assigned_to, user, 1, user, new Date(), user, new Date()], function(err, data) {
            if (err)
                return callback(err);

            callback();
        });
    });
}

var remove = function(req, res) {
    var uid = req.params.id;
    if (!uid)
        return res.render('issues/index', {
            err: 'No such issue'
        });
    db.update('issues', ['status', 'modified_by', 'modified_on'], ["Deleted", req.session.user.name, new Date()], ['id'], [uid], function(err, data) {

        if (err)
            return res.render('issues/index', {
                err: err
            });

        res.status(200).json({
            success: true
        });
    });
};

var permissions = function(req, res, next) {
    res.locals.permissions = req.session.permissions && req.session.permissions.issues ? req.session.permissions.issues : {
        create: false,
        read: true,
        update: false,
        del: false
    };

    next();
};

/*
var getfullActivity = function(req, res) {
    //var role = req.query['role'] || 1;
    var uid = req.params.id;

    db.select('issue_activity', ['comments', 'created_by', 'created_on', 'modified_on', 'modified_by'], ['issue'], [uid], null, function(err, data) {
        if (err) {
            res.json({
                err: err
            });
        } else {
            res.json({
                data: data
            });
        }
    });
};
*/

var nextFlowState = function(req, res) {
    var issueIds = req.body.issues;
    if (!issueIds.length) {
        return res.json({
            err: 'Atleast one issue has to be selected.'
        });
    }

    var action = req.params.action;
    var user = req.session && req.session.user && req.session.user.id;
    var project = req.session && req.session.user && req.session.user.project && req.session.user.project.id;
    var actionFlow = res.locals.projectConfig;
    actionFlow = actionFlow && actionFlow.issues && actionFlow.issues.flows && actionFlow.issues.flows[action];

    if (!actionFlow) {
        return res.json({
            err: 'No such action.'
        });
    }

    // Creates the conditions that should be met by all issues in order to proceed to next flow state
    var conditions = {};
    if (actionFlow.conditions) {
        var conditionFields = Object.keys(actionFlow.conditions);
        for (var i = conditionFields.length - 1; i >= 0; --i) {
            var fieldName = conditionFields[i];
            conditions[fieldName] = {
                equals: [],
                notEquals: []
            };

            var fieldValues = actionFlow.conditions[fieldName];
            for (var j = fieldValues.length - 1; j >= 0; --j) {
                var condition = fieldValues[j];
                var type = 'equals';
                if (condition[0] == '!') {
                    type = 'notEquals';
                    condition = condition.substr(1);
                }
                conditions[fieldName][type].push(condition);
            }
        }
    }

    // Retrieve issues
    db._query('SELECT * FROM issues WHERE issues.id IN (' + issueIds.map(function() {
        return '?';
    }).join(',') + ')', issueIds, function(err, data) {
        if (err) {
            return res.json({
                err: 'Server Error. Failed to retrieve issues.'
            });
        }

        var issues = data;
        if (!(issues && issues.length)) {
            return res.json({
                err: 'Invalid issue numbers.'
            });
        }

        // Check conditions
        var errors = [];
        var conditionFields = Object.keys(conditions);
        for (var i = conditionFields.length - 1; i >= 0; --i) {
            var fieldName = conditionFields[i];
            var fieldValues = conditions[fieldName];

            issues.forEach(function(issue) {
                var issueHas = !fieldValues.equals.length || (issue[fieldName] && fieldValues.equals.indexOf(issue[fieldName]) > -1);
                var issueDoesntHave = !fieldValues.notEquals.length || (!issue[fieldName] || fieldValues.notEquals.indexOf(issue[fieldName]) == -1);

                if (!issueHas)
                    errors.push(fieldName + ' should be ' + fieldValues.equals.join(' or ') + '.');
                if (!issueDoesntHave)
                    errors.push(fieldName + ' should not be ' + fieldValues.notEquals.join(' or ') + '.');
            });
        }

        if (errors.length) {
            return res.json({
                err: errors
            });
        }

        var queues = [];
        var changedFields = {};
        issues.forEach(function(issue) {
            if (actionFlow.transitions) {
                var transitionFields = Object.keys(actionFlow.transitions);
                transitionFields.forEach(function(fieldName) {
                    var currentValues = Object.keys(actionFlow.transitions[fieldName]);

                    var originalFieldVal = issue[fieldName];
                    var idx = currentValues.indexOf(issue[fieldName]);
                    if (issue[fieldName] && idx > -1) {
                        issue[fieldName] = actionFlow.transitions[fieldName][currentValues[idx]];
                    } else if (currentValues.indexOf('*') > -1) {
                        issue[fieldName] = actionFlow.transitions[fieldName]['*'];
                    }

                    if (issue[fieldName][0] == '$') {
                        var postVarName = issue[fieldName].substr(1);
                        issue[fieldName] = parseInt(req.body[postVarName]) || null;
                    }

                    if (issue[fieldName] == '@user') {
                        issue[fieldName] = user;
                    }

                    if (fieldName == 'queue' && queues.indexOf(issue[fieldName]) == -1)
                        queues.push(issue[fieldName]);

                    if (issue[fieldName] != originalFieldVal) {
                        changedFields[issue.id] = changedFields[issue.id] || [];
                        changedFields[issue.id].push(fieldName);
                    }
                });
            }
        });

        function saveIssue(queues) {
            var assignedTo;
            if (actionFlow.sideEffects && actionFlow.sideEffects.activity && actionFlow.sideEffects.activity.assignedTo) {
                if (actionFlow.sideEffects.activity.assignedTo[0] == '$') {
                    var postVarName = actionFlow.sideEffects.activity.assignedTo.substr(1);
                    assignedTo = parseInt(req.body[postVarName]) || null;
                }
                if (actionFlow.sideEffects.activity.assignedTo == '@user') {
                    assignedTo = user;
                }
            }

            var save = [];
            issues.forEach(function(issue) {
                if (queues[issue.queue] !== undefined)
                    issue.queue = queues[issue.queue];

                //Save issues
                save.push((function(issue) {
                    return function(next) {
                        var previousOwner;

                        function saveThisIssue() {
                            addNewIssueAssignment(issue.id, req.body.comments || '', assignedTo, user, function(err, data) {
                                if (err)
                                    return next(err);

                                if (!changedFields[issue.id])
                                    return next();

                                var changedValues = changedFields[issue.id].map(function(item) {
                                    return issue[item];
                                });

                                db.update('issues', changedFields[issue.id], changedValues, ['id'], [issue.id], function(err, data) {
                                    if (!err) {
                                        // Execute sideeffectsmysql return after update
                                        if (actionFlow.sideEffects) {
                                            var notifications = actionFlow.sideEffects.notify;

                                            function buildTemplateVars(obj) {
                                                var templateVars = {};
                                                for (var key in obj) {
                                                    if (obj.hasOwnProperty(key)) {
                                                        var val = obj[key];
                                                        if (typeof val !== 'string') {
                                                            templateVars[key] = buildTemplateVars(val);
                                                        }
                                                        if (val[0] == '#') {
                                                            templateVars[key] = issue[val.substr(1)];
                                                        } else if (val[0] == '$') {
                                                            var postVarName = val.substr(1);
                                                            templateVars[key] = req.body[postVarName];
                                                        } else if (val == '@user') {
                                                            templateVars[key] = user;
                                                        }
                                                    }
                                                }
                                                return templateVars;
                                            };

                                            if (notifications) {
                                                for (var i = 0; i < notifications.length; ++i) {
                                                    var notification = notifications[i];
                                                    //build templateVars
                                                    if (notification.template && notification.template.key && notification.template.values) {
                                                        var templateVars = buildTemplateVars(notification.template.values);
                                                        var to = notification.to;

                                                        if (to[0] == '$') {
                                                            var postVarName = to.substr(1);
                                                            to = parseInt(req.body[postVarName]) || null;
                                                        } else if (to == '@user') {
                                                            to = user;
                                                        } else if (to == '@assignee') {
                                                            to = assignedTo;
                                                        } else if (to == '@previousOwner') {
                                                            to = previousOwner;
                                                        }
                                                        if (to) {
                                                            db._query('SELECT email FROM users WHERE active = true AND id=?', [to], function(err, data) {
                                                                if (!err && data[0] && data[0].email) {
                                                                    to = data[0].email;
                                                                    mail.send(to, notification.template.key, templateVars, project);
                                                                }
                                                            });
                                                        }
                                                    }
                                                }
                                            }
                                        };
                                    }
                                    next(err, data);
                                });
                            });
                        };

                        function getPreviousOwner(issueId) {
                            db._query('SELECT assigned_by FROM issue_activity WHERE issue = ? AND assigned_by <> ? ORDER BY issue_activity.created_on DESC LIMIT 1', [issueId, user], function(err, data) {
                                if (!err && data && data[0] && data[0].assigned_by) {
                                    var _previousOwner = data[0].assigned_by;
                                }

                                previousOwner = _previousOwner;
                                assignedTo = _previousOwner;

                                saveThisIssue();
                            });
                        };

                        if (!assignedTo && actionFlow.sideEffects && actionFlow.sideEffects.activity && actionFlow.sideEffects.activity.assignedTo && actionFlow.sideEffects.activity.assignedTo == '@previousOwner') {
                            getPreviousOwner(issue.id);
                        } else {
                            var notifyTo = actionFlow.sideEffects && actionFlow.sideEffects.notify && actionFlow.sideEffects.notify.length && actionFlow.sideEffects.notify.map(function(item) {
                                return item.to;
                            });
                            if (notifyTo && notifyTo.length && notifyTo.indexOf('@previousOwner') > -1) {
                                getPreviousOwner(issue.id)
                            } else
                                saveThisIssue();
                        }

                    }
                })(issue));
            });

            async.parallel(save, function(err, data) {
                if (err) {
                    return res.json({
                        err: 'Failed to save issues.'
                    });
                }

                res.json({
                    success: true,
                    data: data
                });
            });
        };

        //Get all queues
        if (queues.length) {
            db._query('SELECT id, name FROM queues WHERE queues.name IN (' + queues.map(function() {
                return '?'
                currentOwner
            }).join(',') + ') AND queues.project = ?', queues.concat([
                [project]
            ]), function(err, data) {
                if (err) {
                    return res.json({
                        err: 'Failed to retrieve queues.'
                    });
                }

                if (!data || !data.length) {
                    return res.json({
                        err: 'No such queues.'
                    });
                }

                var queues = {};
                data.forEach(function(item) {
                    queues[item.name] = item.id;
                });

                saveIssue(queues);
            });
        } else
            saveIssue({});
    });
};

module.exports = {
    register: function(app) {
        // Register all routes
        app.get('/issues', permissions, paginate, list);
        app.post('/issues', permissions, create);
        /*
        app.post('/issues/assignToDeveloper', permissions, assignIssueToDeveloper);
        app.post('/issues/assignToQA', permissions, assignIssueToQA);
        app.post('/issues/reopenIssue', permissions, reopenIssue);
        app.post('/issues/releaseIssue', permissions, releaseIssue);
        app.post('/issues/take', permissions, takeIssue);
        app.post('/issues/resolve', permissions, resolveIssue);
        */
        app.get('/issues/:id', permissions, details);
        app.post('/issues/:id', permissions, update);
        app.post('/issues/flow/:action', permissions, nextFlowState);
        app.delete('/issues/:id', permissions, remove);
        //app.get('/issues/:id/getfullActivity', getfullActivity);

    }
};
