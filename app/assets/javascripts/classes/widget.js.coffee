window.box_widget =

  register_actions: ->
    $("body").on "click", ".box-widget-head .btn-mini", ->
      $widget = $(@).closest('.box-widget')
      $('.box-widget-body', $widget).hide()

    $("body").on "click", ".box-widget-head .btn-norm", ->
      $widget = $(@).closest('.box-widget')
      $('.box-widget-body', $widget).show()

    $("body").on "click", ".box-widget-head .btn-close", ->
      $(@).closest('.box-widget').remove()
      $('.js-masonry').masonry()