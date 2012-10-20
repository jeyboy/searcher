//function hasOption(name) {
//    select.children( "option" )
//}

function deleteTag(elem) {
    elem = $(elem);
    var root = $(elem.closest('.tag'));
    var tag_name = root.find('.tag_name').html();
    if ((rel = elem.prop('rel')).length > 0) {
        $.ajax({
            type: 'POST',
            url: "/posts/" + rel + "/delete_tag",
            data: {tag: tag_name},
            success: function(data) {
                if (data.status)
                    root.remove();
            }
        });
    }
    else {
        root.remove();
        $(':hidden[rel="tag"]').filter(function(){ return $(this).val() === tag_name;}).remove();
    }
}

function loadByTag(tag) {
    $.ajax({ url: "/posts/index_by_tags.js?tags%5B%5D=" + tag });
    $(document).scrollTop(0);
}