var should = require('should');

var Commit = require('../lib/commit');

describe('Commit', function() {
  var exampleCommit = new Commit('mission: impossible ii', 'cafeba');
  var upcaseCommit = new Commit('HELLO: THERE', '123456');

  describe('#getType', function() {
    it('gets the type of a commit', function() {
      exampleCommit.getType().should.eql('mission');
    });

    it('converts the commit message to lowercase', function() {
      upcaseCommit.getType().should.eql('hello');
    });
  });

  describe('#getSubject', function() {
    it('gets the subject of a commit', function() {
      exampleCommit.getSubject().should.eql('impossible ii');
    });
  });
});
