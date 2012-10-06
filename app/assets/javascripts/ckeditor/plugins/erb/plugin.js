(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:erb_code>"+theSelectedText+"</cke:erb_code>");
        return;
    }};
    CKEDITOR.plugins.add('erb', {init:function (editor) {
        var commandName = 'erb';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('Erb', {label: "Erb block", command:commandName, icon:this.path + "erb.png"});
    }})
})();
