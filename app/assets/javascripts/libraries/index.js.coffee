#= require ./bootstrap
#= require ./summernote.min
#= require ./highlight.pack
#= require_self

$ ->
  $('#editor').summernote(
    height: '55%'
#    oninit: function() {
#      // Add "open" - "save" buttons
#      var openBtn = '<button id="openFileBtn" type="button" class="btn btn-default btn-sm btn-small" title="Open file" data-event="something" tabindex="-1"><i class="icon-edit"></i></button>';
#      var saveBtn = '<button id="saveFileBtn" type="button" class="btn btn-default btn-sm btn-small" title="Save Template" data-event="something" tabindex="-1"><i class="icon-download-alt"></i></button>';
#      var fileGroup = '<div class="note-file btn-group">' + openBtn + saveBtn + '</div>';
#      $(fileGroup).prependTo($('.note-toolbar'));
#      // Button tooltips
#      $('#openFileBtn').tooltip({container: 'body', placement: 'bottom'});
#      $('#saveFileBtn').tooltip({container: 'body', placement: 'bottom'});
#      // Button events
#      $('#openFileBtn').click(function(event) {
#      loadContent(editor);
#      });
#      $('#saveFileBtn').click(function(event) {
#      saveContent(editor);
#      });
#    }
  );
