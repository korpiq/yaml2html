#!/usr/bin/env coffee

assert = require 'assert'
fs = require 'fs'
path = require 'path'

global.ok = assert.ok
yaml2html = require '../src/yaml2html.coffee'

fs.readdir __dirname, (err, tests) ->
  throw err if err
  testIfYamlFile file for file in tests

testIfYamlFile = (filename) ->
  testname = filename.replace(/\.yaml$/, '')
  test testname if testname != filename

test = (testname) ->
  readFile testname + '.yaml', (err, yamlString) ->
    throw err if err
    readFile testname + '.html', (err, htmlString) ->
      throw err if err
      console.log testname + ': ' + testResult(yamlString, htmlString)

readFile = (filename, callback) ->
  fs.readFile path.join(__dirname, filename), callback

testResult = (yamlString, expectedHtmlString) ->
  try
    testContents(yamlString, expectedHtmlString)
    'ok'
  catch e
    e

testContents = (yamlString, expectedHtmlString) ->
  converter = new yaml2html.Yaml2Html()
  actualHtmlString = converter.convert(yamlString)

  ok actualHtmlString == '' + expectedHtmlString,
    "got:\n'" + actualHtmlString + "', expected:\n'" + expectedHtmlString + "'"
