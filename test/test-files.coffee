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
  readFile testname + '.yaml', (yamlString) ->
    readFile testname + '.html', (htmlString) ->
      console.log testname + ': ' + testResult(yamlString, htmlString)

readFile = (filename, callback) ->
  fullname = path.join(__dirname, filename)
  fs.readFile fullname, (err, data) ->
    throw "failed to read file '#{fullname}': " + err if err
    callback '' + data

testResult = (yamlString, expectedHtmlString) ->
  try
    testContents(yamlString, expectedHtmlString)
    'ok'
  catch e
    e.message

testContents = (yamlString, expectedHtmlString) ->
  converter = new yaml2html.Yaml2Html()
  actualHtmlString = converter.convert(yamlString)
  ok actualHtmlString == '' + expectedHtmlString,
    "got:\n'" + actualHtmlString + "', expected:\n'" + expectedHtmlString + "'"
