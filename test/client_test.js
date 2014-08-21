var should = require('should');
var mock = require('mock-fs');

var Client = require('../lib/client');

describe('Client', function() {
  afterEach(mock.restore);

  describe('#installPackages', function() {
    it('raises an error on bad package name', function(done) {
      mock({
        '/ksp-path/': {}
      });

      var client = new Client({
        getPackagesPath: function() { return '/ksp-path'; }
      });

      client.installPackages(['does not exist'])
      .catch(Client.PackageNotFoundError, function(e) {
        e.packageName.should.eql('does not exist');
        done();
      }).error(function(e) {
        console.log(e);
      });
    });
  });
});
