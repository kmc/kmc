// Takes care of downloading a file from the web and placing it locally.
var Downloader = {};

var Promise = require('bluebird');
var request = Promise.promisifyAll(require('request'));
var fs = Promise.promisifyAll(require('fs'));

// Downloads a file from the remote url `downloadUrl` to the local destination
// (output) path `destPath`.
Downloader.downloadFile = function(downloadUrl, destPath) {
  return request.getAsync(downloadUrl).then(function(response) {
    var body = response[1];

    return fs.writeFileAsync(destPath, body);
  });
}

module.exports = Downloader;
