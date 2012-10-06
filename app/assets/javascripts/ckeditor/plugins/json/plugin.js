(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:json_code>"+theSelectedText+"</cke:json_code>");
        return;
    }};
    CKEDITOR.plugins.add('json', {init:function (editor) {
        var commandName = 'json';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('JSON', {label: "JSON block", command:commandName, icon:this.path + "json.png"});
    }})
})();
