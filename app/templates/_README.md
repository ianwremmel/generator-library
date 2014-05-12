# <%= appname %> 

[![GitHub version](https://badge.fury.io/gh/<%= username %>/<%= _.slugify(appname).svg %>)](http://badge.fury.io/gh/<%= username %>/<%= _.slugify(appname) %>)
[![Build Status](https://secure.travis-ci.org/<%= username %>/<%= _.slugify(appname) %>.png?branch=master)](https://travis-ci.org/<%= username %>/<%= _.slugify(appname) %>) 
[![Dependencies](https://david-dm.org/<%= username %>/<%= _.slugify(appname) %>.png)](https://david-dm.org/<%= username %>/<%= _.slugify(appname) %>)
<% if (description) { %>
> <%= description %>
<% } %>
## Sublime Text

The following Sublime Plugins will aid your development flow.

- EditorConfig
- Git
- GitGutter 
- SublimeLinter
- SublimeLinter-annotations
- SublimeLinter-jscs
- SublimeLinter-jshint
- SublimeLinter-json

Some of these plugins require external programs be installed your system:

```bash
npm install -g jshint jscs
```

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Release History

- <%= (new Date()).toISOString().split('T')[0] %>  0.0.1  Initial Release

---

*This file was first generated <%= (new Date()).toString() %>*
