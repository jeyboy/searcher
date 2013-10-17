window.tag =
  form_block: '#tag_form'

  tag_container: '.tag'

  send_form: ->
    $form = $(tag.form_block)
    form_data = $form.serialize();
    form_action = $form.attr('action')
    form_method = $form.attr('method')

    $.ajax
      type: form_method
      url: form_action
      data: form_data

  register_actions: ->
    $('body').on 'submit', tag.form_block, ->
      tag.send_form()

    $('body').on 'click', '.remove_tag', ->
      uid = $(@).data('id')
      if uid
        $tag_obj = $(tag.tag_container, @)
        $.ajax
          method: 'delete'
          url: "/taggables/#{uid}"
          success: (response)->
            if response
              $tag_obj.remove()
