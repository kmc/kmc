var system = require('system');
var page = require('webpage').create();

var target = system.args[1];

var externalResourceProvidedUrl = false;

page.onResourceReceived = function(resource) {
  if (resource.contentType === 'application/x-zip-compressed') {
    externalResourceProvidedUrl = true;

    console.log(resource.url);
  }
}

page.open(target, function() {
  // If this is set to true, then an external resource already provided the
  // desired URL, and nothing more needs to be done -- the URL has already been
  // sent to STDOUT.
  //
  // If done is still false, then the page itself contains the desired URL, so
  // we output the HTML and let Ruby-side Kosmos determine the target URL.
  if (!externalResourceProvidedUrl) {
    console.log(page.content);
  }

  phantom.exit();
});
