#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap

#= require ./libraries/index
#= require ./classes/index
#= require_tree ./application
#= require_self

$ ->
  $('body').on 'click', '.modal_submit', ->
    $('form', $(@).closest('.modal')).submit()

#  $('body').on 'click', '.toggle', ->
#    $target = $($(@).attr('href'))
#
#    if $target.is(':visible')
#      $target.hide()
#    else
#      $target.show()