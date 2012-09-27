//= require ../libraries/icontains.js

function appendOptionIfNotExist(select, text) {
    select = $(select);
    if (select.find(':icontains("' + text + '")').length == 0)
        select.append('<option value="' + text + '">' + text + '</option>');
}