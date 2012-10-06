(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:yaml_code>"+theSelectedText+"</cke:yaml_code>");
        return;
    }};
    CKEDITOR.plugins.add('yaml', {init:function (editor) {
        var commandName = 'yaml';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('YAML', {label: "Yaml block", command:commandName, icon:this.path + "yaml.png"});
    }})
})();
