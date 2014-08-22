var should = require('should');
var mock = require('mock-fs');
var fs = require('fs');

var Client = require('../lib/client');
var Package = require('../lib/package');

describe('Package', function() {
  describe('#loadPackages', function() {
    afterEach(mock.restore);

    it('deserializes all packages in a directory', function(done) {
      mock({
        '/kmc-packages/a.yml': '- name: Package1',
        '/kmc-packages/b.yml': '- name: Package2',
        '/kmc-packages/c.yml': '- name: Package3\n- name: Package4',
      });

      var clientMethodCalled = false;

      var client = new Client({getPackagesPath: function() {
        clientMethodCalled = true;
        return '/kmc-packages';
      }});

      Package.loadPackages(client).then(function(packages) {
        clientMethodCalled.should.be.true;
        packages.length.should.eql(4);

        done();
      });
    })
  });

  describe('#loadFromYaml', function() {
    it('reads in a YAML file', function() {
      var yaml = [
        '- name: Name',
        '  aliases: [alias]',
        '  prerequisites: [prereq]',
        '  postrequisites: [postreq]',
        '  url: url',
        '  decompression_method: none',
        '  install:',
        '    - merge_directory: [From, To]',
        '  caveats: |',
        '    Caveat message'
      ].join('\n');

      var packages = Package.loadFromYaml(yaml);

      packages.length.should.eql(1);

      packages[0].name.should.eql('Name');
      packages[0].aliases.should.eql(['alias']);
      packages[0].prerequisites.should.eql(['prereq']);
      packages[0].postrequisites.should.eql(['postreq']);
      packages[0].url.should.eql('url');
      packages[0].decompressionMethod.should.eql('none');
      packages[0].installProcedure.should.eql([
        {'merge_directory': ['From', 'To']}
      ]);
      packages[0].caveats.should.eql('Caveat message\n');
    });
  });

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

  describe('#findPackage', function() {
    it('finds a package from a name', function() {
      var packages = [
        new Package({name: 'a'}),
        new Package({name: 'b'}),
        new Package({name: 'c'})
      ];

      Package.findPackage('b', packages).should.eql(packages[1]);
    });
  });

  describe('#getNames', function() {
    it('normalizes titles and aliases', function() {
      var examplePackage = new Package({
        name: 'Title',
        aliases: ['alias 1', 'alias 2']
      });

      examplePackage.getNames().should.eql(['title', 'alias-1', 'alias-2']);
    });
  });

  describe('#get{Pre, Post}requisites', function() {
    it('loads requisites as objects', function() {
      var package1 = new Package({name: 'Package 1'});
      var knownPackages = [package1];

      var examplePackage = new Package({
        prerequisites: ['package 1'],
        postrequisites: ['package 1']
      });

      examplePackage.getPrerequisites(knownPackages).should.eql(knownPackages);
      examplePackage.getPostrequisites(knownPackages).should.eql(knownPackages);
    });
  });

  describe('#performInstallProcedure', function() {
    afterEach(mock.restore);

    it('merges directories', function(done) {
      mock({
        // The temporary directory where a package was installed
        '/tmp': {
          'foo.txt': '',
          'bar.txt': '',
          'toto': {
            'a.txt': '',
            'b.txt': '',
            'c.txt': ''
          }
        },

        // The KSP directory
        '/ksp': {
          'baz': {},
          'toto': {
            'd.txt': ''
          }
        }
      });

      var examplePackage = new Package({
        installProcedure: [
          {merge_directory: ['foo.txt']},
          {merge_directory: ['bar.txt', 'baz']},
          {merge_directory: ['toto']}
        ]
      });

      examplePackage.performInstallProcedure('/tmp', '/ksp').then(function() {
        var files = [
          '/ksp/foo.txt',
          '/ksp/baz/bar.txt',
          '/ksp/toto/a.txt',
          '/ksp/toto/b.txt',
          '/ksp/toto/c.txt',
          '/ksp/toto/d.txt'
        ];

        files.forEach(function(file) {
          fs.existsSync(file).should.be.true;
        });

        done();
      });
    });
  });
});
