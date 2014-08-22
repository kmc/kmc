// Handles updating KMC's repository of known packages, a process known as
// "refreshing" KMC.
var Refresher = {};

// The URL of the git repo to clone / pull from when refreshing packages.
Refresher.remotePackageRepoUrl = "https://github.com/kmc/packages.git";

var Promise = require('bluebird');
var path = require('path');
var fs = Promise.promisifyAll(require('fs'));
var fse = Promise.promisifyAll(require('fs-extra'));

var Config = require('./config');
var GitAdapter = require('./git_adapter');

// Determines if KMC has a packages repository downloaded yet or not.
//
// This function returns a promise for consistency's sake.
Refresher.checkPackagesPresent = function() {
  var packagesGitPath = path.join(Config.getPackagesPath(), 'packages', '.git');

  return new Promise(function(fulfill, reject) {
    fs.exists(packagesGitPath, fulfill);
  });
}

// TODO: Find a way to test this function.

// Updates/creates KMC's repository of packages by either pulling from/cloning
// the master packages repo.
Refresher.updatePackages = function() {
  var packagesPath = Config.getPackagesPath();

  var pullRepo = function() {
    return GitAdapter.pullRepo(packagesPath);
  }

  var cloneRepo = function() {
    return GitAdapter.cloneRepo(packagesPath, Refresher.remotePackageRepoUrl);
  }

  return fse.mkdirsAsync(packagesPath).then(function() {
    return Refresher.checkPackagesPresent();
  }).then(function(present) {
    if (present) {
      return pullRepo();
    } else {
      return cloneRepo();
    }
  });
}

module.exports = Refresher;
