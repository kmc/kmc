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

// Attempts to install a list of packages.
//
// `params` should have a `packageNames` key containing the names of the
// packages to be installed.
//
// `callback` should expect arguments `err` and `installedPackages`.
Client.prototype.installPackage(params, callback) {

}

// Attempts to uninstall a list of packages.
//
// `params` should have a `packageNames` key containing the names of the
// packages to be uninstalled.
//
// `callback` should expect arguments `err` and `installedPackages`.
Client.prototype.uninstallPackage(params, callback) {

}

// Returns a list of package objects already installed.
//
// `params` is ignored for this action.
//
// `callback` should expect arguments `err` and `packages`.
Client.prototype.listPackages(params, callback) {

}

// Initializes KMC into a KSP directory. This will cause the client's
// `updateKspPath` callback to be called. Be sure your `getKspPath` will be
// updated accordingly if you wish to use this action.
//
// `params` should have a `kspPath` key pointing to where KMC should initialize
// into.
//
// `callback` should expect one argument: `err`.
Client.prototype.initRepo(params, callback) {

}

// Updates KMC's known packages.
//
// `params` is ignored for this action.
//
// `callback` should expect one argument: `err`.
Client.prototype.refreshPackages(params, callback) {

}

// Searches for packages with a name related to the one passed.
//
// `params` should have a `query` key.
//
// `callback` should expect arguments `err` and `foundPackages`.
Client.prototype.searchPackages(params, callback) {

}

module.exports = Client;
