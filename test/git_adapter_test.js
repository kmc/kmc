var Promise = require('bluebird');
var should = require('should');
var chdir = require('chdir');
var _ = require('lodash');
var temp = Promise.promisifyAll(require('temp').track());
var fs = Promise.promisifyAll(require('fs'));
var ChildProcess = Promise.promisifyAll(require('child_process'));

var GitAdapter = require('../lib/git_adapter');

describe('GitAdapter', function() {
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

  // A promise to set up KSP and init in the tempdir. Returns the tempdir.
  var initAndChdir = function() {
    return setUpKspPath().then(function(tempDir) {
      return GitAdapter.initRepo(tempDir).then(function() {
        return tempDir;
      });
    });
  }

  describe('#initRepo', function() {
    it('creates a repo at the path passed', function(done) {
      var tempDir;

      initAndChdir().then(function(kspTempDir) {
        tempDir = kspTempDir;

        return execInPath(tempDir, 'git rev-parse --is-inside-work-tree');
      }).then(function(stdout, stderr) {
        stdout.join('').should.eql('true\n');

        done();
      });
    });
  });

  describe('#commitEverything', function() {
    it('commits everything as the KMC user', function(done) {
      var tempDir;

      initAndChdir().then(function(kspTempDir) {
        tempDir = kspTempDir;

        return GitAdapter.commitEverything(tempDir, 'Test message');
      }).then(function() {
        // Count how many commits have been made.
        return execInPath(tempDir, 'git rev-list HEAD --count');
      }).then(function(stdout, stderr) {
        parseInt(stdout).should.eql(1);
      }).then(function() {
        return execInPath(tempDir, 'git log -1 --pretty="%an"');
      }).then(function(stdout, stderr) {
        stdout.join('').should.eql('KMC\n');

        done();
      });
    });
  });

  describe('#listCommits', function() {
    it('returns a list of commit messages and shas', function(done) {
      var tempDir;

      initAndChdir().then(function(kspTempDir) {
        tempDir = kspTempDir;

        return GitAdapter.commitEverything(tempDir, 'hello');
      }).then(function() {
        return GitAdapter.commitEverything(tempDir, 'bonjour');
      }).then(function() {
        return GitAdapter.commitEverything(tempDir, 'hola');
      }).then(function() {
        return GitAdapter.listCommits(tempDir);
      }).then(function(commits) {
        _.map(commits, function(commit) {
          return commit.split(' ')[1];
        }).should.eql(['hola', 'bonjour', 'hello']);

        done();
      });
    });
  });
});
