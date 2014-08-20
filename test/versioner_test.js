var Promise = require('bluebird');
var should = require('should');
var _ = require('lodash');
var temp = Promise.promisifyAll(require('temp').track());
var fs = Promise.promisifyAll(require('fs'));
var ChildProcess = Promise.promisifyAll(require('child_process'));

var Versioner = require('../lib/versioner');
var Package = require('../lib/package');

describe('Versioner', function() {
  var execInPath = function(path, cmd) {
    return ChildProcess.execAsync('cd ' + path + ';' + cmd);
  }

  // A promise to set up the KSP directory for testing. Make sure this promise
  // returns the temporary directory created.
  var setUpKspPath = function() {
    return temp.mkdirAsync('ksp').then(function(tempDir) {
      return fs.writeFileAsync(tempDir + '/a.txt', 'lorem').then(function() {
        return tempDir;
      });
    });
  }

  describe('#setUpRepo', function() {
    it('creates a git repo and commits everything', function(done) {
      var tempDir;

      setUpKspPath().then(function(kspTempDir) {
        tempDir = kspTempDir;

        return Versioner.setUpRepo(tempDir);
      }).then(function() {
        // count how many commits have been made
        return execInPath(tempDir, 'git rev-list HEAD --count');
      }).then(function(output) {
        parseInt(output[0]).should.eql(1);
      }).then(function() {
        // is anything uncommitted?
        return execInPath(tempDir, 'git ls-files --others --modified | wc -l');
      }).then(function(output) {
        parseInt(output[0]).should.eql(0);

        done();
      });
    });
  });

  describe('#installedPackages', function() {
    it('returns a list of package objects from a git history', function(done) {
      var package1 = new Package({name: 'Package 1'});
      var package2 = new Package({name: 'Package 2'});
      var package3 = new Package({name: 'Package 3'});
      var knownPackages = [package1, package2, package3];

      var tempDir;

      setUpKspPath().then(function(kspTempDir) {
        tempDir = kspTempDir;

        return Versioner.setUpRepo(tempDir);
      }).then(function() {
        return Versioner.markPostinstall(tempDir, package1);
      }).then(function() {
        return Versioner.markPostinstall(tempDir, package2);
      }).then(function() {
        return Versioner.markPostinstall(tempDir, package3);
      }).then(function() {
        return Versioner.installedPackages(tempDir, knownPackages);
      }).then(function(packages) {
        packages.should.eql([package3, package2, package1]);
      }).then(function() {
        return Versioner.uninstallPackage(tempDir, package2);
      }).then(function() {
        return Versioner.installedPackages(tempDir, knownPackages);
      }).then(function(packages) {
        packages.should.eql([package3, package1]);
      }).then(function() {
        return Versioner.markPostinstall(tempDir, package2);
      }).then(function() {
        return Versioner.installedPackages(tempDir, knownPackages);
      }).then(function(packages) {
        packages.should.eql([package3, package2, package1]);

        done();
      });
    });
  });

  describe('#preinstallMessage', function() {
    it('takes the form "PRE: Title"', function() {
      var message = Versioner.preinstallMessage({name: 'Example'});

      message.should.eql("PRE: Example");
    });
  });

  describe('#postinstallMessage', function() {
    it('takes the form "POST: Title"', function() {
      var message = Versioner.postinstallMessage({name: 'Example'});

      message.should.eql("POST: Example");
    });
  });

  describe('#uninstallMessage', function() {
    it('takes the form "UNINSTALL: Title"', function() {
      var message = Versioner.uninstallMessage({name: 'Example'});

      message.should.eql("UNINSTALL: Example");
    });
  });
});
