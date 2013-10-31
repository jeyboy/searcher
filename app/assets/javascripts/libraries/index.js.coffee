#= require ./bootstrap
#= require ./summernote.min
#= require ./highlight.pack
#= require ./masonry.min
#= require_self

$ ->
  $('#editor').summernote(
    height: '300'
    oninit: ->
#      $additional_tools = $('<div class="additional-toolbar"></div>')
#
#      $.each(['code', 'bash', 'coffeescript', 'css', 'erb', 'haml',
#              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
#        $("<div class='note-style btn-group'><button id='#{lang}Btn' type='button' class='btn btn-default btn-sm btn-small' title='#{lang}' data-event='something' tabindex='-1'><img src='/assets/languages/#{lang}.png'></button></div>").appendTo($additional_tools)
#      )
#
##      r = $('#editor').summernoteInner().range.create()
##      r.insertNode($('<span id="notate">' + r.toString() + '</span>')[0])
#
#
#      $('body').on 'click', '#codeBtn', ->
#        editor.formatBlock(makeLayoutInfo.editable(), 'code');
#
#      $.each(['bash', 'coffeescript', 'css', 'erb', 'haml',
#              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
#        $('body').on 'click', "##{lang}Btn", ->
#          "<code class='bash'>" + this.getSelectedHTML() + "</code>"
#      )
#
#
#      $additional_tools.appendTo($('.note-toolbar'));
  );
