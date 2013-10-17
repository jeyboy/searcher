window.modal_window =
  modal_block_name: 'modal_block'

  modal_block: "##{@modal_block_name}"

  close_button: (classes = '', id = '', text = undefined, tag = 'a') ->
    "<#{tag} class='#{classes}' id='#{id}' data-dismiss='modal'>#{text || "×"}</#{tag}>"

  build_header: (data) ->
    $header = $('<div class="modal-header"></div>')
    $header
      .append(modal_window.close_button('close'))
      .append("<div>#{data}</div>")

  build_body: (data) ->
    $("<div class='modal-body'>#{data}</div>")

  build_footer: (data) ->
    $("<div class='modal-footer'>#{data}</div>")

  template: (header, body, footer)->
    $base = $('<div class="modal"></div>')
    $base
      .append(modal_window.build_header(header))
      .append(modal_window.build_body(body))
      .append(modal_window.build_footer(footer))

  show: (template, container_selector) ->
    $block = $(container_selector || modal_window.modal_block)

    if $block.length == 0
      $block = $("<div class='fade' id='#{modal_window.modal_block_name}'>#{template}</div>")
      $('body').append($block)
    else
      $block.html(template)

    $block.modal('show')
