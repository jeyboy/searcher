$(function() {
    $(".redactor").htmlarea({
        css: "/assets/libraries/jHtmlArea/jHtmlArea.Editor.css",
        toolbar: [
            ["html", "|", "cut", "copy", "paste"],
            ["bold", "italic", "underline", "strikethrough", "|", "subscript", "superscript", "|", "indent", "outdent", "|", "justifyleft", "justifycenter", "justifyright", "|" ,"increasefontsize", "decreasefontsize"],
            ["p", "h1", "h2", "h3", "h4", "h5", "h6", "|", "orderedlist", "unorderedlist", "|", "link", "unlink", "image", "horizontalrule"],
            [
                {
                    css: "code_blck",
                    text: "Raw code block",
                    action: function(btn) { this.pasteHTML("<code>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "bash_blck",
                    text: "Bash code block",
                    action: function(btn) { this.pasteHTML("<code class='bash'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "coffeescript_blck",
                    text: "CoffeeScript code block",
                    action: function(btn) { this.pasteHTML("<code class='coffescript'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "css_blck",
                    text: "CSS code block",
                    action: function(btn) { this.pasteHTML("<code class='css'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "erb_blck",
                    text: "ERB code block",
                    action: function(btn) { this.pasteHTML("<code class='erb'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "haml_blck",
                    text: "HAML code block",
                    action: function(btn) { this.pasteHTML("<code class='haml'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "javascript_blck",
                    text: "Javascript code block",
                    action: function(btn) { this.pasteHTML("<code class='javascript'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "json_blck",
                    text: "JSON code block",
                    action: function(btn) { this.pasteHTML("<code class='json'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "ruby_blck",
                    text: "Ruby code block",
                    action: function(btn) { this.pasteHTML("<code class='ruby'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "sql_blck",
                    text: "SQL code block",
                    action: function(btn) { this.pasteHTML("<code class='sql'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "xml_blck",
                    text: "XML code block",
                    action: function(btn) { this.pasteHTML("<code class='xml'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "html_blck",
                    text: "HTML code block",
                    action: function(btn) { this.pasteHTML("<code class='html'>" + this.getSelectedHTML() + "</code>"); }
                },
                {
                    css: "yaml_blck",
                    text: "YAML code block",
                    action: function(btn) { this.pasteHTML("<code class='yaml'>" + this.getSelectedHTML() + "</code>"); }
                }
            ]
        ]
    });
});


//$("#txtCustomHtmlArea").htmlarea({
//    // Override/Specify the Toolbar buttons to show
//    toolbar: [
//        ["bold", "italic", "underline", "|", "forecolor"],
//        ["p", "h1", "h2", "h3", "h4", "h5", "h6"],
//        ["link", "unlink", "|", "image"],
//        [{
//            // This is how to add a completely custom Toolbar Button
//            css: "custom_disk_button",
//            text: "Save",
//            action: function(btn) {
//                // 'this' = jHtmlArea object
//                // 'btn' = jQuery object that represents the <A> "anchor" tag for the Toolbar Button
//                alert('SAVE!\n\n' + this.toHtmlString());
//            }
//        }]
//    ],
//
//    // Override any of the toolbarText values - these are the Alt Text / Tooltips shown
//    // when the user hovers the mouse over the Toolbar Buttons
//    // Here are a couple translated to German, thanks to Google Translate.
//    toolbarText: $.extend({}, jHtmlArea.defaultOptions.toolbarText, {
//        "bold": "fett",
//        "italic": "kursiv",
//        "underline": "unterstreichen"
//    }),
//
//    // Specify a specific CSS file to use for the Editor
//    css: "style//jHtmlArea.Editor.css",
//
//    // Do something once the editor has finished loading
//    loaded: function() {
//        //// 'this' is equal to the jHtmlArea object
//        //alert("jHtmlArea has loaded!");
//        //this.showHTMLView(); // show the HTML view once the editor has finished loading
//    }
//});
//});