var Promise = require('bluebird');
var should = require('should');
var chdir = require('chdir');
var temp = Promise.promisifyAll(require('temp').track());
var fs = Promise.promisifyAll(require('fs'));
var ChildProcess = Promise.promisifyAll(require('child_process'));

var GitAdapter = require('../lib/git_adapter');

describe('GitAdapter', function() {
  describe('#initRepo', function() {
    // A promise to set up the KSP directory for testing. Make sure this promise
    // returns the temporary directory created.
    var setUpKspPath = temp.mkdirAsync('ksp').then(function(tempDir) {
      return fs.writeFileAsync(tempDir + '/a.txt', 'lorem').then(function() {
        return tempDir;
      });
    });

    // A promise to set up KSP and init in the tempdir. Returns the tempdir.
    var initAndChdir = setUpKspPath.then(function(tempDir) {
      return GitAdapter.initRepo(tempDir).then(function() {
        return tempDir;
      });
    });

    it('creates a repo at the path passed', function(done) {
      initAndChdir.then(function(tempDir) {
        chdir(tempDir, function() {
          var inGitDir = 'git rev-parse --is-inside-work-tree';

          ChildProcess.execAsync(inGitDir, function(stderr, stdout) {
            stdout.should.eql('true\n');

            done();
          });
        });
      });
    });
  });
});
