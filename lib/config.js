// Config takes care of reading/writing configuration data stored on disk.

Config = {}

// Saves info about the current KSP path.
Config.saveKspPath = function(path, callback) {

}

// Loads info about the current KSP path. `callback` might recieve a result of
// `null` if the config could be read from properly, but if no information about
// the KSP path was found.
Config.loadKspPath = function(path, callback) {

}

// Loads info about the cache to store. `callback` might recieve a result of
// `null` if the config could be read from properly, but if no information about
// the KSP path was found.
Config.loadCacheDirPath = function(path, callback) {

}

// Gets the path of the file where KMC keeps config information.
Config.getConfigPath = function() {

}

// Gets the path of the directory where KMC keeps all its stuff.
Config.getKmcPath = function() {

}
