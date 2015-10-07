class @Wysiwyg
  redactor: undefined

  root_container: '.with_panel_block'
  button_panel: '.panel_btns'
  content_panel: '.linked_content'
  editable_block_class: 'editable'

  inline_wrap: ['code']

  langs: ['codeblock', 'bash', 'yaml', 'javascript', 'coffeescript',
          'css', 'json', 'erb', 'slim', 'haml', 'html', 'xml', 'ruby', 'sql'
  ]


  btn_template: (name, wrap_classes, icon_classes) ->
    "<a class='btn btn-default #{wrap_classes}' alt='#{name}' title='#{name}'><span class='#{icon_classes} widget-icon'></span></a>"

  frag_template_start: (name, classes) ->
    "<code class='#{name} #{classes}'>"

  frag_template_end: ->
    "</code>"

  block_template_start: (name, classes) ->
    "<pre>#{@frag_template_start(name, classes)}"

  block_template_end: ->
    "#{@frag_template_end()}</pre>"

  block_template: (name, classes) ->
    @block_template_start(name, classes) + (@block_template_end())


  constructor: (@textarea) ->
    @render_langs()


  render_langs: ->
    $btn_panel = $(@button_panel, @root_container)

    textact_name = "textblock-act"
    $btn_panel.append(@btn_template('textblock', textact_name, 'textblock'))
    $(".#{textact_name}").on('click', @, @insert_text)

    for codeName in @inline_wrap
      codeact_name = "#{codeName}-act"
      $btn_panel.append(@btn_template(codeName, codeact_name, codeName))
      $(".#{codeact_name}").on('click', @, @wrap_fragment)

    for langName in @langs
      act_name = "#{langName}-act"
      $btn_panel.append(@btn_template(langName, act_name, langName))
      $(".#{act_name}").on('click', @, @insert_block)


  wrap_fragment: (e) ->
    cName = $(@).attr('alt')
    kl = e.data
    kl.wrap_block(cName, kl.frag_template_start(cName), kl.frag_template_end())

  wrap_block: (classes, wrap_start, wrap_end) ->
    $area = $('textarea', @root_container) # selection worked only with textarea and inputs

    $area
      .selection('insert', {text: wrap_start, mode: 'before'})
      .selection('insert', {text: wrap_end, mode: 'after'});

    $area.focus()
    

  insert_text: (e) ->
    kl = e.data
    $(kl.content_panel, kl.root_container)
      .append("<div class='#{kl.editable_block_class}'><p></p></div>")

  insert_block: (e) ->
    cName = $(@).attr('alt');
    kl = e.data

    console.log('insert', String(kl.curr_selection()).length)
    if (String(kl.curr_selection()).length > 0)
      kl.wrap_block(cName, kl.block_template_start(cName, kl.editable_block_class), kl.block_template_end())
    else
      $(kl.content_panel, kl.root_container)
        .append(kl.block_template(cName, kl.editable_block_class))


  curr_selection: () ->
    $(@root_container).selection()
