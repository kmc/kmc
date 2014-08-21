// A `Package` contains all information necessary to download and install a
// package. Packages are meant to be "serializable" as a `.js`.
//
// Packages are themselves responsible for a single part of the installation
// process: calling the package's installation procedures.

var Promise = require('bluebird');
var yaml = require('js-yaml');
var _ = require('lodash');
var path = require('path');
var fs = Promise.promisifyAll(require('fs'));

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
//  * installProcedure: A list of package comands to execute in order to install
//    the package.
//  * caveats: A string message to be displayed to the user after the package
//    has been installed.
//
// Only `name`, `url`, and `installProcedure` are required -- all other
// parameters are optional and default to the empty list or empty string.
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
  var kspPath = client.getPackagesPath();

  return fs.readdirAsync(kspPath).map(function(fileName) {
    return path.join(kspPath, fileName);
  }).map(function(packagePath) {
    return fs.readFileAsync(packagePath);
  }).map(Package.loadFromYaml).then(_.flatten);
}

// Loads a list of packages from their YAML-serialized form.
Package.loadFromYaml = function(yamlContents) {
  return _.map(yaml.safeLoad(yamlContents), function(yamlPackage) {
    // The only differences between the YAML parameters and the arguments to the
    // Package constructor are:
    //  - 'install' vs. 'installProcedure'
    //  - 'decompression_method' vs. 'decompressionMethod'
    yamlPackage.installProcedure = yamlPackage.install;
    yamlPackage.decompressionMethod = yamlPackage.decompression_method;

    return new Package(yamlPackage);
  });
}
// Finds a package that goes by the name `query` from a list of known packages.
//
// `query` will automatically be normalized by this function.
Package.findPackage = function(query, knownPackages) {
  return _.find(knownPackages, function(package) {
    return _.contains(package.getNames(), Package.normalizeName(query));
  });
}

// Gets all the names this package can be referred to by in normalized form.
Package.prototype.getNames = function() {
  return _.chain([this.name, this.aliases]).flatten().map(function(name) {
    return Package.normalizeName(name);
  }).value();
}

// Gets this package's prereqs as Package objects.
Package.prototype.getPrerequisites = function(knownPackages) {
  return this.prerequisites.map(function(name) {
    return Package.findPackage(name, knownPackages);
  });
}

// Gets this package's postreqs as Package objects.
Package.prototype.getPostrequisites = function(knownPackages) {
  return this.postrequisites.map(function(name) {
    return Package.findPackage(name, knownPackages);
  });
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
