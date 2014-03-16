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
  this.copy('LICENSE', 'LICENSE');

  this.template('_editorconfig', '.editorconfig');
  this.template('_bower.json', 'bower.json');
  this.template('_package.json', 'package.json');
  this.template('_jshintrc', '.jshintrc');
  this.template('_jscsrc', '.jscsrc');
  this.template('_Gruntfile.coffee', 'Gruntfile.coffee');
};

// Reminder: this function can't be called `src` because it breaks yeoman.
LibraryGenerator.prototype.app = function app() {
  this.copy('src/index.js', 'src/index.js');
};
