function sleep(delay) {
	var start = new Date().getTime();
	while (new Date().getTime() < start + delay);
}
function trimStr(str) {
	return str.replace(/(^\s*)|(\s*$)/g, "");
}
function export_word() {
	//点击更多
	$('#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div:nth-child(5) > i').click();
	//点击导出到word
	$('#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div.tools-item.widget-toggle-active > ul > li:nth-child(4)').click();
}

//Jqury注入
(function(d, s) {
	d.body.appendChild(s = d.createElement('script')).src = 'https://cdn.bootcss.com/jquery/3.3.1/jquery.js'
})(document);

function get_all() {
	//获取文章列表
	l = $('.abstract-mode li') for (var i = 0; i < l.length; i++) {
		l[i].click();
		export_word();
		var title = $('li.list-li.file-item.selected > div.title').text() console.log("Export-", i);
		console.log("Waitting...");
		sleep(5000);
	}
}

var outStr = "";
function get_all_2() {
	//获取文章列表
	l = $('.abstract-mode li') var i = 0;
	l[i].click();
	var t = window.setInterval(function() {
		export_word();
		var title = trimStr($('li.list-li.file-item.selected > div.title').text());
		$('#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div.tools-item.more-info').click();
		var source = trimStr($('#flexible-list-right > div.detail > note > div > div.detail-wrapper > div > div > toolbar > div > div.tools-item.more-info > div > table > tbody > tr:nth-child(2) > td.td-r > span > a').text());
		title = title.replace(/\n/g, '').replace(/\r\n/g, '');
		if (source === '') {
			outStr += (title + '\n');
		} else {
			outStr += (title + '\t' + source + '\n');
		}
		console.log("Export-", i);
		console.log("Waitting...");

		if (i < l.length - 1) {
			//if(i