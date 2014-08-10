var should = require('should');

var Package = require('../lib/package');

describe('Package', function() {
  describe('#normalizeName', function() {
    it('removes capitalization', function() {
      Package.normalizeName('Example').should.eql('example');
    });

    it('converts groups of spaces to dashes', function() {
      Package.normalizeName('hello there').should.eql('hello-there');
      Package.normalizeName('one two three').should.eql('one-two-three');
      Package.normalizeName('two  spaces').should.eql('two-spaces');
    });

    it('does not add dashes if one is already there', function() {
      Package.normalizeName('foo - bar').should.eql('foo-bar');
    });
  });
});
