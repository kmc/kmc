var should = require('should');
var mock = require('mock-fs');
var nock = require('nock');
var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));

var Downloader = require('../lib/downloader');

describe('Downloader', function() {
  describe('#downloadFile', function() {
    afterEach(mock.restore);

    it('downloads a file and installs it locally', function(done) {
      // Enable mock-fs, but create no files.
      mock({});

      var domain = 'http://example.com';
      var path = '/file.txt';
      var localPath = '/out.txt';

      nock(domain).get(path).reply(200, 'lorem ipsum');

      Downloader.downloadFile(domain + path, localPath).then(function() {
        return fs.readFileAsync(localPath, 'utf8');
      }).then(function(contents) {
        contents.should.eql('lorem ipsum');

        done();
      });
    });
  });
});
