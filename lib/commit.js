// A representation of a git commit.

function Commit(message, sha) {
  this.message = message;
  this.sha = sha;
}

Commit.prototype.isPre = function() {
  return this.getType() === "pre";
}

Commit.prototype.isPost = function() {
  return this.getType() === "post";
}

Commit.prototype.isUninstall = function() {
  return this.getType() === "uninstall";
}

// Determines a commit's type (`"init"`, `"pre"`, `"post"`, `"uninstall"`) from
// its' message.
Commit.prototype.getType = function() {
  var message = this.message;

  return message.substr(0, typeDelimiterIndex(message)).toLowerCase();
}

// Pre-, post-, and uninstall-commits have subjects -- packages they are acting
// on. This function determines what the subject of a commit is from its
// message.
Commit.prototype.getSubject = function() {
  var message = this.message;

  // The "2" serves to jump past the colon and the space that follows it.
  return message.substr(typeDelimiterIndex(message) + 2);
}

// The index to split at to get the type and subject of a commit.
var typeDelimiterIndex = function(message) {
  return message.indexOf(':');
}

module.exports = Commit;
