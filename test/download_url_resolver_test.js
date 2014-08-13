var should = require('should');

var DownloadUrlResolver = require('../lib/download_url_resolver');

describe('DownloadUrlResolver', function() {
  describe('Mediafire', function() {
    it('detects mediafire links', function() {
      var url = 'http://www.mediafire.com/download/some-random-stuff/whatever.zip';

      (new DownloadUrlResolver(url)).isMediafire().should.be.true;
    });

    it('resolves mediafire links', function(done) {
      this.timeout(0);

      var url = 'file://' + __dirname + '/fixtures/mediafire.com.html';
      var targetUrl = 'http://download1690.mediafire.com/qny71y9k6kvg/o6cbe03iitggj1p/B9+Aerospace+Pack+R4.0c.zip';

      (new DownloadUrlResolver(url)).resolve().then(function(url) {
        url.should.eql(targetUrl);

        done();
      });
    });
  });

  describe('Dropbox', function() {
    it('detects dropbox links', function() {
      var url = 'https://www.dropbox.com/s/some-random-stuff/whatever.zip';

      (new DownloadUrlResolver(url)).isDropbox().should.be.true;
    });
  });

  describe('Curseforge', function() {
    it('detects curseforge links', function() {
      var url = 'http://kerbal.curseforge.com/plugins/123123-whatever';

      (new DownloadUrlResolver(url)).isCurseforge().should.be.true;
    });
  });

  describe('Box', function() {
    it('detects box links', function() {
      var url = 'https://app.box.com/s/89skim2e3simjwmuof4c';

      (new DownloadUrlResolver(url)).isBox().should.be.true;
    });
  });
});
