//example
//  if (select.find(':icontains("' + text + '")').length == 0)
//    select.append('<option value="' + text + '">' + text + '</option>');

$.expr[':'].icontains = function(obj, index, meta, stack){
    return (obj.textContent || obj.innerText || jQuery(obj).text() || '').toLowerCase().indexOf(meta[3].toLowerCase()) >= 0;
};