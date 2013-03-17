#!/usr/bin/env coffee

assert = require 'assert'
global.ok = assert.ok

yaml2html = require '../src/yaml2html.coffee'

getData = (extension) ->
  (require 'fs').readFileSync __filename.replace /coffee$/, extension
yamlString = getData 'yaml'
expectedHtmlString = getData 'html'

converter = new yaml2html.Yaml2Html()

actualHtmlString = converter.convert(yamlString) # yaml2html.yaml2html yamlString
ok actualHtmlString = expectedHtmlString,
  "got: '" + actualHtmlString + "', expected: '" + expectedHtmlString + "'"
