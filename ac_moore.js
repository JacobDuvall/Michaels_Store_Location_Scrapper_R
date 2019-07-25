var page = require('webpage').create();

var fs = require('fs');

var url = 'https://acmoore.com/stores'
var path = 'ac_moore.html'

page.open(url, function(status) {
   var content = page.content;
   fs.write(path, content, 'w')
   phantom.exit();
});