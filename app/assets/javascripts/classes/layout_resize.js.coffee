$ ->
  resize_values = {
    sidebar_elem: $('.sidebar')
    posts_elem: $('.posts_body')
    navbar_elem: $('.navbar')
  }

  getViewport = ->
    viewPortWidth = undefined
    viewPortHeight = undefined

    # the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
    unless typeof window.innerWidth is "undefined"
      viewPortWidth = window.innerWidth
      viewPortHeight = window.innerHeight

      # IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
    else if typeof document.documentElement isnt "undefined" and typeof document.documentElement.clientWidth isnt "undefined" and document.documentElement.clientWidth isnt 0
      viewPortWidth = document.documentElement.clientWidth
      viewPortHeight = document.documentElement.clientHeight

      # older versions of IE
    else
      viewPortWidth = document.getElementsByTagName("body")[0].clientWidth
      viewPortHeight = document.getElementsByTagName("body")[0].clientHeight
    [viewPortWidth, viewPortHeight]

  get_elem_facing = ($elem) ->
    $elem.outerHeight(true) - $elem.height()

  resizeContent = (height) ->
    resize_values.posts_elem.css('height', height)


  resizeSidebar = (height) ->
    $blocks = $('.sidebar .vblock')
    height -= (get_elem_facing($blocks) * $blocks.length) + 10 # 10 is a margin
    block_height = height / $blocks.length

    a_height = $blocks.first().prop('scrollHeight') #height()
    b_height = $blocks.last().prop('scrollHeight') #height()

    a_rel = a_height >= block_height
    b_rel = b_height >= block_height

    if a_rel && b_rel
      $blocks.css('height', block_height)
    else if a_rel
      $blocks.first().css('height', block_height + block_height - b_height)
      $blocks.last().css('height', 'inherit')
    else
      $blocks.last().css('height', block_height + block_height - a_height)
      $blocks.first().css('height', 'inherit')


  $(window).resize ->
    navbar_height = resize_values.navbar_elem.outerHeight(true)
    fact_height = getViewport()[1] - navbar_height
    resizeSidebar(fact_height)
    resizeContent(fact_height)

  $(window).trigger('resize')
