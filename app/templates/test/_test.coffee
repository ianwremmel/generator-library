sinon = require 'sinon'
chai = require 'chai'
assert = chai.assert

<%= _.slugify(appname).replace('-', '_') %> = require '../src'

describe '<%= appname %>', ->
