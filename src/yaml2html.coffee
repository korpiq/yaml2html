#!/usr/bin/env coffee

class @Yaml2Html

  parser: require 'yamljs'
  htmlFormatterPackage: require (require 'path').join(__dirname, 'htmlFormatter.coffee')

  convert: (yamlString) ->
    (new @htmlFormatterPackage.HtmlFormatter).format @parser.parse('' + yamlString)

if process.argv[1] is __filename
  converter = new @Yaml2Html()
  fs = require 'fs'
  console.log converter.convert fs.readFileSync file for file in process.argv[2..]
