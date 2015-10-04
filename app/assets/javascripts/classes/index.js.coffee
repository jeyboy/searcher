#= require ./widget
#= require ./modal
#= require ./flow_select
#= require ./selection
#= require ./layout_resize
#= require ./tag
#= require_self

$ ->
  box_widget.register_actions()
  tag.register_actions()
