#= require ./bootstrap
#= require ./summernote.min
#= require ./highlight.pack
#= require ./masonry.min
#= require_self

set_parent = (node, parent_node) ->
  parent = node.parentNode;
  parent.insertBefore(parent_node, node.nextSibling);
  parent_node.appendChild(node)

$ ->
#  hljs.initHighlightingOnLoad()
  $('.posts_body pre code').each((i, e)-> hljs.highlightBlock(e))


  $('#editor').summernote(
    height: '300'
#    onInit: ->
#      $additional_tools = $('<div class="additional-toolbar"></div>')
#
#      $.each(['code', 'code_block', 'bash', 'coffeescript', 'css', 'erb', 'haml',
#              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
#        $("<div class='note-style btn-group'><button data-original-title='#{lang.titleize} code block' id='#{lang}Btn' type='button' class='btn btn-default btn-sm btn-small' title='#{lang}' data-event='something' tabindex='-1'><img src='/assets/languages/#{lang}.png'></button></div>").appendTo($additional_tools)
#      )
#
#      $('body').on 'click', '#codeBtn', ->
#        codeNode = document.createElement('code');
#        selection.create().wrap(codeNode)
#
#      $('body').on 'click', '#code_blockBtn', ->
#        codeNode = document.createElement('code');
#        selection.create().wrap(codeNode)
#        set_parent(codeNode, document.createElement('pre'))
#
#      $.each(['bash', 'coffeescript', 'css', 'erb', 'haml',
#              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
#        $('body').on 'click', "##{lang}Btn", ->
#          highlight = window.getSelection()
#          codeNode = document.createElement('code')
#          codeNode.setAttribute('class', lang)
#          range = $('#editor').summernote("createRange")
#          console.log(range)
#
##          selection.create().wrap(codeNode)
##          set_parent(codeNode, document.createElement('pre'))
#      )
#
#
##      $('#makeSnote').click (event) ->
##    highlight = window.getSelection()
##    spn = '<span class="snote" style="color:blue;">' + highlight + '</span>'
##    text = $('.note-editable').children('p').text()
##    range = highlight.getRangeAt(0)
##    startText = text.substring(0, range.startOffset)
##    endText = text.substring(range.endOffset, text.length)
##    $('.note-editable').html startText + spn + endText
##  return
#
#
#
##      .appendTo($additional_tools)
#
#      $additional_tools.appendTo($('.note-toolbar'));
  );
