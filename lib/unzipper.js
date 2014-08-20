// Takes care of unzipping files.
var Unzipper = {}

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var unzip = require('unzip');

// Given a zip file at `zipFilePath`, extracts its contents to the directory
// `outputPath`.
Unzipper.unzipFile = function(zipFilePath, outputPath) {
  return new Promise(function(fulfill, reject) {
    var readStream = fs.createReadStream(zipFilePath);
    var unzipStream = unzip.Extract({ path: outputPath });

    var pipe = readStream.pipe(unzipStream);

    pipe.on('close', fulfill);
    pipe.on('error', reject);
  });
}

module.exports = Unzipper;
