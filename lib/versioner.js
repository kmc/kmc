// A thin interface above `GitAdapter`, this module provides a simple API for
// working with version control for KMC's purposes.
var Versioner = {}

var _ = require('lodash');

var GitAdapter = require('./git_adapter');

// Sets up a repo at `kspPath` by creating the git repo and committing everything
// into an initial commit.
Versioner.setUpRepo = function(kspPath) {
  return GitAdapter.initRepo(kspPath).then(function() {
    return GitAdapter.commitEverything(kspPath, Versioner.initMessage());
  });
}

// Marks the pre-install step for installing `package` into a KSP located at
// `kspPath`.
Versioner.markPreinstall = function(kspPath, package) {
  return GitAdapter.commitEverything(kspPath,
    Versioner.preinstallMessage(package));
}

// Marks the post-install step for installing `package` into a KSP located at
// `kspPath`.
Versioner.markPostinstall = function(kspPath, package) {
  return GitAdapter.commitEverything(kspPath,
    Versioner.postinstallMessage(package));
}

// Uninstalls `package` from a KSP located at `kspPath`.
Versioner.uninstallPackage = function(kspPath, package) {
  var findCommitToRevert = function(commits) {
    return _.find(commits, function(commit) {
      commit.isPost() && commit.getSubject() === package.name;
    });
  }

  return GitAdapter.listCommits(kspPath).then(function(commits) {
    return findCommitToRevert(commits);
  }).then(function(toRevert) {
    return GitAdapter.revertCommit(kspPath, toRevert);
  }).then(function() {
    return GitAdapter.commitEverything(kspPath,
      Versioner.uninstallMessage(package));
  });
}

// Gets the installed packages found at `kspPath`. Returns a list of packages.
//
// This function needs a `knownPackages` argument to find package names from.
Versioner.installedPackages = function(kspPath, knownPackages) {
  var findPackageWithName = function(name) {
    return _.find(knownPackages, function(package) {
      return package.name === name;
    });
  }

  return GitAdapter.listCommits(kspPath).then(function(commits) {
    var getCommitsOfType = function(filterPred) {
      var filteredCommits = _.filter(commits, filterPred);

      return _.map(filteredCommits, function(commit) {
        return commit.getSubject();
      });
    }

    var postInstalls = getCommitsOfType(function(c) { return c.isPost(); });
    var uninstalls = getCommitsOfType(function(c) { return c.isUninstall(); });

    _.each(uninstalls, function(uninstallPackage) {
      var packageIndex = postInstalls.indexOf(uninstallPackage);

      postInstalls.splice(packageIndex, 1);
    });

    return postInstalls;
  }).map(findPackageWithName);
}

Versioner.initMessage = function() {
  return "INIT: Initialize KMC";
}

Versioner.preinstallMessage = function(package) {
  return "PRE: " + package.name;
}

Versioner.postinstallMessage = function(package) {
  return "POST: " + package.name;
}

Versioner.uninstallMessage = function(package) {
  return "UNINSTALL: " + package.name;
}

module.exports = Versioner;
