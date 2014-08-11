// Config takes care of reading/writing configuration data stored on disk.
Config = {}

var fs = require('fs');
var path = require('path');

// Saves info about the current KSP path.
//
// This function does not attempt to validate `path` in any way.
Config.saveKspPath = function(path, callback) {
  fs.readFile(getConfigPath(), function(err, data) {
    if (err) { return callback(err); }

    var configData = JSON.parse(data.toString());
    configData['kspPath'] = path;

    // The extra arguments to JSON#stringify are to make the output pretty.
    var newConfigContents = JSON.stringify(configData, null, 2);

    fs.writeFile(getConfigPath(), newConfigContents, callback);
  });
}

// Loads info about the current KSP path. `callback` might recieve a result of
// `null` if the config could be read from properly, but if no information about
// the KSP path was found.
Config.loadKspPath = function(callback) {
  return loadCacheAttr('kspPath', callback);
}

// Loads info about the cache to store. `callback` might recieve a result of
// `null` if the config could be read from properly, but if no information about
// the KSP path was found.
Config.loadCacheDirPath = function(callback) {
  return loadCacheAttr('cacheDir', callback);
}

var loadCacheAttr = function(attr, callback) {
  fs.readFile(getConfigPath(), function(err, data) {
    if (err) { return callback(err); }

    var configData = JSON.parse(data.toString());

    return callback(null, configData[attr]);
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
