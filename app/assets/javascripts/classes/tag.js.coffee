window.tag =
  form_block: '#tag_form'

  tag_container: '.tag'

  send_form: ->
    $form = $(tag.form_block)
    form_data = $form.serialize();
    form_action = $form.attr('action')
    form_method = $form.attr('method')
    $('body').trigger('tag_add')    # not checked

    $.ajax
      method: form_method
      url: form_action
      data: form_data

  register_actions: ->
    $('body').on 'click', '.add_tag', ->
      tag.send_form()


    $('body').on 'click', '.remove_tag', ->
      uid = $(@).data('id')
      if uid
        $tag_obj = $(tag.tag_container, @)
        $body = $('body')
        $.ajax
          method: 'delete'
          url: "/taggables/#{uid}"
          success: (response)->
            if response
              $tag_obj.remove()
              $body.trigger('tag_remove')   # not checked