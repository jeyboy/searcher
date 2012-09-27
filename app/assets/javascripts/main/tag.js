//function hasOption(name) {
//    select.children( "option" )
//}

function deleteTag(elem) {
    elem = $(elem);
    var root = $(elem.closest('.tag'));
    if ((rel = elem.prop('rel')).length > 0) {
        var tag_name = root.find('.tag_name').html();
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
    else root.remove();
}