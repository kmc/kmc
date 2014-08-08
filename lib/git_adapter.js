// Handles dealing with git.
var GitAdapter = {};

// Initializes a git repo at `path`.
GitAdapter.initRepo = function(path) {

}

// Adds all changes in `path` and commits them with the message `commitMessage`.
GitAdapter.commitEverything = function(path, commitMessage) {

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
