#= require jquery
#= require jquery_ujs

# require foundation
# Temp inclusion - fix - remove after gem bumped to 5.03
#= require ./foundation.5.0.3
#= require foundation/foundation.abide
#= require foundation/foundation.accordion
#= require foundation/foundation.alert
#= require foundation/foundation.clearing
#= require foundation/foundation.dropdown
#= require foundation/foundation.interchange
#= require foundation/foundation.joyride
#= require foundation/foundation.magellan
#= require foundation/foundation.offcanvas
#= require foundation/foundation.orbit
#= require foundation/foundation.reveal
#= require foundation/foundation.tab
#= require foundation/foundation.tooltip
#= require foundation/foundation.topbar


#= require ./summernote.min
#= require ./highlight.pack
#= require_self

set_parent = (node, parent_node) ->
  parent = node.parentNode;
  parent.insertBefore(parent_node, node.nextSibling);
  parent_node.appendChild(node)

$ ->
  $(document).foundation()

#  hljs.initHighlightingOnLoad()
  $('.posts_body pre code').each((i, e)-> hljs.highlightBlock(e))


  $('#editor').summernote(
    height: '300'
    oninit: ->
      $additional_tools = $('<div class="additional-toolbar"></div>')

      $.each(['code', 'code_block', 'bash', 'coffeescript', 'css', 'erb', 'haml',
              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
        $("<div class='note-style btn-group'><button data-original-title='#{lang.titleize} code block' id='#{lang}Btn' type='button' class='btn btn-default btn-sm btn-small' title='#{lang}' data-event='something' tabindex='-1'><img src='/assets/languages/#{lang}.png'></button></div>").appendTo($additional_tools)
      )

      $('body').on 'click', '#codeBtn', ->
        codeNode = document.createElement('code');
        selection.create().wrap(codeNode)

      $('body').on 'click', '#code_blockBtn', ->
        codeNode = document.createElement('code');
        selection.create().wrap(codeNode)
        set_parent(codeNode, document.createElement('pre'))

      $.each(['bash', 'coffeescript', 'css', 'erb', 'haml',
              'html', 'javascript', 'json', 'ruby', 'sql', 'xml', 'yaml'], (i, lang) ->
        $('body').on 'click', "##{lang}Btn", ->
          codeNode = document.createElement('code');
          codeNode.setAttribute('class', lang);
          selection.create().wrap(codeNode)
          set_parent(codeNode, document.createElement('pre'))
      )

#      .appendTo($additional_tools)

      $additional_tools.appendTo($('.note-toolbar'));

#      preview_block = '<div id="preview"></div>'
#      $(preview_block).insertAfter('.note-editor')
  );
