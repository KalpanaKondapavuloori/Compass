var cheerio = require('cheerio'),fs=require('fs'),issues = [],issueIds=[];

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

function getIssuesObject(cb){
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
	  if(i==count-1){cb(issues);}
	});	
}

getIssuesObject(function(data){
	//[ToDo]
	//Save it to Db
	var mysql = require('mysql2');
	var connectionPool = mysql.createPool({
	    host: 'localhost',
	    user: 'compassapi',
	    password: 'compasspassword',
	    database: 'compassdb'
	});
	connectionPool.getConnection(function(err, client) {
		//console.log(err);
		//Check New Issues and Old Issues
		checkIssuesStatus(issueIds,client,function(err,oldIssues){
			getNewIssues(issueIds,oldIssues,function(newIssues){
				console.log("No Of New Issues : "+newIssues.length)
				//Make resolved true if any issues are resolved
				resolveIssues(issueIds,client,function(err,data){
					console.log("Resolving Issues");
					
					//Create New Issues
					console.log(newIssues)
					getIssues(newIssues,issues,function(data){
						var query = "INSERT INTO issues (external_id, subject, tenant,category,priority,title,project,status,created_on,modified_on,created_by,modified_by,resolve,owner) VALUES ?";
						//console.log(data);
						client.query(query, [data], function(err,data){
							console.log("<===================================>");
							//console.log(err);

							//If Old Issues are re-Opened Check it
							console.log("Re-Opening Issues");
							var query1 = "UPDATE issues SET resolve='false', status=2 where external_id IN ('"+oldIssues.join("','")+"')";
							client.query(query1, function(err,data){
								console.log(data);
								client.end();
							});

						});			 
					});
				});
			});
		});
		//Posting issueId,subject,accountName,category,severity,title,Project,Status,createdOn,ModifiedOn,CreatedBy ,ModifiedBy , queue, owner
		/*var query = "INSERT INTO issues (external_id, subject, tenant,category,priority,title,project,status,created_on,modified_on,created_by,modified_by,queue,owner) VALUES ?";
		client.query(query, [data], function(err,data){
			console.log(err);
			console.log("<===================================>")
			console.log(data);
		});*/
	});
});


function checkIssuesStatus(issueIds,client,cb){
	//console.log(issueIds);
	var query = "SELECT external_id FROM issues where external_id in ("+issueIds.join(',')+")";
	client.query(query,null , function(err,data){
		cb(err,data.trim());
	});
}

function getIssues(issueIds,issues,cb){
	var resultIssues = [];
	var count = issues.length;
	if(issueIds.length==0 || count==0)return cb(null);
	for(i=0;i<count.length;i++){
		if(issueIds.indexOf(issues[i][0])!=-1){
			resultIssues.push(ele);
		}
		if(i==count-1){
			console.log("Returning Issues");
			cb(resultIssues);
		}
	}
}

function getNewIssues(issueIds,oldIssues,cb){
	cb(
			issueIds.filter( function ( elem ) {
			    return oldIssues.indexOf( elem ) === -1;
			})
		);
}

function resolveIssues(issueIds,client,cb){
	//console.log(issueIds);
	//UPDATE table_name SET field1=new-value1, field2=new-value2 [WHERE Clause]
	var query = "UPDATE issues SET resolve='true' status=1 where external_id not in ("+issueIds.join(',')+")";
	client.query(query,null , function(err,data){
		cb(err,data);
	});
}