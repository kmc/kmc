var should = require('should');

var nock = require('nock');
var fs = require('fs');
var DownloadUrlResolver = require('../lib/download_url_resolver');

describe('DownloadUrlResolver', function() {
  describe('Mediafire', function() {
    it('detects mediafire links', function() {
      var url = 'http://www.mediafire.com/download/some-random-stuff/whatever.zip';

      DownloadUrlResolver.isMediafire(url).should.be.true;
    });

    // TODO: Figure out how to get this test to work, given that request doesn't
    // like "URLs" that use the `file://` protocol.
    //
    // it('resolves mediafire links', function(done) {
    //   this.timeout(0);

    //   var url = 'file://' + __dirname + '/fixtures/mediafire.com.html';
    //   var targetUrl = 'http://download1690.mediafire.com/qny71y9k6kvg/o6cbe03iitggj1p/B9+Aerospace+Pack+R4.0c.zip';

    //   DownloadUrlResolver.resolve(url).then(function(url) {
    //     url.should.eql(targetUrl);

    //     done();
    //   });
    // });

    it('resolves direct mediafire links', function(done) {
      var url = 'http://www.mediafire.com/download/foo/bar.zip';
      var directDownload = 'http://download.mediafire.com/asdf.zip';

      nock('http://www.mediafire.com')
        .head('/download/foo/bar.zip')
        .reply(301, '', {
          location: directDownload,
          'content-type': 'application/asdfasdfasdf'
        });

      nock('http://download.mediafire.com')
        .head('/asdf.zip')
        .reply(200, '', {
          'content-type': 'application/zip'
        });


      DownloadUrlResolver.resolve(url).then(function(downloadUrl) {
        // with a direct download URL, the original URL can be downloaded from
        // directly.
        downloadUrl.should.eql(url);

        done();
      });
    });
  });

  describe('Dropbox', function() {
    it('detects dropbox links', function() {
      var url = 'https://www.dropbox.com/s/some-random-stuff/whatever.zip';

      DownloadUrlResolver.isDropbox(url).should.be.true;
    });

    // This spec is commented out because PhantomJS is slow and it can take
    // multiple seconds to get this to run.
    //
    // it('resolves dropbox links', function(done) {
    //   this.timeout(0);

    //   var url = 'file://' + __dirname + '/fixtures/dropbox.com.html';
    //   var targetUrl = 'https://dl.dropboxusercontent.com/s/od4kickxt92jpo2/BetterAtmosphereV4%5BREL%5D.zip?dl=1&token_hash=AAFn5emxuVXLw_RfjDgQs0Hn7-YZ-vejn3m8zLgOj2tTFA&expiry=1401095304';

    //   DownloadUrlResolver.resolve(url).then(function(url) {
    //     url.should.eql(targetUrl);

    //     done();
    //   });
    // });
  });

  describe('Curseforge', function() {
    it('detects curseforge links', function() {
      var url = 'http://kerbal.curseforge.com/plugins/123123-whatever';

      DownloadUrlResolver.isCurseforge(url).should.be.true;
    });
  });

  describe('Box', function() {
    it('detects box links', function() {
      var url = 'https://app.box.com/s/89skim2e3simjwmuof4c';

      DownloadUrlResolver.isBox(url).should.be.true;
    });

    it('resolves box links', function(done) {
      var url = 'https://app.box.com/s/89skim2e3simjwmuof4c';
      var targetUrl = 'https://app.box.com/index.php?rm=box_download_shared_file&shared_name=89skim2e3simjwmuof4c&file_id=f_13860854981';
      var pagePath = __dirname + '/fixtures/app.box.com.html';

      nock('https://app.box.com')
        .get('/s/89skim2e3simjwmuof4c')
        .reply(200, fs.readFileSync(pagePath, 'utf8'));

      DownloadUrlResolver.resolve(url).then(function(url) {
        url.should.eql(targetUrl);

        done();
      });
    });
  });
});
