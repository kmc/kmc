// Handles dealing with git.
var GitAdapter = {};

var Promise = require('bluebird');
var ChildProcess = Promise.promisifyAll(require('child_process'));
var _ = require('lodash');

var Commit = require('./commit');

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
// The 'commits' returned are Commit objects.
GitAdapter.listCommits = function(path) {
  return execInPath(path, 'git log --oneline').then(function(output) {
    var stdout = output[0];
    var lines = stdout.split('\n');

    return _.chain(lines).filter(function(line) {
      return line.length > 0;
    }).map(function(line) {
      var splitAt = line.indexOf(' ');

      var sha = line.slice(0, splitAt);
      var message = line.slice(splitAt + 1);

      return new Commit(message, sha);
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
  var cmdInDir = 'cd ' + path + ' ; ' + cmd;

  return ChildProcess.execAsync(cmdInDir);
}

module.exports = GitAdapter;
