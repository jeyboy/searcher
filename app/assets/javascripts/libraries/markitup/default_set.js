// ----------------------------------------------------------------------------
// markItUp!
// ----------------------------------------------------------------------------
// Copyright (C) 2011 Jay Salvat
// http://markitup.jaysalvat.com/
// ----------------------------------------------------------------------------
// Html tags
// http://en.wikipedia.org/wiki/html
// ----------------------------------------------------------------------------
// Basic set. Feel free to add more tags
// ----------------------------------------------------------------------------
var mySettings = {
	onShiftEnter:  	{keepDefault:false, replaceWith:'<br />\n'},
	onCtrlEnter:  	{keepDefault:false, openWith:'\n<p>', closeWith:'</p>'},
	onTab:    		{keepDefault:false, replaceWith:'    '},
    previewTemplatePath:    '/assets/libraries/markitup/templates/preview.html',
    previewAutoRefresh: true,
    previewParser: function(content) {
        return $.ajax({
            type: 'POST',
            url: '/posts/preprocess',
            data: {'content': content},
            async: false
        }).responseText;
    },
    markupSet:  [
        {name:'Paragraph', key:'P', openWith:'<p>', closeWith:'</p>' },
        {name:'Div', key:'D', openWith:'<div>', closeWith:'</div>' },
        {name:'Title h1', openWith:'<h1>', closeWith:'</h1>' },
        {name:'Title h2', openWith:'<h2>', closeWith:'</h2>' },
        {name:'Title h3', openWith:'<h3>', closeWith:'</h3>' },
        {name:'Title h4', openWith:'<h4>', closeWith:'</h4>' },
        {name:'Title h5', openWith:'<h5>', closeWith:'</h5>' },
        {name:'Title h6', openWith:'<h6>', closeWith:'</h6>' },
        {separator:'---------------' },
		{name:'Bold', key:'B', openWith:'(!(<strong>|!|<b>)!)', closeWith:'(!(</strong>|!|</b>)!)' },
		{name:'Italic', key:'I', openWith:'(!(<em>|!|<i>)!)', closeWith:'(!(</em>|!|</i>)!)'  },
		{name:'Stroke through', key:'S', openWith:'<del>', closeWith:'</del>' },
		{separator:'---------------' },
		{name:'Bulleted List', openWith:'    <li>', closeWith:'</li>', multiline:true, openBlockWith:'<ul>\n', closeBlockWith:'\n</ul>'},
		{name:'Numeric List', openWith:'    <li>', closeWith:'</li>', multiline:true, openBlockWith:'<ol>\n', closeBlockWith:'\n</ol>'},
		{separator:'---------------' },
		{name:'Picture', key:'M', replaceWith:'<img src="[![Source:!:http://]!]" alt="[![Alternative text]!]" />' },
		{name:'Link', key:'L', openWith:'<a href="[![Link:!:http://]!]"(!( title="[![Title]!]")!)>', closeWith:'</a>', placeHolder:'Your text to link...' },
        {separator:'---------------' },
        {separator:'---------------' },
        {name:'ruby', openWith:'<:ruby>', closeWith:'</:ruby>' },
        {name:'haml', openWith:'<:haml>', closeWith:'</:haml>' },
        {name:'erb', openWith:'<:erb>', closeWith:'</:erb>' },
        {name:'yaml', openWith:'<:yaml>', closeWith:'</:yaml>' },
        {separator:'---------------' },
        {name:'html', openWith:'<:html>', closeWith:'</:html>' },
        {name:'css', openWith:'<:css>', closeWith:'</:css>' },
        {name:'javascript', openWith:'<:javascript>', closeWith:'</:javascript>' },
        {name:'sql', openWith:'<:sql>', closeWith:'</:sql>' },
        {separator:'---------------' },
        {name:'json', openWith:'<:json>', closeWith:'</:json>' },
        {name:'xml', openWith:'<:xml>', closeWith:'</:xml>' },
		{separator:'---------------' },
        {separator:'---------------' },
		{name:'Clean', className:'clean', replaceWith:function(markitup) { return markitup.selection.replace(/<(.*?)>/g, "") } },		
		{name:'Preview', className:'preview',  call:'preview'}

	]
}
