class Syntaxer
  #LANGUAGES = [:ruby, :haml, :css, :html, :php, :c, :cplusplus, :json, :javascript, :sql, :yaml, :erb, :xml]
  LANGUAGES = [:ruby, :haml, :css, :html, :json, :javascript, :sql, :yaml, :erb, :xml]
  require 'coderay'

  def self.prepare_html(text)
    text.gsub(/<code.*?>(.*?)<\/code>/mix) do |res|
      lang = res[/<code\s*class="(?<lang>\w*)"/,1].split("_code").first

      <<-MAIN
        <div class='oa'>
          <div class='lang_sign fl'>
            <img src='/assets/languages/#{lang}.png' alt='#{lang}'/>
          </div>
          #{(if LANGUAGES.include?(lang.to_s.to_sym)
            res = res.gsub(/<br.*?>/, "\r\n").gsub(/<(.*?|\/.*?)>/, "").gsub(/&nbsp;/, " ")
            res = CGI::unescapeHTML(res)
            CodeRay.scan(res, lang).div(:line_numbers => :table)
          end || "<pre class='fl'>#{res}</pre>")}
        </div>
        <div class='cb'/>
      MAIN

    end
  end
end