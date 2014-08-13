// Handles resolving a URL into one where performing a GET would actually return
// the desired file.

// Constructs a url resolver from a "human-friendly" URL.
function DownloadUrlResolver(url) {
  this.url = url;
}

// Performs the act of converting a human-friendly URL into a raw downloadable
// URL.
DownloadUrlResolver.prototype.resolve = function() {

}

DownloadUrlResolver.prototype.isMediafire = function() {
  return this.testUrlContains('mediafire.com');
}

DownloadUrlResolver.prototype.isDropbox = function() {
  return this.testUrlContains('dropbox.com');
}

DownloadUrlResolver.prototype.isCurseforge = function() {
  return this.testUrlContains('curseforge.com');
}

DownloadUrlResolver.prototype.isBox = function() {
  return this.testUrlContains('app.box.com');
}

DownloadUrlResolver.prototype.testUrlContains = function(substring) {
  return this.url.indexOf(substring) > 0;
}

module.exports = DownloadUrlResolver;
