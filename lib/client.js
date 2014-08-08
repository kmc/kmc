// Creates a client with parameters for getting the KSP path, packages path, and
// logger.
function Client(params) {
  this.getKspPath = params.getKspPath;
  this.getPackagesPath = params.getPackagesPath;
  this.logger = params.logger;
}

module.exports = Client;
