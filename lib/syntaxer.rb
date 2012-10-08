class Syntaxer
  #LANGUAGES = [:ruby, :haml, :css, :html, :php, :c, :cplusplus, :json, :javascript, :sql, :yaml, :erb, :xml]
  LANGUAGES = [:ruby, :haml, :css, :html, :json, :javascript, :sql, :yaml, :erb, :xml]
  require 'coderay'

  def self.prepare_html(text)
    text.gsub(/<code.*?>(.*?)<\/code>/) do |res|
      lang = res[/<code\s*class="(?<lang>\w*)_code"/,1]
      if LANGUAGES.include?(lang.to_s.to_sym)
        res = CGI::unescapeHTML(res.gsub(/<br.*?>/, "\r\n").gsub(/<(.*?|\/.*?)>/, "").gsub(/&nbsp;/, " "))
        "<div class='oa'><div class='lang_sign'><img src='/assets/languages/#{lang}.png' alt='#{lang}'/></div>" +
            CodeRay.scan(res, lang).div(:line_numbers => :table) + "</div>"
      end || res
    end
  end
end