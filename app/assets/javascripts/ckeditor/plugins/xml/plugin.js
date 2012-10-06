(function () {
    var embedCmd = {exec:function (editor) {
        var theSelectedText = editor.getSelection().getNative();
        editor.insertHtml("<cke:xml_code>"+theSelectedText+"</cke:xml_code>");
        return;
    }};
    CKEDITOR.plugins.add('xml', {init:function (editor) {
        var commandName = 'xml';
        editor.addCommand(commandName, embedCmd);
        editor.ui.addButton('XML', {label: "Xml block", command:commandName, icon:this.path + "xml.png"});
    }})
})();
