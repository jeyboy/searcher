#= require ./bootstrap
#= require ./summernote.min
#= require ./highlight.pack
#= require ./masonry.min
#= require_self

$ ->
  $('#editor').summernote(
    height: '300'
    oninit: ->
#      codeNode = document.createElement('pre');
#      codeNode.appendChild(document.createElement('code'))
      $additional_tools = $('<div class="additional-toolbar"></div>')

      $.each(['code', 'code_block', 'bash', 'coffeescript', 'css', 'erb', 'haml',
              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
        $("<div class='note-style btn-group'><button id='#{lang}Btn' type='button' class='btn btn-default btn-sm btn-small' title='#{lang}' data-event='something' tabindex='-1'><img src='/assets/languages/#{lang}.png'></button></div>").appendTo($additional_tools)
      )

      $('body').on 'click', '#codeBtn', ->
#        selection.create().wrap(codeNode.cloneNode(true))
        sel = selection.create()
        sel.wrap("<code>" + sel.toString() + "</code>")

      $('body').on 'click', '#code_blockBtn', ->
#        selection.create().wrap(codeNode.cloneNode(true))
        sel = selection.create()
        sel.wrap("<pre><code>" + sel.toString() + "</code></pre>")


      $.each(['bash', 'coffeescript', 'css', 'erb', 'haml',
              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
        $('body').on 'click', "##{lang}Btn", ->
          sel = selection.create()
          sel.wrap("<pre><code class='" + lang + "'>" + sel.toString() + "</code></pre>")
      )

      $additional_tools.appendTo($('.note-toolbar'));
  );
