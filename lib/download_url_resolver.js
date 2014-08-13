// Handles resolving a URL into one where performing a GET would actually return
// the desired file.
var DownloadUrlResolver = {};

var Promise = require('bluebird');
var ChildProcess = Promise.promisifyAll(require('child_process'));
var request = Promise.promisifyAll(require('request'));
var path = require('path');
var cheerio = require('cheerio');
var _ = require('lodash');

// Performs the act of converting a human-friendly URL into a raw downloadable
// URL.
DownloadUrlResolver.resolve = function(url) {
  if (this.isMediafire(url)) {
    return this.resolveMediafireUrl(url);
  } else if (this.isDropbox(url)) {
    return this.resolveDropboxUrl(url);
  } else if (this.isCurseforge(url)) {
    return this.resolveCurseforgeUrl(url);
  } else if (this.isBox(url)) {
    return this.resolveBoxUrl(url);
  }
}

DownloadUrlResolver.isMediafire = function(url) {
  return testUrlContains(url, 'mediafire.com');
}

DownloadUrlResolver.isDropbox = function(url) {
  return testUrlContains(url, 'dropbox.com');
}

DownloadUrlResolver.isCurseforge = function(url) {
  return testUrlContains(url, 'curseforge.com');
}

DownloadUrlResolver.isBox = function(url) {
  return testUrlContains(url, 'app.box.com');
}

var testUrlContains = function(url, substring) {
  return url.indexOf(substring) > 0;
}

DownloadUrlResolver.resolveMediafireUrl = function(url) {
  return request.headAsync(url).then(function(response) {
    var contentType = response[0].headers['content-type'];

    if (contentType.indexOf('zip') > 0) {
      // this is a "direct" Mediafire URL -- it can be downloaded from directly.
      return url;
    } else {
      // this isn't a direct URL, so we'll need PhantomJS.
      return fetchPage(url).then(function(page) {
        return page('.download_link a')[0].attribs.href;
      });
    }
  });
}

DownloadUrlResolver.resolveDropboxUrl = function(url) {
  return fetchPage(url).then(function(page) {
    return page('#default_content_download_button')[0].attribs.href;
  });
}

DownloadUrlResolver.resolveCurseforgeUrl = function(url) {
  return fetchHtml(url + '/files/latest').then(function(downloadUrl) {
    return downloadUrl.trim();
  });
}

DownloadUrlResolver.resolveBoxUrl = function(url) {
  var boxDownloadUrl = function(sharedName, itemTypedId) {
    var base = 'https://app.box.com/index.php?rm=box_download_shared_file';
    var sharedNamePart = '&shared_name=' + sharedName;
    var itemTypedIdPart = '&file_id=' + itemTypedId;

    return base + sharedNamePart + itemTypedIdPart;
  }

  return request.getAsync(url).then(function(response) {
    var body = response[1];
    var sharedName = _.last(url.split('/'));
    var itemTypedId = body.match(/itemTypedID: \"(f_\d+)\"/)[1];

    return boxDownloadUrl(sharedName, itemTypedId);
  });
}

var fetchPage = function(url) {
  return fetchHtml(url).then(function(html) {
    return cheerio.load(html);
  })
}

var fetchHtml = function(url) {
  var scriptPath = path.resolve(__dirname, 'page_fetcher.js');
  var cmd = ['phantomjs', scriptPath, url].join(' ');

  return ChildProcess.execAsync(cmd).then(function(output) {
    var stdout = output[0];
    return stdout;
  });
}

module.exports = DownloadUrlResolver;
