(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:javascript_code>"+theSelectedText+"</cke:javascript_code>");
        return;
    }};
    CKEDITOR.plugins.add('javascript', {init:function (editor) {
        var commandName = 'javascript';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('Javascript', {label: "Javascript block", command:commandName, icon:this.path + "javascript.png"});
    }})
})();
