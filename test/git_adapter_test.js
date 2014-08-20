var Promise = require('bluebird');
var should = require('should');
var _ = require('lodash');
var temp = Promise.promisifyAll(require('temp').track());
var fs = Promise.promisifyAll(require('fs'));
var ChildProcess = Promise.promisifyAll(require('child_process'));

var GitAdapter = require('../lib/git_adapter');
var Commit = require('../lib/commit');

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
      }).then(function() {
        return fs.readFileAsync(tempDir + '/.gitignore', 'utf8');
      }).then(function(contents) {
        contents.should.eql("!*\n");
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
      }).then(function(output) {
        parseInt(output[0]).should.eql(1);
      }).then(function() {
        return execInPath(tempDir, 'git log -1 --pretty="%an"');
      }).then(function(output) {
        output[0].should.eql('KMC\n');

        done();
      });
    });
  });

  describe('#revertCommit', function() {
    it('undoes the changes made by a commit', function(done) {
      var tempDir;

      initAndChdir().then(function(kspTempDir) {
        tempDir = kspTempDir;

        return GitAdapter.commitEverything(tempDir, 'Initial commit');
      }).then(function() {
        fs.writeFileAsync(tempDir + '/b.txt', 'example text');
      }).then(function() {
        // We need to create another commit because the initial commit is a
        // special case where the repo is completely empty if we revert it.
        return GitAdapter.commitEverything(tempDir, 'Another commit');
      }).then(function() {
        // Gets last commit's SHA
        return execInPath(tempDir, 'git log -1 --pretty="%h"');
      }).then(function(output) {
        return output[0].trim();
      }).then(function(sha) {
        return GitAdapter.revertCommit(tempDir, sha);
      }).then(function() {
        return execInPath(tempDir, 'ls -1');
      }).then(function(output) {
        output[0].trim().should.eql('a.txt');

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
        commits[0].should.be.an.instanceOf(Commit);

        _.map(commits, function(commit) {
          return commit.message;
        }).should.eql(['hola', 'bonjour', 'hello']);

        done();
      });
    });
  });
});
