class @FlowSelect
  constructor: (@solo_behaviour, @select, @form, @nested_name, @add_link, @add_block, @add_template) ->

    if @add_link
      $('body').on 'click', @add_link, =>
        $option = $(':selected', @select)
        if $option.length > 0 && $option.val() != ''
          $(add_block).append(@add_template($option.val(), $option.text(), @nested_name))


    $('body').on 'submit', @form, (e) =>
      e.preventDefault()
      e.stopPropagation()
      @send_form()

  template: (id, text) ->
    "<option value='#{id}' selected>#{text}</option>"

  input_template: (val, piece_name) ->
    "<input type='hidden' value='#{val}' name='#{@nested_name}[#{piece_name}]'>"

  proceed: (id, text) ->
    $('option', @select).attr('selected', false)
    $(@select).append(@template(id, text))
    unless @solo_behaviour
      $(@input_template(text)).insertAfter(@select)

  send_form: ->
    $form = $(@form)
    form_data = $form.serialize();
    form_action = $form.attr('action')
    form_method = $form.attr('method')

    $.ajax
      type: form_method
      url: "#{form_action}.json"
      data: form_data
      success: (response) =>
        if response.status
          @proceed(response.id, response.text)
