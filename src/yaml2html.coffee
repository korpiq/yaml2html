
class @Yaml2Html

  parser: require 'yamljs'

  convert: (yamlString) ->
    @joinlist @parser.parse('' + yamlString), '', ''

  joinlist: (list, indent) ->
    got = if indent.length > 0 then '\n' else ''
    got += (@inside value, indent) for value in list
    got

  inside: (object, indent) ->
    got = ''
    got += @pair(key, value, indent) for key, value of object
    got

  pair: (key, value, indent) ->
    indent + '<' + key + '>' + @value(value, indent) + '</' + key + '>\n'

  value: (value, indent) ->
    if 'object' is typeof value
    then (@joinlist value, '    ' + indent) + indent
    else value
