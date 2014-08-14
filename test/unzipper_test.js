var should = require('should');
var nock = require('nock');
var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs-extra'));
var temp = Promise.promisifyAll(require('temp').track());
var ChildProcess = Promise.promisifyAll(require('child_process'));

var Unzipper = require('../lib/unzipper');

describe('Unzipper', function() {
  describe('#unzip', function() {
    it('unzips a zipfile to a new directory', function(done) {
      var tempDir = temp.path();
      var zipPath = tempDir + '/foo.zip';
      var outputPath = tempDir + '/foo';

      // This test assumes you have the command `zip` on your system.
      var zipCmd = ['zip -r', zipPath, __dirname].join(' ');

      fs.mkdirsAsync(tempDir).then(function() {
        return ChildProcess.execAsync(zipCmd);
      }).then(function(files) {
        return Unzipper.unzipFile(zipPath, outputPath);
      }).then(function() {
        // Since we passed a completely qualified path to `zip`, we get a
        // deeply-nested zip file.
        return fs.readdirAsync(outputPath + __dirname);
      }).then(function(tempFiles) {
        return fs.readdirAsync(__dirname).then(function(localFiles) {
          tempFiles.should.eql(localFiles);

          done();
        });
      });
    });
  });
});
