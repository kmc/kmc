// A thin interface above `GitAdapter`, this module provides a simple API for
// working with version control for KMC's purposes.
var Versioner = {}

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
  return GitAdapter.commitEverything(kspPath, preinstallMessage(package));
}

// Marks the post-install step for installing `package` into a KSP located at
// `kspPath`.
Versioner.markPostinstall = function(kspPath, package) {
  return GitAdapter.commitEverything(kspPath, postinstallMessage(package));
}

// Uninstalls `package` from a KSP located at `kspPath`.
Versioner.uninstallPackage = function(kspPath, package) {
  return GitAdapter.commitEverything(kspPath, uninstallMessage(package));
}

// Gets the installed packages found at `kspPath`.
Versioner.installedPackages = function(kspPath) {

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
