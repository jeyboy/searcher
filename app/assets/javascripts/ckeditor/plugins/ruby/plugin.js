(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:ruby_code>"+theSelectedText+"</cke:ruby_code>");
        return;
    }};
    CKEDITOR.plugins.add('ruby', {init:function (editor) {
        var commandName = 'ruby';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('Ruby', {label: "Ruby block", command:commandName, icon:this.path + "ruby.png"});
    }})
})();
