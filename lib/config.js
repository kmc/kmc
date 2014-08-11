// Config takes care of reading/writing configuration data stored on disk.
Config = {}

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs-extra'));
var path = require('path');

// Saves info about the current KSP path.
//
// This function does not attempt to validate `path` in any way.
Config.saveKspPath = function(path) {
  var isENOENT = function(e) {
    return e.code === "ENOENT";
  }

  return fs.readFileAsync(getConfigPath(), 'utf8').then(function(contents) {
    return JSON.parse(contents);
  }).catch(isENOENT, function(e) {
    // The config file doesn't exist. We'll then create the parent directories
    // and return an empty config object.
    return fs.mkdirsAsync(getKmcPath()).then(function() {
      return {};
    });
  }).then(function(configData) {
    configData.kspPath = path;

    // The extra arguments to JSON#stringify are to make the output pretty.
    return JSON.stringify(configData, null, 2);
  }).then(function(newConfigContents) {
    return fs.writeFileAsync(getConfigPath(), newConfigContents);
  });
}

// Loads info about the current KSP path.
Config.loadKspPath = function() {
  return loadCacheAttr('kspPath');
}

// Loads info about the cache to store.
Config.loadCacheDirPath = function() {
  return loadCacheAttr('cacheDir');
}

var loadCacheAttr = function(attr) {
  return fs.readFileAsync(getConfigPath(), 'utf8').then(function(contents) {
    return JSON.parse(contents)[attr];
  });
}

// Gets the path of the file where KMC keeps config information.
var getConfigPath = function() {
  return path.join(getKmcPath(), 'config.json');
}

// Gets the path of the directory where KMC keeps all its stuff.
var getKmcPath = function() {
  return path.join(getHomeDirectory(), '.kmc');
}

// Gets the value of '~' for the system.
var getHomeDirectory = function() {
  return process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE;
}

module.exports = Config;
