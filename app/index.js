'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var _ = require('lodash');


var LibraryGenerator = module.exports = function LibraryGenerator(args, options) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(LibraryGenerator, yeoman.generators.Base);

LibraryGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    type: 'number',
    name: 'numberOfSpaces',
    message: 'How many spaces do you prefer?',
    default: 2
  }, {
    type: 'confirm',
    name: 'supportBrowsers',
    message: 'Can this library be run in a web browser?',
    default: true
  }, {
    type: 'confirm',
    name: 'bowerIncludes',
    message: 'Will you be including packages from Bower?',
    default: false
  }, {
    type: 'string',
    name: 'username',
    message: 'Enter your github username.',
    default: 'ianwremmel'
  }];

  this.prompt(prompts, function (props) {
    _.each(props, function(value, key) {
      this[key] = value;
    }, this);

    cb();
  }.bind(this));
};

LibraryGenerator.prototype.projectfiles = function projectfiles() {
  this.mkdir('src');

  this.copy('gitignore', '.gitignore');
  this.template('_LICENSE', 'LICENSE');

  this.template('_editorconfig', '.editorconfig');
  this.template('_bower.json', 'bower.json');
  this.template('_package.json', 'package.json');
  this.template('_jshintrc', '.jshintrc');
  this.template('_jscsrc', '.jscsrc');
  this.template('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('_README.md', 'README.md');

  if (this.bowerIncludes) {
    this.mkdir('npm');

    this.copy('npm/postinstall.sh', 'npm/postinstall.sh');
  }
};

// Reminder: this function can't be called `src` because it breaks yeoman.
LibraryGenerator.prototype.app = function app() {
  this.copy('src/index.js', 'src/index.js');
};

LibraryGenerator.prototype.test = function test() {
  this.mkdir('test');
  this.mkdir('test/lib');
  this.mkdir('test/spec');

  this.template('test/spec/_test.js', 'test/spec/test.js');
  this.template('test/_jshintrc', 'test/.jshintrc');
};
