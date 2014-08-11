var should = require('should');
var mock = require('mock-fs');

var Config = require('../lib/config');

describe('Config', function() {
  // Make sure the real `fs` module is returned after each test.
  afterEach(function() {
    mock.restore();
  });

  // Very un-DRY to repeat this from config.js, but I see no alternative.
  var home = process.env.HOME || process.env.USERPROFILE;
  var configPath = home + '/.kmc/config.json';

  describe('#readKspPath', function() {
    it('reads from a JSON file at ~/.kmc/config.json', function(done) {
      var newFs = {};
      newFs[configPath] = '{ "kspPath": "/path/to/kmc" }';

      mock(newFs);

      Config.loadKspPath(function(err, result) {
        if (err) { throw err; }

        result.should.eql('/path/to/kmc');
        done();
      });
    });
  });

  describe('#saveKspPath', function() {
    it('updates a JSON file at ~/.kmc/config.json', function(done) {
      var newFs = {};
      newFs[configPath] = '{ "kspPath": "/old/path/to/kmc" }';

      mock(newFs);

      Config.saveKspPath('/new/path/to/kmc', function(err) {
        if (err) { throw err; }

        Config.loadKspPath(function(err, result) {
          if (err) { throw err; }

          result.should.eql('/new/path/to/kmc');
          done();
        });
      });
    });
  });
});
