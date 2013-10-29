$ ->
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
    $(@).append("<input type='hidden' value='#{code_text}' name='post[body]'>")
