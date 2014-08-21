// Client stores some confirguration data and takes care of orchestrating the
// actions KMC should take for each command.

var Promise = require('bluebird');
var util = require('util');
var _ = require('lodash');

var Package = require('./package');

// Creates a client with parameters for getting / updating the KSP path,
// packages path, and logger.
//
// `updateKspPath`, if provided, should expect a single argument representing
// the new KSP path.
function Client(params) {
  this.getKspPath = params.getKspPath;
  this.updateKspPath = params.updateKspPath
  this.getPackagesPath = params.getPackagesPath;
  this.logger = params.logger;
}

Client.PackageNotFoundError = function(packageName) {
  Error.call(this);
  this.message = 'Package not found: ' + packageName;
  this.packageName = packageName;
}

util.inherits(Client.PackageNotFoundError, Error);

// Attempts to install a list of packages.
//
// `packageNames` should be a list of names of packages to install.
//
// Returns a promise who fulfillment value is a map going from package names to
// caveats.
Client.prototype.installPackages = function(packageNames) {
  return Package.loadPackages(this).then(function(packages) {
    return packageNames.map(function(name) {
      return Package.findPackage(name, packages);
    });
  }).then(function(packages) {
    return checkPackagesExist(packageNames, packages);
  });
}

var checkPackagesExist = function(packageNames, packages) {
  _.zip(packageNames, packages).forEach(function(pair) {
    if (!pair[1]) {
      throw new Client.PackageNotFoundError(pair[0]);
    }
  });

  return packages;
}

// Attempts to uninstall a list of packages.
//
// `params` should have a `packageNames` key containing the names of the
// packages to be uninstalled.
//
// `callback` should expect arguments `err` and `installedPackages`.
Client.prototype.uninstallPackage = function(params, callback) {

}

// Returns a list of package objects already installed.
//
// `params` is ignored for this action.
//
// `callback` should expect arguments `err` and `packages`.
Client.prototype.listPackages = function(params, callback) {

}

// Initializes KMC into a KSP directory. This will cause the client's
// `updateKspPath` callback to be called. Be sure your `getKspPath` will be
// updated accordingly if you wish to use this action.
//
// `params` should have a `kspPath` key pointing to where KMC should initialize
// into.
//
// `callback` should expect one argument: `err`.
Client.prototype.initRepo = function(params, callback) {

}

// Updates KMC's known packages.
//
// `params` is ignored for this action.
//
// `callback` should expect one argument: `err`.
Client.prototype.refreshPackages = function(params, callback) {

}

// Searches for packages with a name related to the one passed.
//
// `params` should have a `query` key.
//
// `callback` should expect arguments `err` and `foundPackages`.
Client.prototype.searchPackages = function(params, callback) {

}

module.exports = Client;
