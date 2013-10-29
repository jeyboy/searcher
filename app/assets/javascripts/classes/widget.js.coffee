window.box_widget =
#  update_bootstrap_margin: ->
#    $boxes = $('.box-widget')
#    margin = $boxes.attr('margin-left')

  register_actions: ->
    $("body").on "click", ".box-widget-head .mini", ->

    $("body").on "click", ".box-widget-head .norm", ->

    $("body").on "click", ".box-widget-head .maxi", ->
