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

  grunt.registerTask 'default', ['build']

  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'

    yeoman:
      src: 'src'
      dist: 'dist'
      test: 'test'
    <% if (enableBrowserSupport) { %>
    clean:
      dist:
        files: [
          '<%%= yeoman.dist %>'
        ]
    <% } %>
    jshint:
      options:
        reporter: require('jshint-stylish')
        jshintrc: '.jshintrc'
      src: [
          '<%%= yeoman.src %>/**/*.js'
        ]
    <% if (enableBrowserSupport) { %>
    browserify:
      dist:
        files: [
          '<%%= yeoman.dist %>/<%= _.slugify(appname) %>.js': 'src/index.js'
        ]
        standalone: '<%= _.camelize(appname) %>'
    <% } %>
    <% if (enableTests) { %>
    mochacli:
      spec:
        dist: '<%%= yeoman.test %>/test.js'
        options:
          reporter: 'spec'
    <% } %>
