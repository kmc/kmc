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
  return /mediafire\.com/.test(this.url);
}

DownloadUrlResolver.prototype.isDropbox = function() {
  return /dropbox\.com/.test(this.url);
}

DownloadUrlResolver.prototype.isCurseforge = function() {
  return /curseforge\.com/.test(this.url);
}

DownloadUrlResolver.prototype.isBox = function() {
  return /app\.box\.com/.test(this.url);
}

module.exports = DownloadUrlResolver;
