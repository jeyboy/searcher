module CodeRay
module Styles
  
  # A colorful theme using CSS 3 colors (with alpha channel).
  class Alpha < Style

    register_for :alpha

    code_background = 'hsl(0,0%,95%)'
    numbers_background = 'hsl(180,65%,90%)'
    border_color = 'silver'
    normal_color = 'black'

    CSS_MAIN_STYLES = <<-MAIN  # :nodoc:
.CodeRay {
  background-color: #{code_background};
  border: 1px solid #{border_color};
  color: #{normal_color};
}
.CodeRay pre {
  margin: 0px;
}

span.CodeRay { white-space: pre; border: 0px; padding: 2px; }

table.CodeRay { border-collapse: collapse; width: 100%; padding: 2px; }
table.CodeRay td { padding: 2px 4px; vertical-align: top; }

.CodeRay .line-numbers {
  background-color: #{numbers_background};
  color: gray;
  text-align: right;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
}
.CodeRay .line-numbers a {
  background-color: #{numbers_background} !important;
  color: gray !important;
  text-decoration: none !important;
}
.CodeRay .line-numbers a:target { color: blue !important; }
.CodeRay .line-numbers .highlighted { color: red !important; }
.CodeRay .line-numbers .highlighted a { color: red !important; }
.CodeRay span.line-numbers { padding: 0px 4px; }
.CodeRay .line { display: block; float: left; width: 100%; }
.CodeRay .code { width: 100%; }
    MAIN

    TOKEN_COLORS = <<-'TOKENS'
.debug { color: white !important; background: blue !important; }

 .annotation { color:#007 }
 .attribute-name { color:#f08 }
 .attribute-value { color:#700 }
 .binary { color:#509; font-weight:bold }
 .comment  { color:#998; font-style: italic;}
 .char { color:#04D }
 .char .content { color:#04D }
 .char .delimiter { color:#039 }
 .class { color:#458; font-weight:bold }
 .complex { color:#A08; font-weight:bold }
 .constant { color:teal; }
 .color { color:#0A0 }
 .class-variable { color:#369 }
 .decorator { color:#B0B; }
 .definition { color:#099; font-weight:bold }
 .directive { color:#088; font-weight:bold }
 .delimiter { color:black }
 .doc { color:#970 }
 .doctype { color:#34b }
 .doc-string { color:#D42; font-weight:bold }
 .escape  { color:#666; font-weight:bold }
 .entity { color:#800; font-weight:bold }
 .error { color:#F00; background-color:#FAA }
 .exception { color:#C00; font-weight:bold }
 .filename { color:#099; }
 .function { color:#900; font-weight:bold }
 .global-variable { color:teal; font-weight:bold }
 .hex { color:#058; font-weight:bold }
 .integer  { color:#099; }
 .include { color:#B44; font-weight:bold }
 .inline { color: black }
 .inline .inline { background: #ccc }
 .inline .inline .inline { background: #bbb }
 .inline .inline-delimiter { color: #D14; }
 .inline-delimiter { color: #D14; }
 .important { color:#f00; }
 .interpreted { color:#B2B; font-weight:bold }
 .instance-variable { color:teal }
 .label { color:#970; font-weight:bold }
 .local-variable { color:#963 }
 .octal { color:#40E; font-weight:bold }
 .operator { }
 .predefined-constant {  font-weight:bold }
 .predefined { color:#369; font-weight:bold }
 .preprocessor { color:#579; }
 .pseudo-class { color:#00C; font-weight:bold }
 .predefined-type { color:#074; font-weight:bold }
 .reserved, .keyword  { color:#000; font-weight:bold }

 .key { color: #808; }
 .key .delimiter { color: #606; }
 .key .char { color: #80f; }
 .value { color: #088; }

 .regexp { background-color:#fff0ff }
 .regexp .content { color:#808 }
 .regexp .delimiter { color:#404 }
 .regexp .modifier { color:#C2C }
 .regexp .function  { color:#404; font-weight: bold }

 .string { color: #D20; }
 .string .string { }
 .string .string .string { background-color:#ffd0d0 }
 .string .content { color: #D14; }
 .string .char { color: #D14; }
 .string .delimiter { color: #D14; }

 .shell { color:#D14 }
 .shell .content { }
 .shell .delimiter { color:#D14 }

 .symbol { color:#990073 }
 .symbol .content { color:#A60 }
 .symbol .delimiter { color:#630 }

 .tag { color:#070 }
 .tag-special { color:#D70; font-weight:bold }
 .type { color:#339; font-weight:bold }
 .variable  { color:#036 }

 .insert { background: #afa; }
 .delete { background: #faa; }
 .change { color: #aaf; background: #007; }
 .head { color: #f8f; background: #505 }

 .insert .insert { color: #080; font-weight:bold }
 .delete .delete { color: #800; font-weight:bold }
 .change .change { color: #66f; }
 .head .head { color: #f4f; }
    TOKENS

  end

end
end
