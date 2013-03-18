#!/usr/bin/env coffee

class @Yaml2Html

  parser: require 'yamljs'
  htmlFormatterPackage: require (require 'path').join(__dirname, 'htmlFormatter.coffee')

  convert: (yamlString) ->
    (new @htmlFormatterPackage.HtmlFormatter).format @parser.parse('' + yamlString)

  convertFile: (filename) ->
    @convert (require 'fs').readFileSync file

if process.argv[1] is __filename
  converter = new @Yaml2Html()
  fs = require 'fs'
  process.stdout.write converter.convertFile file for file in process.argv[2..]
