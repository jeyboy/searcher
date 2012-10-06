(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:haml_code>"+theSelectedText+"</cke:haml_code>");
        return;
    }};
    CKEDITOR.plugins.add('haml', {init:function (editor) {
        var commandName = 'haml';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('HAML', {label: "HAML block", command:commandName, icon:this.path + "haml.png"});
    }})
})();
