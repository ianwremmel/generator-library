'use strict';

var chai = require('chai');
var assert = chai.assert;

var <%= _.camelize(appname) %> = require('../../../src');

describe('the test suite', function() {
  it('works', function() {
    assert.isDefined(<%= _.camelize(appname) %>);
    assert.isNotNull(<%= _.camelize(appname) %>);
    assert.isObject(<%= _.camelize(appname) %>);
  });
});
