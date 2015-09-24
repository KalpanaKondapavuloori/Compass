var cheerio = require('cheerio'),fs=require('fs'),issues = [],issueIds=[],async=require("async"),_db,oldIssues=[],newIssues=[],resultIssues=[];

Number.prototype.padLeft = function(base,chr){
    var  len = (String(base || 10).length - String(this).length)+1;
    return len > 0? new Array(len).join(chr || '0')+this : this;
}

Array.prototype.trim = function(base,chr){
  console.log("Trimming In Progress..");
  var ids = [];
  var count = this.length;
  for(i=0;i<count;i++){
    ids.push(this[i].external_id);
    if(i==count-1){return ids;}
  }
}

    async.waterfall([
        startEngine,
        connectDB,
        checkIssueStatus,
        getNewIssues,
        resolveIssues,
        getNewIssuesToSave,
        saveNewIssues,
        reOpenIssues
    ], function (error, success) {
        if(error){
          console.log(error);  
        }else{
          console.log("This Run is clean");
        }        
        //console.log('Done!');
        console.log("Releasing Db connection");
        _db.end();
    });

function startEngine (next) {

  //Read HTML file and parse it similar to Jquery format...

  var $ = cheerio.load(fs.readFileSync('Issues.html').toString());
  var count = $('tr.dataRow').length;
  $('tr.dataRow').each(function(i, elem) {
    var issueDetails = [];
    $(this).children('.dataCell').each(function(ii,ee){
    //sample += $(this).text()+" - ";
    //issueId,subject,accountName,category,severity
    switch(ii){
      case 0:{
        //sample["issueId"] = $(this).text();
        issueDetails.push($(this).text());
        issueIds.push($(this).text());
        break;
      };
      case 1:{
        //sample["subject"] = $(this).text();
        issueDetails.push($(this).text().replace(/["']/g, ""));
        break;
      };  
      case 2:{
        //sample["accountName"] = $(this).text();
        issueDetails.push($(this).text());
        break;
      };
      case 3:{
        //sample["category"] = $(this).text();
        issueDetails.push($(this).text());
        break;
      };
      case 4:{
        //sample["status"] = $(this).text();
        break;
      };
      case 5:{
        //sample["lastModifiedDate"] = $(this).text();
        break;
      };
      case 6:{
        //sample["owner"] = $(this).text();
        break;
      };
      case 7:{
        //sample["severity"] = $(this).text();
        issueDetails.push($(this).text());
        break;
      };
      case 8:{
        //Injecting Title mannually for Database ...
        issueDetails.push(issueDetails[2]+" - "+issueDetails[0]);

        //Injecting Project as ROD mannually for Database ...
        issueDetails.push("1");

        //Injecting Status mannually for Database ...
        issueDetails.push("0");

        //yyyy-mm-dd hh:mm:ss
        var d = new Date,
          dformat = [d.getFullYear(),(d.getMonth()+1).padLeft(),
                     d.getDate().padLeft()].join('-') +' ' +
                    [d.getHours().padLeft(),
                     d.getMinutes().padLeft(),
                     d.getSeconds().padLeft()].join(':');

        //Injecting createdOn mannually for Database ...
        issueDetails.push(dformat);

        //Injecting ModifiedOn mannually for Database ...
        issueDetails.push(dformat);

        //Injecting CreatedBy ,ModifiedBy , queue, owner mannually for Database ...
        issueDetails.push("11");
        issueDetails.push("11");
        issueDetails.push("1");
        issueDetails.push("11");
        //sample["severityLevel"] = $(this).text();
        break;
      };    
    }
    });
    //console.log(issueDetails);
    issues.push(issueDetails);
    if(i==count-1){next();}
  }); 

}

function connectDB (next) {
  var mysql = require('mysql2');
  _db = mysql.createConnection({
           host: 'localhost',
              user: 'compassapi',
              password: 'compasspassword',
              database: 'compassdb'
        });
  next();
  /*var connectionPool = mysql.createPool({
      host: 'localhost',
      user: 'compassapi',
      password: 'compasspassword',
      database: 'compassdb'
  });
  connectionPool.getConnection(function(err, client) {
    _db = client;
    next(err);
  });*/
  
}

function checkIssueStatus (next) {
  console.log("In checkIssueStatus")
  var query = "SELECT external_id FROM issues where external_id in ("+issueIds.join(',')+")";
  _db.query(query,null , function(err,data){
    oldIssues = data.trim();
    next(err);
  });
}

  function getNewIssues (next) {
    console.log("In getNewIssues")
    newIssues = issueIds.filter( function ( elem ) {
            return oldIssues.indexOf( elem ) === -1;
        });
    console.log("No. Of New Issues : "+newIssues.length);
    next();
  }

  function resolveIssues(next){
    console.log("In resolveIssues")
    var query = "UPDATE issues SET resolve='true', status=1 where external_id NOT IN ('"+issueIds.join("','")+"')";
    _db.query(query,null , function(err,data){
      next(err);
    });
  }

  function getNewIssuesToSave(next){
    //Result Issues are the set of detailed New Issues to be saved in DB...
    console.log("In getNewIssuesToSave");
    var count = issues.length;
    console.log(count+" : "+newIssues.length);
    if(newIssues.length==0 || count==0){
      console.log("No New Issues");
      return next();
    } 
    for(i=0;i<count;i++){
      if(newIssues.indexOf(issues[i][0])!=-1){
        resultIssues.push(issues[i]);
      }
      if(i==count-1){
        return next();
      }
    }
  }

  function saveNewIssues(next){
    console.log("In saveNewIssues");
    if(resultIssues.length==0){
      return next();
    }
    var query = "INSERT INTO issues (external_id, subject, tenant,category,priority,title,project,status,created_on,modified_on,created_by,modified_by,resolve,owner) VALUES ?";
    _db.query(query, [resultIssues], function(err,data){
      return next(err);
    });
  }

  function reOpenIssues(next){
    console.log("Re-Opening Failed Issues...");
    var query1 = "UPDATE issues SET resolve='false', status=2 where resolve=true AND external_id IN ('"+oldIssues.join("','")+"')";
    _db.query(query1, function(err,data){
      return next(err);
    });
  }