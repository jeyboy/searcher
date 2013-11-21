# encoding: utf-8

class Syntaxer
  #LANGUAGES = [:ruby, :haml, :css, :html, :php, :c, :cplusplus, :json, :javascript, :sql, :yaml, :erb, :xml]
  LANGUAGES = [:ruby, :haml, :css, :html, :json, :javascript, :sql, :yaml, :erb, :xml, :sass, :python, :delphi, :clojure, :c, :cpp]
  require 'coderay'

  def self.prepare_html(text, line_numbers = true)
    #text.gsub!(/<pre>|<\/pre>/, '')
    text.gsub(/<pre.*?><code.*?>(.*?)<\/code><\/pre>/mix) do |res|
      lang = res[/<code\s*class="(?<lang>\w*)"/,1].to_s.split('_code').first

      <<-MAIN
        <div class='oa clearfix'>
          #{
            if lang
              "<div class='lang_sign'>
                <img src='/assets/languages/#{lang}.png' alt='#{lang}'/>
              </div>"
            end
          }
          #{
            if LANGUAGES.include?(lang.to_s.to_sym)
            #  res = res.gsub(/<br.*?>/, "\r\n")
              res = res.gsub(/<(br.*?|\/[^>]+?)>/, "\r\n")
              res = res.gsub(/<.*?>/, '')

              res = res.lines.to_a.delete_if { |e| e.empty? || e == "\r\n" }
              res[res.length - 1] = res.last.gsub("\r\n", '')

              #res = res.gsub(/<(.*?|\/.*?)>/, '')
              res = spec_chars_convert(res.join)

            #  res = spec_chars_convert(fix_struct(res).gsub(/<(.*?|\/.*?)>/, ''))
              #res = res.gsub(/<br.*?>/, "\r\n")#.gsub(/<(.*?|\/.*?)>/, '').gsub(/&nbsp;/, ' ')

              ret = CodeRay.scan(res, lang)
              (ret.div(line_numbers: :table) if line_numbers) || ret.div(line_numbers: false)
            end || res
          }
        </div>
      MAIN
    end
  end

  def self.spec_chars_convert(text, extra = false)
    res = text.gsub('&quot;', '"')
    res = res.gsub('&apos;', "'")
    res = res.gsub('&lt;', '<')
    res = res.gsub('&gt;', '>')
    res = res.gsub('&nbsp;', ' ')
    res = res.gsub('&amp;', '&')

    (extra_spec_chars_convert(res) if extra) || res
  end

  def self.extra_spec_chars_convert(text)
    text
    .gsub('&iexcl;', '¡')
    .gsub('&cent;', '¢')
    .gsub('&pound;', '£')
    .gsub('&curren;', '¤')
    .gsub('&yen;', '¥')
    .gsub('&brvbar;', '¦')
    .gsub('&sect;', '§')
    .gsub('&uml;', '¨')
    .gsub('&copy;', '©')
    .gsub('&ordf;', 'ª')
    .gsub('&laquo;', '«')
    .gsub('&not;', '¬')
    .gsub('&shy;', '­')
    .gsub('&reg;', '®')
    .gsub('&macr;', '¯')
    .gsub('&deg;', '°')
    .gsub('&plusmn;', '±')
    .gsub('&sup1;', '¹')
    .gsub('&sup2;', '²')
    .gsub('&sup3;', '³')
    .gsub('&acute;', '´')
    .gsub('&micro;', 'µ')
    .gsub('&para;', '¶')
    .gsub('&middot;', '·')
    .gsub('&cedil;', '¸')
    .gsub('&ordm;', 'º')
    .gsub('&raquo;', '»')
    .gsub('&frac14;', '¼')
    .gsub('&frac12;', '½')
    .gsub('&frac34;', '¾')
    .gsub('&iquest;', '¿')
    .gsub('&times;', '×')
    .gsub('&divide;', '÷')
  end
end