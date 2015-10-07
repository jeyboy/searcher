class Wysiwyg
  redactor: undefined

  root_container: '.with_panel_block'
  button_panel: '.panel_btns'
  content_panel: '.linked_content'
  editable_block_class: 'editable'

  inline_wrap: ['code']

  langs: ['codeblock', 'bash', 'yaml', 'javascript', 'coffeescript',
          'css', 'json', 'erb', 'slim', 'haml', 'html', 'xml', 'ruby', 'sql'
  ]


  btn_template: (name, icon_classes) ->
    "<button class='btn btn-default' alt='#{name}' title='#{name}'><span class='#{icon_classes}'></span></button>"

  frag_template_start: (name, classes) ->
    "<code class='#{name} #{classes}'>"

  frag_template_end: ->
    "</code>"

  block_template_start: (name, classes) ->
    "<pre>#{@frag_template_start(name, classes)}"

  block_template_end: ->
    "#{@frag_template_end()}</pre>"

  block_template: (name, classes) ->
    @block_template_start(name, classes).append(@block_template_end())


  constructor: (@textarea) ->
    @render_langs()
    @register_actions()


  render_langs: ->
    $btn_panel = $(@button_panel, @root_container)
    $body = $('body')

    for codeName in @inline_wrap
      codeact_name = "#{codeName}-act"
      $btn_panel.append(@btn_template(codeName, "#{codeName} #{codeact_name}"))
      $body.on('click', ".#{codeact_name}", @wrap_block(codeName, @frag_template_start(codeName, @editable_block_class), @frag_template_end()))

    for langName in @langs
      act_name = "#{langName}-act"
      $btn_panel.append(@btn_template(langName, "#{langName} #{act_name}"))
      $body.on('click', ".#{act_name}", @insert_block(langName))


  wrap_block: (classes, wrap_start, wrap_end) ->
    $(@root_container)
      .selection('insert', {text: wrap_start, mode: 'before'})
      .selection('insert', {text: wrap_end, mode: 'after'});

  insert_block: (classes) ->
    if (String(@curr_selection()).length > 0)
      @wrap_block(classes, @block_template_start(classes, @editable_block_class), @block_template_end())
    else
      $(@content_panel, @root_container)
        .append(@block_template(classes, @editable_block_class))


  curr_selection: () ->
    $(@root_container).selection();
