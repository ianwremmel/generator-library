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
    type: 'confirm',
    name: 'angular',
    message: 'Is this an AngularJS module?',
    default: false
  }, {
    type: 'string',
    name: 'username',
    message: 'Enter your github username.',
    default: 'ianwremmel'
  }, {
    type: 'string',
    name: 'description',
    message: 'Explain your project in one sentence',
    default: ''
  }];

  this.prompt(prompts, function (props) {
    _.each(props, function(value, key) {
      this[key] = value;
    }, this);

    this.bowerIncludes = this.bowerIncludes || this.angular;
    this.supportBrowsers = this.bowerIncludes || this.angular;

    cb();
  }.bind(this));
};

LibraryGenerator.prototype.projectfiles = function projectfiles() {
  this.template('_bower.json', 'bower.json');
  this.template('_editorconfig', '.editorconfig');
  this.template('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('_jscsrc', '.jscsrc');
  this.template('_jshintrc', '.jshintrc');
  if (this.supportBrowsers) {
    this.template('_karma.conf.js', 'karma.conf.js');
  }
  this.template('_LICENSE', 'LICENSE');
  this.template('_package.json', 'package.json');
  this.template('_README.md', 'README.md');
  this.copy('gitignore', '.gitignore');
  this.copy('index.js', 'index.js');
  if (this.angular) {
    this.copy('protractor.conf.js', 'protractor.conf.js');
  }

  this.mkdir('npm');
  this.template('npm/_postinstall.sh', 'npm/postinstall.sh');
};

// Reminder: this function can't be called `src` because doing so breaks yeoman.
LibraryGenerator.prototype.app = function app() {
  this.mkdir('src');
  this.copy('src/index.js', 'src/index.js');
};

LibraryGenerator.prototype.test = function test() {
  this.mkdir('test');
  this.mkdir('test/unit');
  this.mkdir('test/unit/fixtures');
  this.mkdir('test/unit/lib');
  this.mkdir('test/unit/spec');

  this.template('test/unit/spec/_test.js', 'test/unit/spec/test.js');
  this.template('test/unit/_jshintrc', 'test/unit/.jshintrc');

  if (this.angular) {
    this.mkdir('test/acceptance');
    this.mkdir('test/acceptance/fixtures');
    this.mkdir('test/acceptance/lib');
    this.mkdir('test/acceptance/spec');

    this.template('test/acceptance/_jshintrc', 'test/acceptance/.jshintrc');
    this.template('test/acceptance/fixtures/_app.js', 'test/acceptance/fixtures/app.js');
    this.template('test/acceptance/fixtures/_index.html', 'test/acceptance/fixtures/index.html');
    this.template('test/acceptance/spec/_test.js', 'test/acceptance/spec/test.js');
  }
};
