// Handles resolving a URL into one where performing a GET would actually return
// the desired file.

var Promise = require('bluebird');
var ChildProcess = Promise.promisifyAll(require('child_process'));
var path = require('path');
var cheerio = require('cheerio');

// Constructs a url resolver from a "human-friendly" URL.
function DownloadUrlResolver(url) {
  this.url = url;
}

// Performs the act of converting a human-friendly URL into a raw downloadable
// URL.
DownloadUrlResolver.prototype.resolve = function() {
  if (this.isMediafire()) {
    return this.fetchPage().then(function(page) {
      return page('.download_link a')[0].attribs.href;
    });
  } else if (this.isDropbox()) {
    return this.fetchPage().then(function(page) {
      return page('#default_content_download_button')[0].attribs.href;
    });
  }
}

DownloadUrlResolver.prototype.isMediafire = function() {
  return this.testUrlContains('mediafire.com');
}

DownloadUrlResolver.prototype.isDropbox = function() {
  return this.testUrlContains('dropbox.com');
}

DownloadUrlResolver.prototype.isCurseforge = function() {
  return this.testUrlContains('curseforge.com');
}

DownloadUrlResolver.prototype.isBox = function() {
  return this.testUrlContains('app.box.com');
}

DownloadUrlResolver.prototype.testUrlContains = function(substring) {
  return this.url.indexOf(substring) > 0;
}

DownloadUrlResolver.prototype.fetchPage = function() {
  var scriptPath = path.resolve(__dirname, 'page_fetcher.js');
  var cmd = ['phantomjs', scriptPath, this.url].join(' ');

  return ChildProcess.execAsync(cmd).then(function(stdout) {
    return cheerio.load(stdout.join(''));
  });
}

module.exports = DownloadUrlResolver;
