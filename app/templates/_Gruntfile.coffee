# Generated on <%= (new Date()).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'build', [
    <% if (enableBrowserSupport) { %>
    'clean'
    <% } %>
    'jshint'
    <% if (enableBrowserSupport) { %>
    'browserify'
    <% } %>
  ]
  <% if (enableTests) { %>
  grunt.registerTask 'test', [
    'build'
    'mochacli'
  ]
  <% } %>

  grunt.registerTask 'default' ['build']

  grunt.initConfig
    <% if (enableBrowserSupport) { %>
    clean:
      dist:
        files: [
          'dist'
        ]
    <% } %>
    jshint:
      options:
        reporter: require('jshint-stylish')
        jshintrc: '.jshintrc'
      src:
        files: [
          'src/**/*.js'
        ]
    <% if (enableBrowserSupport) { %>
    browserify:
      dist:
        files: [
          'dist/<%= _.slugify(appname) %>.js': 'src/index.js'
        ]
    <% } %>
    <% if (enableTests) { %>
    mochacli:
      spec:
        dist: 'test/test.coffee'
        options:
          compilers: [
            'coffee:coffee-script'
          ]
          reporter: 'spec'
    <% } %>
