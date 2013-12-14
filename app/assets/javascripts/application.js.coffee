#= require ./libraries/index
#= require ./classes/index
#= require_tree ./application
#= require_self

$ ->
  $('body').on 'click', '.restore_form_button', ->
    $('.restore_form input[type=file]').click()

  $('body').on 'change', '.restore_form input[type=file]', ->
    $(@).closest('form').submit()

  $('body').on 'click', '.modal_submit', ->
    $('form', $(@).closest('.modal')).submit()

  $(document).on 'keydown', (e) ->
    code = parseInt(if e.keyCode then e.keyCode else e.which)
    switch code
      when 27 # ESC
        window.modal_window.hide()
