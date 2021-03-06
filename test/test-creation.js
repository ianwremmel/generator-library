/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;

describe('library generator', function () {

  beforeEach(function (done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('library:app', [
        '../../app'
      ]);
      done();
    }.bind(this));
  });

  it('creates expected files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.gitignore',
      'LICENSE',

      '.editorconfig',
      'bower.json',
      'package.json',
      '.jshintrc',
      '.jscsrc',
      'Gruntfile.coffee',
      'README.md',

      'src/index.js',

      'test/unit/spec/test.js',
      'test/unit/.jshintrc'
    ];

    helpers.mockPrompt(this.app, {
      username: 'ianwremmel',
      numberOfSpaces: 2,
      supportBrowsers: true
    });

    this.app.options['skip-install'] = true;

    this.app.run({}, function () {
      helpers.assertFiles(expected);
      done();
    });
  });

});
