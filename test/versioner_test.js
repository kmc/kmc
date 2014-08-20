var Promise = require('bluebird');
var should = require('should');
var _ = require('lodash');
var temp = Promise.promisifyAll(require('temp').track());
var fs = Promise.promisifyAll(require('fs'));
var ChildProcess = Promise.promisifyAll(require('child_process'));

var Versioner = require('../lib/versioner');

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
});
