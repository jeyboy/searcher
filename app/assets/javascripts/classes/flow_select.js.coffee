class @FlowSelect
  constructor: (@select, @form, @nested_name, @create_link, @add_link, @add_block, @add_template) ->

    if @add_link
      $('body').on 'click', @add_link, ->
        option = $(':selected', @select)
        if option.length > 0
          $(add_block).append(@add_template(option.val(), option.text()))


    if @create_link
      $('body').on 'click', @create_link, ->
        @send_form()

  template: (id, text) ->
    "<option value='#{id}' selected>#{text}</option>"

  input_template: (val) ->
    "<input type='hidden' value='#{val}' name='#{@nested_name}'>"

  proceed: (id, text) ->
    $('option', @select).attr('selected', false)
    $(@select).append(@template(id, text))
    $(@input_template(text)).insertAfter(@select)

  send_form: ->
    $form = $(@form)
    form_data = $form.serialize();
    form_action = $form.attr('action')
    form_method = $form.attr('method')

    $.ajax
      type: form_method
      url: form_action
      data: form_data
      success: (response) ->
        if response.status
          @proceed(response.id, response.text)