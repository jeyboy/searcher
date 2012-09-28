class Syntaxer
  #LANGUAGES = [:ruby, :haml, :css, :html, :php, :c, :cplusplus, :json, :javascript, :sql, :yaml, :erb, :xml]
  LANGUAGES = [:ruby, :haml, :css, :html, :json, :javascript, :sql, :yaml, :erb, :xml]
  require 'coderay'

  def self.prepare_html(text)
    LANGUAGES.each do |lang|
      text.gsub!(/#{"<#{lang.to_s}>(.*?)<\/#{lang.to_s}>"}/) do |v|
        CodeRay.scan(v.gsub(/#{"<(#{lang.to_s}|\/#{lang.to_s})>"}/, ""), lang).div(:line_numbers => :table)
      end
    end
    text
  end
end