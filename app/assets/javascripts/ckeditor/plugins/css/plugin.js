(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:css_code>"+theSelectedText+"</cke:css_code>");
        return;
    }};
    CKEDITOR.plugins.add('css', {init:function (editor) {
        var commandName = 'css';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('Css', {label: "Css block", command:commandName, icon:this.path + "css.png"});
    }})
})();
