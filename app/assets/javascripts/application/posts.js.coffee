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
    'post[taggables_attributes][][tag_attributes]'
    '.add_tag'
    '.tags_block'
    (id, text) ->
      window.tag_template.replace('$1', id).replace('$2', text)
  )
