function sleep(a){for(var b=(new Date).getTime();(new Date).getTime()<b+a;);}function trimstr(a){return="" a.replace(="" (^\s*)|(\s*$)="" g,"")}function="" export_word(){$("#flexible-list-right=""> div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div:nth-child(5) > i").click(),$("#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div.tools-item.widget-toggle-active > ul > li:nth-child(4)").click()}function get_all(){l=$(".abstract-mode li");for(var a=0;a<l.length;a++)l[a].click(),export_word(),$("li.list-li.file-item.selected> div.title").text(),console.log("Export-",a),console.log("Waitting..."),sleep(5e3)}function get_all_2(){var a,b;l=$(".abstract-mode li"),a=0,l[a].click(),b=window.setInterval(function(){var c,d;export_word(),c=trimStr($("li.list-li.file-item.selected > div.title").text()),$("#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div.tools-item.more-info").click(),d=trimStr($("#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div.tools-item.more-info > div > table > tbody > tr:nth-child(2) > td.td-r > span > a").text()),c=c.replace(/\n/g,"").replace(/\r\n/g,""),outStr+=""===d?c+"\n":c+"	"+d+"\n",console.log("Export-",a),console.log("Waitting..."),a</l.length;a++)l[a].click(),export_word(),$("li.list-li.file-item.selected></b+a;);}function>