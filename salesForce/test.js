var fs = require('fs');

//$ = cheerio.load('<h2 class="title">Hello world</h2>');
var casper = require('casper').create({
    pageSettings: {
        loadImages:  false,        // The WebPage instance used by Casper will
        loadPlugins: true         // use these settings
    },
    logLevel: "info",              // Only "info" level messages will be logged
    verbose: false                  // log messages will be printed out to the console
});
casper.options.waitTimeout = 4000;
casper.start('https://login.salesforce.com/');
casper.then(function() {
    this.echo("I'm loaded.");
    this.echo(this.getHTML('title'));
    console.log("Status : "+this.getCurrentUrl());
    this.sendKeys('#username', 'Schakraborty-servicesource@positiveedge.net');
    this.sendKeys('#password', 'SSPassword25');
}).thenClick('#Login')
.then(function(){
    console.log(this.getCurrentUrl());
    if(this.getCurrentUrl() != "https://login.salesforce.com/"){
        this.emit('salesforce.loaded',this.getCurrentUrl());
    }
    else{
        this.emit('salesforce.failed');
    }
});

casper.on('salesforce.failed', function(url) {
    this.echo("Failed To Login Try Again");
});

casper.on('salesforce.loaded', function(url) {
    this.thenOpen("https://servicesource.my.salesforce.com/500/x?fcf=00B60000006l8SA&rolodexIndex=-1&page=1", function() {
        //var data = this.getHTML();
        //this.echo(JSON.stringify(this.getElementInfo('rowsperpage')));
        //this.echo(__utils__.getFieldValue('rowsperpage'));
        //var href = this.evaluate(function(){
        //var element = __utils__.getElementByXPath('//select[(@name, "rowsperpage")]');
        //    return element.value;
        //});
        //console.log(data);
        //fs.write('Issues.html', data, 'w');
        /*var $ = cheerio.load(data, {
    normalizeWhitespace: true,
    xmlMode: true
        });*/
    }).thenOpen("https://servicesource.my.salesforce.com/500/x?fcf=00B60000006l8SA&page=1&rolodexIndex=-1&rpp_sticky=0&rowsperpage=1000",function(){
        var data = this.getHTML();
        fs.write('Issues.html', data, 'w');
    });    
});

casper.run();

