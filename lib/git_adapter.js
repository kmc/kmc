// Handles dealing with git.
var GitAdapter = {};

var Promise = require('bluebird');
var ChildProcess = Promise.promisifyAll(require('child_process'));
var chdir = require('chdir');
var _ = require('lodash');

// Initializes a git repo at `path`.
GitAdapter.initRepo = function(path) {
  var cmd = [
    'git init',
    'git config user.name KMC',
    'git config user.email kmc@kmc.kmc',
    'git config core.autocrlf false'
  ].join(' ; ');

  return execInPath(path, cmd);
}

// Adds all changes in `path` and commits them with the message `commitMessage`.
GitAdapter.commitEverything = function(path, commitMessage) {
  var cmd = [
    'git add -A -f',
    'git commit --allow-empty -m "' + commitMessage + '"'
  ].join(' ; ');

  return execInPath(path, cmd);
}

// Reverts a commit. This does not create a commit -- it merely changes the
// index to undo changes by a commit.
//
// The `commit` param must be a commit SHA.
GitAdapter.revertCommit = function(path, commit) {
  var cmd = [
    // Favor "our" (HEAD's) files.
    'git revert --no-commit --strategy=merge --strategy-option=ours ' + commit,

    // If there was a merge conflict or something, simply favor keeping files
    // around rather than deleting them.
    'git add *'
  ].join(' ; ');

  return execInPath(path, cmd);
}

// Returns a list of commits for a repo at `path`.
//
// The 'commits' returned are objects with keys `sha` and `message`.
GitAdapter.listCommits = function(path) {
  return execInPath(path, 'git log --oneline').then(function(stdout) {
    var lines = stdout.join('').split('\n');

    return _.chain(lines).filter(function(line) {
      return line.length > 0;
    }).map(function(line) {
      var splitAt = line.indexOf(' ');

      return {
        sha: line.slice(0, splitAt),
        message: line.slice(splitAt + 1)
      };
    }).value();
  });
}

// TODO: Add specs for #cloneRepo and #pullRepo where these actions can be
// mocked?

// Clones a git repo at `remoteUrl` into `localPath`.
GitAdapter.cloneRepo = function(localPath, remoteUrl) {
  return execInPath(localPath, 'git clone ' + remoteUrl + ' .');
}

// Pulls from a pre-configured git repo found locally at `path`.
GitAdapter.pullRepo = function(path) {
  return execInPath(path, 'git pull');
}

var execInPath = function(path, cmd) {
  var promise;

  chdir(path, function() {
    promise = ChildProcess.execAsync(cmd);
  });

  return promise;
}

module.exports = GitAdapter;
