// A thin interface above `GitAdapter`, this module provides a simple API for
// working with version control for KMC's purposes.
var Versioner = {}

// Sets up a repo at `kspPath` by creating the git repo and committing everything
// into an initial commit.
Versioner.setUpRepo = function(kspPath) {

}

// Marks the pre-install step for installing `package` into a KSP located at
// `kspPath`.
Versioner.markPreinstall = function(kspPath, package) {

}

// Marks the post-install step for installing `package` into a KSP located at
// `kspPath`.
Versioner.markPostinstall = function(kspPath, package) {

}

// Uninstalls `package` from a KSP located at `kspPath`.
Versioner.uninstallPackage = function(kspPath, package) {

}

// Gets the installed packages found at `kspPath`.
Versioner.installedPackages = function(kspPath) {

}
