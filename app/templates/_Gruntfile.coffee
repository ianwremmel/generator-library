# Generated on <%= (new Date()).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    config:
      dist: 'dist'
      src:  'src'
      test: 'test'
      tmp:  '.tmp'


    # Utilities
    # ---------

    bump:
      options:
        files: [
          'package.json'<% if (supportBrowsers) { %>
          'bower.json'<% } %>
        ]
        commitFiles: [
          'package.json'<% if (supportBrowsers) { %>
          'bower.json'<% } %>
        ]
        tagName: '%VERSION%'
        updateConfigs: ['pkg']
        pushTo: 'origin'

    clean:
      dist: [
        '<%%= config.dist %>'
      ] <% if (angular) { %>
      tmp: [
        '<%%= config.tmp %>'
      ]<% } %>

    <% if (angular) { %>connect:
      options:
        port: 8000
        hostname: '127.0.0.1'
      test:
        options:
          base: [
            'bower_components'
            '<%= config.tmp %>'
            '<%= config.test %>/acceptance/fixtures'
          ]<% } %>

    githooks:
      'pre-commit':
        'pre-commit': 'static-analysis'
      'post-receive':
        'post-receive': 'shell:npm-install'


    # Static Analysis
    # ---------------

    jshint:
      options:
        report: require 'jshint-stylish'
        jshintrc: '.jshintrc'
      src:
        options:
          files: [
            '<%%= config.src %>/**/*.js'
          ]
      unit:
        options:
          jshintrc: '<%= config.test %>/unit/.jshintrc'
          files: [
            '<%= config.test %>/unit/**/*.js'
          ]<% if (angular) { %>
      acceptance:
        options:
          jshintrc: '<%= config.test %>/acceptance/.jshintrc'
          files: [
            '<%= config.test %>/acceptance/**/*.js'
          ]<% } %>

    jscs:
      options:
        config: '.jscsrc'
      src: '<%%= config.src %>/**/*.js'
      test: '<%%= config.test %>/**/*.js'


    # Tests
    # -----

    <% if (!angular) { %>mochacov:
      options:
        files: ['<%%= config.test %>/spec/**/*.js']
        reporter: 'spec'
      ci: {}
      coverage:
        options:
          reporter: 'html-cov'
          output: '<%%= config.tmp %>/coverage.html'
      debug:
        options:
          debug: true <% } %>

    <% if (supportBrowsers) { %>karma:
      options:
        # Note: karma-browserify doesn't initiliaze properly unless the karma
        # config is in a separate file
        configFile: 'karma.conf.js'
      ci:
        singleRun: true
        browsers: [
          'Chrome'
          'Firefox'
        ]
      dev: {}

      <% if (angular) { %>protractor:
        options:
          configFile: 'protractor.conf.js'
        ci:
          options:
            # Make sure failures prevent grunt from continuing
            keepAlive: false
        dev:
          options:
            debug: true<% } %><% } %>


    # Build Steps
    # -----------

    # grunt-browserify uses an outdated interface to browserify-shim which
    # doesn't support the "global:" syntax.
    shell:<% if (supportBrowsers) { %>
      browserify:
        command: 'mkdir -p <%%= config.tmp %> && ./node_modules/.bin/browserify -d -s <%= _.camelize(appname) %> <%%= config.src %> > <%%= config.tmp %>/<%= _.slugify(appname) %>.js'<% } else { %>
      coverage:
        command: 'open <%%= config.tmp %>/coverage.html'<% } %>

    <% if (supportBrowsers) { %>uglify:
      dist:
        options:
          sourceMap: true
          sourceMapIncludeSources: true,
        files:
          '<%%= config.tmp %>/<%= _.slugify(appname) %>.min.js': '<%%= config.tmp %>/<%= _.slugify(appname) %>.js'<% } %>

  <% if (!supportBrowsers) { %>grunt.registerTask 'coverage', [
    'mochacov:coverage'
    'shell:coverage'
  ]<% } %>

  <% if (supportBrowsers) { %>grunt.registerTask 'browserify', ['shell:browserify']<% } %>

  # Public Tasks
  # ------------

  grunt.registerTask 'static-analysis', [
    'jshint'
    'jscs'
  ]

  grunt.registerTask 'test:unit', [<% if (!angular) { %>
    'mochacov:ci'<% } %><% if (supportBrowsers) { %>
    'karma:ci' <% } %>
  ]

  <% if (angular) { %>grunt.registerTask 'test:acceptance', [
    'browserify'
    'connect:test'
    'protractor:ci'
  ]<% } %>

  grunt.registerTask 'test', [
    'static-analysis'
    'test:unit'<% if (angular) { %>
    'test:acceptance' <% } %>
  ]

  grunt.registerTask 'default', [
    'clean'
    'test'<% if (!angular) { %>
    'browserify' <% } else { %>
    'copy:dist'
    'clean:tmp'<% } %>
  ]
