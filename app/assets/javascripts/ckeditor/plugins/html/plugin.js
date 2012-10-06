(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:html_code>"+theSelectedText+"</cke:html_code>");
        return;
    }};
    CKEDITOR.plugins.add('html', {init:function (editor) {
        var commandName = 'html';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('HTML', {label: "HTML block", command:commandName, icon:this.path + "html.png"});
    }})
})();
