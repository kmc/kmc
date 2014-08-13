/**
 * A PhantomJS script to help find where to download a package's zipfile from.
 * Execute it is:
 *
 *    phantomjs page_fetcher.js <url>
 *
 * This script will "return" a value by sending it to STDOUT.
 *
 * There are two possible outputted values for this script.
 *
 *  1. If an external resource is received, and this external resource is a zip
 *     file (as determined from the HTTP contentType header), then the URL to
 *     that resource is returned.
 *  2. If no external resource is found, then the HTML of the url provided,
 *     after all Javascript has been loaded, is outputted and another script
 *     must take care of determining where the URL of interest is found.
 */

var system = require('system');
var page = require('webpage').create();

var target = system.args[1];

page.onResourceReceived = function(resource) {
  if (resource.contentType === 'application/x-zip-compressed') {
    console.log(resource.url);

    // Exiting immediately will cause errors.
    setTimeout(phantom.exit, 0);
  }
}

page.onInitialized = function() {
  page.evaluate(function() {
    document.addEventListener('DOMContentLoaded', function() {
      window.callPhantom();
    }, false);
  });
}

// This will be called when the DOMContentLoaded is triggered.
page.onCallback = function(data) {
  console.log(page.content);

  phantom.exit();
}

page.open(target);
