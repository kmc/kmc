// Handles updating KMC's repository of known packages, a process known as
// "refreshing" KMC.
var Refresher = {};

var Promise = require('bluebird');
var path = require('path');
var fs = Promise.promisifyAll(require('fs'));

var Config = require('./config');

// Determines if KMC has a packages repository downloaded yet or not.
//
// This function returns a promise for consistency's sake.
Refresher.checkPackagesPresent = function() {
  var packagesGitPath = path.join(Config.getPackagesPath(), '.git');

  return new Promise(function(fulfill, reject) {
    fs.exists(packagesGitPath, fulfill);
  });
}

module.exports = Refresher;
