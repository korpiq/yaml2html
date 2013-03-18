#!/usr/bin/env coffee

assert = require 'assert'
fs = require 'fs'
path = require 'path'

global.ok = assert.ok
yaml2html = require '../src/yaml2html.coffee'

tests = [ 'basic-document', 'tag-attributes', 'lone-tag' ]

getData = (filename) -> '' + fs.readFileSync path.join __dirname, filename

testFromFile = (testname) ->
  yamlString = getData testname + '.yaml'
  expectedHtmlString = getData testname + '.html'

  converter = new yaml2html.Yaml2Html()
  actualHtmlString = converter.convert(yamlString)

  # (require 'fs').writeFileSync __filename.replace(/coffee$/, 'out'), actualHtmlString

  ok actualHtmlString == expectedHtmlString,
    " got: '" + actualHtmlString + "', expected: '" + expectedHtmlString + "'"

testFile = (testname) ->
  result = '?'
  try
    testFromFile testname
    result = 'ok'
  catch e
    result = e
  console.log testname + ': ' + result

testFile file for file in tests
