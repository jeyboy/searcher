$ ->
#########################post form###############################

  new FlowSelect(
    true
    '#category'
    '#category_form'
    'post[category_attributes][]'
  )
  new FlowSelect(
    false
    '#tag'
    '#tag_form'
    'post[tag_ids][]'
    '.add_tag'
    '.tags_block'
    (id, text, name) ->
      window.tag_template.replace('$1', id).replace('$2', text).replace('$3', name)
  )

  $('body').on 'click', '.remove_tag', ->
    $(@).closest('.tag').remove()

#  $('body').on 'click', '.remove_taggable', ->
#    $tag = $(@).closest('.tag')
#    uid = $(@).data('target')
#
#    $.ajax
#      url: "/taggables/#{uid}"
#      type: 'DELETE'
#      success: (response) ->
#        if response
#          $tag.remove()


#  summernote patch
  $('body').on 'submit', '.new_post, .edit_post', ->
    code_text = encodeURIComponent($('#editor').code())
    $(@).append("<textarea style='display: none' name='post[body]'>#{code_text}</textarea>")
#########################m###############################


#########################indexm###############################

  $('body').on 'click', '.box-widget-body', ->
    $url = $(@).closest('.box-widget').data('url')
    console.log($url)
    $.ajax
      url: $url
      success: (response) ->
        if response.status
          template = modal_window.template(response.title, response.body)
          modal_window.show(template, true)

#########################m###############################