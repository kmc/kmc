// A representation of a git commit.

function Commit(message, sha) {
  this.message = message;
  this.sha = sha;
}

Commit.prototype.isPre = function() {

}

Commit.prototype.isPost = function() {

}

Commit.prototype.isUninstall = function() {

}

// Determines a commit's type (`"init"`, `"pre"`, `"post"`, `"uninstall"`) from
// its' message.
Commit.prototype.getType = function() {

}

// Pre-, post-, and uninstall-commits have subjects -- packages they are acting
// on. This function determines what the subject of a commit is from its
// message.
Commit.prototype.getSubject = function() {

}

module.exports = Commit;
