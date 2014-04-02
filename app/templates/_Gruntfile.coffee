# Generated on <%= (new Date()).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    config:
      src: 'src',
      dist: 'dist'


    # Utilities
    # ---------

    clean:
      dist: [
        '<%%= config.dist %>'
      ]

    bump:
      options:
        files: [
          'package.json'
          'bower.json'
        ]
        tagName: '%VERSION%'
        updateConfigs: ['pkg']

    githooks:
      'pre-commit':
        'pre-commit': 'static-analysis'


    # Static Analysis
    # ---------------

    jshint:
      options:
        report: require 'jshint-stylish'
        jshintrc: '.jshintrc'
      src: [
        '<%%= config.src %>/**/*.js'
      ]

    jscs:
      options:
        config: '.jscsrc'
      src: '<%%= config.src %>/**/*.js'


    # Tests
    # -----

    mochacli:
      options:
        files: ['test/spec/**/*/js']
        reporter: 'spec'
      spec: {}
      debug:
        options:
          debug: true

<% if (supportBrowsers) { %>
    # Build Steps
    # -----------

    # grunt-browserify uses an outdated interface to browserify-shim which
    # doesn't support the "global:" syntax.
    shell:
      browserify:
        command: 'mkdir -p <%= config.dist %> && ./node_modules/.bin/browserify -d -s <%= _.camelize(appname) %> <%= config.src %> > <%= config.dist %>/<%= _.slugify(appname) %>.js'
<% } %>

    # Public Tasks
    # ------------

    grunt.registerTask 'static-analysis', [
      'jshint'
      'jscs'
    ]

    grunt.registerTask 'build', [
      'clean'
      'static-analysis'
      'test:spec'
      'shell:browserify'
    ]

    grunt.registerTask 'test:spec', ['mochacli:spec']
    grunt.registerTask 'test:debug', ['mochacli:debug']

    grunt.registerTask 'default', ['build']
