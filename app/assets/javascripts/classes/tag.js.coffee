window.tag =
#  form_block: '#tag_form'
  edit_form_call: '.edit_tag_btn'

  tag_container: '.tag'
  tags_select: '#tag'

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
    $('body').on 'change', tag.tags_select, ->
      $edit_button = $(tag.edit_form_call)
      if ($(':selected', @).attr('value').length > 0)
        $edit_button.removeClass('hide')
      else
        $edit_button.addClass('hide')

    $('body').on 'click', tag.edit_form_call, ->
      console.log('dsf')
      $modal_elem = $("#edit_tag_modal")
      $.ajax
        type: 'GET'
        url: "/tags/#{$(':selected', tag.tags_select).attr('value')}/edit"
        success: (response) ->
          $('.modal-body', $modal_elem).html(response.content)
          $modal_elem.modal()

#    $('body').on 'submit', tag.form_block, ->
#      tag.send_form()
#
#    $('body').on 'click', '.remove_tag', ->
#      uid = $(@).data('id')
#      if uid
#        $tag_obj = $(tag.tag_container, @)
#        $.ajax
#          method: 'delete'
#          url: "/taggables/#{uid}"
#          success: (response)->
#            if response
#              $tag_obj.remove()
