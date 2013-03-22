
class @HtmlFormatter

  format: (data) -> @dataToHtml data, ''

  dataToHtml: (data, indent) ->
    if 'object' is typeof data
    then @convertObject data, indent
    else '' + data

  convertObject: (object, indent) ->
    if object instanceof Array
    then @convertList object, indent
    else @convertMap object, indent

  convertList: (list, indent) ->
    (@newlineBeforeIndent indent) +
      ((@dataToHtml item, indent) for item in list).join ''

  newlineBeforeIndent: (indent) ->
    if indent.length > 0 then '\n' else ''

  convertMap: (object, indent) ->
    (@tag(key, value, indent) for key, value of object).join ''

  tag: (key, value, indent) ->
    [ attributes, content ] =
      if @isMap value
      then [
          if value.attributes then @attributes(value.attributes) else '',
          if value.content then value.content else ''
      ] else [ '', @value(value, indent) ]

    indent + '<' + key + attributes +
    (
      if content
      then '>' + content + '</' + key.replace(/\s.*/, '')
      else if attributes
      then ' /'
      else '/'
    ) + '>\n'

  attributes: (attributes) ->
    (@attribute key, value for key, value of attributes).join ''

  attribute: (name, value) ->
    ' ' + name + '="' + value + '"'

  value: (value, indent) ->
    if 'object' is typeof value
    then (@convertObject value, '    ' + indent) + indent
    else value

  isMap: (value) ->
    value isnt null and 'object' is typeof value and value not instanceof Array
