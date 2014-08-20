var mock = require('mock-fs');

var Refresher = require('../lib/refresher');

describe('Refresher', function() {
  describe('#checkPackagesPresent', function() {
    afterEach(mock.restore);

    // Copied from config.js :( ...
    var home = process.env.HOME || process.env.USERPROFILE;

    it('returns true if a git repo with packages exists', function(done) {
      var packagesGitDir = home + '/.kmc/packages/packages/.git';
      var fakeFs = {};
      fakeFs[packagesGitDir] = {};

      mock(fakeFs);

      Refresher.checkPackagesPresent().then(function(present) {
        present.should.be.true;

        done();
      });
    });

    it('returns false if no git repo exists', function(done) {
      mock({});

      Refresher.checkPackagesPresent().then(function(present) {
        present.should.be.false;

        done();
      });
    });
  });
});
