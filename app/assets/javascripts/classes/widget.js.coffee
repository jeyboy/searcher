window.box_widget =
  register_actions: ->
    $("body").on "click", ".box-widget-head .mini", ->

    $("body").on "click", ".box-widget-head .norm", ->

    $("body").on "click", ".box-widget-head .maxi", ->
