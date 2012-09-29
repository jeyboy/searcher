class Syntaxer
  #LANGUAGES = [:ruby, :haml, :css, :html, :php, :c, :cplusplus, :json, :javascript, :sql, :yaml, :erb, :xml]
  LANGUAGES = [:ruby, :haml, :css, :html, :json, :javascript, :sql, :yaml, :erb, :xml]
  require 'coderay'

  def self.prepare_html(text)
    LANGUAGES.each do |lang|
      req_lang = ":#{lang}"
      text.gsub!(/#{"<#{req_lang}>(.*?)<\/#{req_lang}>"}/mix) do |v|
        v = v.gsub(/#{"<(#{req_lang}|\/#{req_lang})>"}/, "").gsub(/<br[^>]*\/>/, "\r\n")
        CodeRay.scan(v, lang).div(:line_numbers => :table)
      end
    end
    text
  end
end