// A `Package` contains all information necessary to download and install a
// package. Packages are meant to be "serializable" as a `.js`.
//
// Packages are themselves responsible for a single part of the installation
// process: calling the package's installation procedures.

// Creates a package from params, with keys:
//
//  * name: The name of the package, i.e. `"Ferram Aerospace Research"`
//  * url: The URL where the package can be downloaded from.
//  * aliases: An array of alternative names the package goes by, e.g.
//    `["ferram", "far"]`.
//  * prerequisites: An array of package names that need to be installed
//    *before* this package is installed.
//  * postrequisites: An array of package names that need to be installed
//    *after* this package is installed.
//  * decompressionMethod: Once this package has been downloaded, how should it
//    be decompressed? Valid values are `"none"`, `"zip"`.
//  * installProcedure: A function that accepts a package (a value for `this`)
//    and an InstallHelper, which provides functions for common installation
//    procedures.
//
// Only 'name', 'url', and 'installProcedure' are required -- all other
// parameters are optional and default to the empty list.
function Package(params) {
  this.name = params.name;
  this.url = params.url;
  this.aliases = params.aliases || [];
  this.prerequisites = params.prerequisites || [];
  this.postrequisites = params.postrequisites || [];
  this.decompressionMethod = params.decompressionMethod || "zip";
  this.installProcedure = params.installProcedure;
  this.caveats = params.caveats;
}

// Loads all packages and returns them in a list.
//
// The parameter `client` is necessary to determine where to load packages from.
Package.loadPackages = function(client) {
}

// Normalizes a name for searching:
//
// ```
// "Mechjeb" -> "mechjeb"
// "ferram aerospace research" -> "ferram-aerospace-research"
// "foo-bar baz" -> "foo-bar-baz"
// ```
Package.normalizeName = function(name) {
  return name.toLowerCase().replace(/[ \-]+/g, '-');
}

// Performs the installation procedure for this package -- it prepares an
// install helper and passes 'this' and the install helper to this package's
// installProcedure.
//
// The parameter tempDir should be a string to the temporary location where the
// already downloaded and decompressed package contents can be found.
Package.prototype.performInstallProcedure = function(tempDir) {
}

module.exports = Package;
