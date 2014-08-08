# Kerbal Mod Controller

A JavaScript tool to manage (install and uninstall) mods for Kerbal Space
Program. Written for NodeJS, this tool provides both a JS API and a command-line
interface.

Under the hood, KMC uses git to keep track of changes made to your KSP
directory.

# Usage

KMC has four commands for manipulating mods:
  * `install`, which installs a package;
  * `uninstall`, which uninstalls a package;
  * `list`, which provides a list of installed packages;
  * `init`, which initializes KMC into a directory.

There are also a few other commands KMC responds to:
  * `refresh`, which updates the list of packages known to KMC;
  * `search`, which attempts to find a package.

## API Usage

To use KMC in your code, use:

```js
var kmc = require('kerbal-mod-controller');
```

However, to use `kmc` you must first create a KMC client. Clients store certain
config parameters, such as where KSP is on the machine and how (if at all) KMC
should log information. Most of the time, you'll want to use `getDefaultClient`:

```js
// getDefaultClient needs only one parameter: a logger. The default client gets
// all other information from a config file kept at ~/.kmc/config.json.
var client = kmc.getDefaultClient({ logger: console.log });
```

Once you have a client, you can go crazy:

```js
// #installPackage and #uninstallPackage provide callbacks with an
// 'installedPackages' object, which maps user-provided package names (e.g.
// 'far') to KMC Package objects (e.g. Kmc.Package { name: 'Ferram Aerospace
// Research', ... }).
client.installPackage({ packageNames: ['package1', 'package2'] },
    function(err, installedPackages) {
  // ...
});

client.uninstallPackage({ packageNames: ['package1', 'package2'] },
    function(err, installedPackages) {
  // ...
});

// #listPackages simply returns a list of `Kmc.Package`s.
client.listPackages({}, function(err, packages) {
  // ...
});

// For #initRepo, the client's kspPath will be ignored and the one passed as an
// argument will be used instead.
client.initRepo({ kspPath: '/path/to/kmc' }, function(err) {
  // ...
});

client.refreshPackages({}, function(err) {
  // ...
});

// #searchPackages returns a list of packages with names similar to the query
// string passed. The results are ordered by their similarity to the query.
client.searchPackages({ query: 'mekjeb' }, function(err, foundPackages) {
  // ...
});
```
