$(document).ready(
  function(){
      var csrf_token = $('meta[name=csrf-token]').attr('content');
      var csrf_param = $('meta[name=csrf-param]').attr('content');
      var params;
      if (csrf_param !== undefined && csrf_token !== undefined) {
        params = csrf_param + "=" + encodeURIComponent(csrf_token);
      }

      function language_callback(obj, event, key)
      {
          var selected = obj.$el.getSelected();
          if (selected.length == 0)
            selected = "&nbsp;";
          obj.$el.insertHtml("<code class='" + key + "'>" + selected + "</code>");
//          move cursor inner tag
      }

      function clean_text_callback(obj, event, key) {
          var html = obj.getSelectedHtml();
          html = html.replace(/(<([^>]+)>)/ig,"");
          obj.insertHtml(html);
      }

      $('.redactor').redactor(
        { "imageUpload":"/redactor_rails/pictures?" + params,
          "imageGetJson":"/redactor_rails/pictures",
          "path":"/assets/redactor-rails",
          "css":"style.css",
          "fixed": true,
          "wym": true,
          "focus": true,
          "buttonsAdd": ['|', 'clean_text', '|', 'ruby_code', 'erb_code', 'haml_code', 'html_code', 'css_code', 'coffeescript', 'javascript_code',
                         'json_code', 'xml_code', 'yaml_code', 'sql_code', 'bash'],
          "buttonsCustom": {
            "clean_text": {
              "title": 'Clean selection formatting',
              "callback": clean_text_callback
            },
            "ruby_code": {
              "title": 'Ruby block',
              "callback": language_callback
            },
            "erb_code": {
              "title": 'ERB block',
              "callback": language_callback
            },
            "haml_code": {
              "title": 'HAML block',
              "callback": language_callback
            },
            "html_code": {
              "title": 'HTML block',
              "callback": language_callback
            },
            "css_code": {
              "title": 'CSS block',
              "callback": language_callback
            },
            "javascript_code": {
              "title": 'Javascript block',
              "callback": language_callback
            },
            "json_code": {
              "title": 'JSON block',
              "callback": language_callback
            },
            "xml_code": {
              "title": 'XML block',
              "callback": language_callback
            },
            "yaml_code": {
              "title": 'YAML block',
              "callback": language_callback
            },
            "sql_code": {
              "title": 'SQL block',
              "callback": language_callback
            },
            "bash": {
              "title": 'Bash block',
              "callback": language_callback
            },
            "coffeescript": {
              "title": 'CoffeeScript block',
              "callback": language_callback
            }
          }
        }
      );
});
