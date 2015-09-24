var mysql = require('mysql2');
var config = require('../config/app.js').db;
//var connectionString = 'tcp://' + config.user + ':' + config.pass + '@' + config.host + '/' + config.name;
var connectionPool = mysql.createPool({
    host: 'localhost',
    user: config.user,
    password: config.pass,
    database: config.name
});

var buildSelectorString = function(selectors, values, starter) {
    var selector = [];
    if (!starter) starter = 0;
    ++starter;
    if (typeof selectors != 'string') {
        selectors.forEach(function(s, i) {
            selector.push(s + ' = ?');
        });
        selector = selector.join(' AND ');
    } else
        selector = selectors + ' = ?';
    if (typeof values == 'string')
        values = [values];
    return {
        s: selector,
        v: values
    };
};

var valueSelectorString = function(count) {
    var vals = [];
    for (var i = 1; i <= count; ++i)
        vals.push('?');
    return '(' + vals.join(', ') + ')';
};

var executeQuery = function(queries, keys, index, callback) {
    index = index || 0;
    var next = keys[index] ? queries[keys[index]] : null;
    if (!next)
        return callback(null, queries);
    db._query(next.query, next.values, function(err, results) {
        results = results && results.rows ? (results.rows.length == 1 ? results.rows[0] : results.rows) : null;
        queries[keys[index]] = next.fn ? next.fn(err, results, queries) : results;
        executeQuery(queries, keys, ++index, callback);
    });
};

var db = {
    _parameterizeQuery: function(fields, start) {
        start = start || 0;
        return fields.map(function(e, i) {
            return '?';
        }).join(', ');
    },
    _query: function(query, values, callback) {

        if (!callback && values && typeof values == 'function')
            callback = values, values = null;
        connectionPool.getConnection(function(err, client) {
            var callbackWrapper = function(err, result) {
                client.release();
                callback(err, result);
            };
            if (err) {
                callback(err, null);
            } else {
                if (values) {
                    client.query(query, values, callbackWrapper);
                } else
                    client.query(query, callbackWrapper);
            }
        });
    },
    upsert: function(table, selectors, fields, values, casts, callback) {
        var vals = [],
            nsf = [],
            i = 0,
            casts = casts ? casts : [],
            sfs = [],
            nfs = [];
        for (var f = 0; f < fields.length; ++f) {
            vals.push(casts[f] ? 'CAST($' + (++i) + ' AS ' + casts[f] + ')' : '$' + (++i));
            if (selectors.indexOf(fields[f]) == -1)
                nsf.push(fields[f] + ' = nt.' + fields[f]);
        }
        for (var i = 0, l = selectors.length; i < l; ++i) {
            sfs.push('up.' + selectors[i] + ' = new_table.' + selectors[i]);
            nfs.push('t.' + selectors[i] + ' = nt.' + selectors[i]);
        }
        var ftext = fields.join(', ');
        var query = 'WITH new_table (' + ftext + ') AS (values (' + vals.join(', ') + ')), ' +
            'upsert AS (UPDATE ' + table + ' t SET ' + nsf.join(', ') + ' FROM new_table nt WHERE ' + nfs.join(' AND ') + ' RETURNING t.*) ' +
            'INSERT INTO ' + table + ' (' + ftext + ') SELECT * FROM new_table WHERE NOT EXISTS ' +
            '(SELECT 1 FROM upsert up WHERE ' + sfs.join(' AND ') + ')';
        db._query(query, values, callback);
    },
    insert: function(table, fields, values, callback) {
        var query = 'INSERT INTO ' + table + ' (' + fields.join(', ') + ') values' + valueSelectorString(fields.length);
        db._query(query, values, callback);
    },
    update: function(table, fields, values, selectors, selvalues, callback) {
        var vals = [],
            sf = [],
            count = fields.length;
        for (var i = 0; i < count; ++i)
            sf.push(fields[i] + ' = ?');
        var ss = buildSelectorString(selectors, selvalues, i);
        console.log(ss);
        var query = 'UPDATE ' + table + ' SET ' + sf.join(', ') + ' WHERE ' + ss.s;
        console.log(query);
        for (var v = 0; v < ss.v.length; ++v)
            values.push(ss.v[v]);
        db._query(query, values, callback);
    },
    select: function(table, fields, selectors, values, extras, callback) {
        if (typeof extras == 'function')
            callback = extras, extras = null;
        var ss = buildSelectorString(selectors, values);
        console.log("test123.."+ss);
        var query = 'SELECT ' + fields.join(', ') + ' FROM ' + table + ' WHERE ' + ss.s + (extras ? ' ' + extras : '');
        db._query(query, ss.v, callback);
        console.log(query);
    },
    storedProcedure: function(name, values, callback) {
        values = values.map(function(v) {
            return v && typeof v == 'object' ? JSON.stringify(v) : v;
        });
        db._query('SELECT * FROM ' + name + valueSelectorString(values ? values.length : 0), values, function(err, results) {
            var parser = function(string) {
                return JSON.parse(string, function(k, v) {
                    return k.substr(-3).toLowerCase() == '_at' ? new Date(v) : v;
                });
            };
            if (results && results.rows)
                results = results.rows.length == 1 ? parser(results.rows[0][name]) : results.rows.map(function(e) {
                    return parser(e[name]);
                });
            callback(err, results);
        });
    },
    schema: {
        insert: function(schema, table, fields, values, callback) {
            schema = Math.floor(schema);
            if (isNaN(schema)) callback({
                code: 404
            });
            var query = 'INSERT INTO s' + schema + '.' + table + ' (' + fields.join(', ') + ') values' + valueSelectorString(fields.length) + ' RETURNING *';
            db._query(query, values, callback);
        }
    },
    remove: function(table, selectors, values, callback) {
        var ss = buildSelectorString(selectors, values);
        var query = 'DELETE FROM ' + table + ' WHERE ' + ss.s;
        db._query(query, ss.v, callback);
    },
    transaction: function(queries, values, callback) {
        pg.connect(connectionString, function(err, client, done) {
            var callbackWrapper = function(err, result) {
                done(); // Return client to pool
                callback(err, result);
            };
            if (err)
                return callbackWrapper(err, null);

            queries.unshift('BEGIN');
            values.unshift(null);

            setImmediate(function() {
                var transactions = queries.map(function(query, idx) {
                    return function(fn) {
                        client.query(query, values[idx], fn);
                    };
                });

                async.series(transactions, function(err, results) {
                    if (err)
                        client.query('ROLLBACK', null, function(err) {
                            return done(err);
                        });
                    else {
                        client.query('COMMIT', done);
                        results.shift(); // Discard results for BEGIN query;
                    }
                    callback(err, results);
                });
            });
        });
    },
    closePool: function() {
        //Never call closePool in production
        //if(process.env.NODE_ENV == 'dev')
        pg.end();
    }
}
module.exports = db;
