(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:sql_code>"+theSelectedText+"</cke:sql_code>");
        return;
    }};
    CKEDITOR.plugins.add('sql', {init:function (editor) {
        var commandName = 'sql';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('SQL', {label: "SQL block", command:commandName, icon:this.path + "sql.png"});
    }})
})();
