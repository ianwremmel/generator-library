'use strict';
module.exports = function(config) {
  config.set ({
    frameworks: [
      'mocha',
      'browserify'
    ],

    basePath: '.',

    files: [<% if (angular) { %>
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',<% } %>
      'test/unit/spec/**/*.js'
    ],

    preprocessors: {
      'test/unit/spec/**/*.js': ['browserify']
    },

    reporters: [
      'mocha',
    ],

    browserify: {
      debug: true,
      transform: [<% if (angular) { %>'browserify-shim', <% } %>'debowerify'],
      watch: true
    },

    browsers: ['Chrome']
  });
};
