var system = require('system');
var page = require('webpage').create();

var target = system.args[1];

page.open(target, function() {
  console.log(page.content);
  phantom.exit();
});
