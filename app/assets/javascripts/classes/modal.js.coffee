window.modal_window =
  modal_block_name: 'modal_block'

  close_button: (classes = '', id = '', text = undefined, tag = 'a') ->
    "<#{tag} class='close #{classes}' id='#{id}' data-dismiss='modal' aria-hidden='true'>#{text || "×"}</#{tag}>"

  build_header: (data) ->
    $header = $('<div class="modal-header"></div>')
    $header
      .append(modal_window.close_button('close'))
      .append("<div>#{data}</div>")

  build_body: (data) ->
    $("<div class='modal-body'>#{data}</div>")

  build_footer: (data) ->
    $("<div class='modal-footer'>#{data || '&nbsp;'}</div>")

  template: (header, body, footer, id)->
    $base = $("<div class='modal fade' id='#{id || modal_window.modal_block_name}' role='dialog'></div>")
    $base
      .append(modal_window.build_header(header))
      .append(modal_window.build_body(body))
      .append(modal_window.build_footer(footer))

  show: (template, fullscreen, container_selector) ->
    $block = $(container_selector || "##{modal_window.modal_block_name}")

    if $block.length == 0
      $('body').append($block = $(template))
    else
      $block.replaceWith($new_block = $(template))
      $block = $new_block

    if fullscreen
      $block.addClass('full-screen')
    else
      $block.removeClass('full-screen')

    $block.modal('show')

  hide: (selector) ->
    $(selector || '.modal').modal('hide')