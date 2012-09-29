//= require ./jquery.markitup.js
//= require ./default_set.js

$(document).ready(function () {
    $('textarea').markItUp(mySettings).css('width', '100%');
});