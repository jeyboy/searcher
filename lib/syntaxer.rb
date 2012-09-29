class Syntaxer
  #LANGUAGES = [:ruby, :haml, :css, :html, :php, :c, :cplusplus, :json, :javascript, :sql, :yaml, :erb, :xml]
  LANGUAGES = [:ruby, :haml, :css, :html, :json, :javascript, :sql, :yaml, :erb, :xml]
  require 'coderay'

  def self.prepare_html(text)
    LANGUAGES.each do |lang|
      text.gsub!(/#{"<#{lang.to_s}>(.*?)<\/#{lang.to_s}>"}/mix) do |v|
        v = v.gsub(/#{"<(#{lang.to_s}|\/#{lang.to_s})>"}/, "").gsub(/<br[^>]*\/>/, "\r\n")
        CodeRay.scan(v, lang).div(:line_numbers => :table)
      end
    end
    text
  end
end