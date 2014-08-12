// Handles dealing with git.
var GitAdapter = {};

var Promise = require('bluebird');
var ChildProcess = Promise.promisifyAll(require('child_process'));
var chdir = require('chdir');

// Initializes a git repo at `path`.
GitAdapter.initRepo = function(path) {
  return execInPath(path, 'git init').then(function() {
    return GitAdapter.commitEverything(path, 'INIT: Initialize KMC');
  });
}

// Adds all changes in `path` and commits them with the message `commitMessage`.
GitAdapter.commitEverything = function(path, commitMessage) {
  var cmd = [
    'git add -A -f',
    'git commit --allow-empty -m "' + commitMessage + '"'
  ].join(';');

  return execInPath(path, cmd);
}

// Reverts a commit. This does not create a commit -- it merely changes the
// index to undo changes by a commit.
//
// The `commit` param must be an object that has a `sha` key.
GitAdapter.revertCommit = function(path, commit) {

}

// Returns a list of commits for a repo at `path`.
GitAdapter.listCommits = function(path) {

}

// Clones a git repo at `remoteUrl` into `localPath`.
GitAdapter.cloneRepo = function(localPath, remoteUrl) {

}

// Pulls from a pre-configured git repo found locally at `path`.
GitAdapter.pullRepo = function(path) {

}

var execInPath = function(path, cmd) {
  var promise;

  chdir(path, function() {
    promise = ChildProcess.execAsync(cmd);
  });

  return promise;
}

module.exports = GitAdapter;
