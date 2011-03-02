<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="{__keyword__}" />
    <meta name="DEscription" content="{__description__}" />
    <meta name="Author" content="{__sysauthor__}" />
    <title>{__title__} - {__webtitle__}</title>
    <link rel="stylesheet" type="text/css" href="{__skinpath__}css/base.css" />
    <link rel="stylesheet" type="text/css" href="{__skinpath__}css/common.css" />
    <script type="text/javascript" src="{__root__}js/easyui/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="iepngfix_tilebg.js"></script>
<style type="text/css">
img, div, input {
    _behavior: url("iepngfix.htc");
}
</style>
</head>
<body>

<!--[if IE]>
<style>
body { padding: 0 0 0 0; margin: 0 0 0 0; }
div { padding: 0 0 0 0; margin: 0 0 0 0; }
</style>
<![endif]-->

<script type="text/javascript">
function bottom_resize(){
    $("#nav_btn_{__roottid__}").attr("src", "{__skinpath__}images/top_nav/nav_{__roottid__}_hover.jpg");

    $("#foot_bg").css("left", (document.body.clientWidth - 1000) / 2);
    $("#foot_bg").css("top", document.body.clientHeight - 378);
}

window.onresize = bottom_resize;

$(function(){
    bottom_resize();
});
</script>
<div id="foot_bg"></div>
<div class="wrap">
    <div id="top_div">
        <div id="top_logo" class="fl">
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="526" height="118">
                <param name="movie" value="{__skinpath__}images/top_logo.swf">
                <param name="quality" value="high">
                <param name="wmode" value="transparent">
                <embed wmode="transparent" src="{__skinpath__}images/top_logo.swf" width="526" height="118" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash">
            </object>
        </div>
        <div id="lan_div" class="fl">
            <ul>
                <li><a href="http://ime.nbut.cn/">中文</a></li>
                <li><a href="http://ime.nbut.cn/en">English</a></li>
            </ul>
        </div>
        <div class="cl"></div>

        <div id="top_nav" style="background: url('{__skinpath__}images/top_board/top_board_{__roottid__}.jpg')">
            <div style="height: 13px;"></div>
            <div id="nav_btns">
                <a href="{__root__}?p=intro"><img id="nav_btn_1" class="fl" src="{__skinpath__}images/top_nav/nav_1.png" width="102" height="22" alt="" /></a>
                <a href="{__root__}?p=news"><img id="nav_btn_2" class="fl" src="{__skinpath__}images/top_nav/nav_2.png" width="84" height="22" alt="" /></a>
                <a href="{__root__}?p=result"><img id="nav_btn_3" class="fl" src="{__skinpath__}images/top_nav/nav_3.png" width="91" height="22" alt="" /></a>
                <a href="{__root__}?p=subject"><img id="nav_btn_18" class="fl" src="{__skinpath__}images/top_nav/nav_18.png" width="90" height="22" alt="" /></a>
                <a href="{__root__}?p=direction"><img id="nav_btn_4" class="fl" src="{__skinpath__}images/top_nav/nav_4.png" width="87" height="22" alt="" /></a>
                <a href="{__root__}?p=graduate"><img id="nav_btn_13" class="fl" src="{__skinpath__}images/top_nav/nav_13.png" width="96" height="22" alt="" /></a>
                <a href="{__root__}?p=platform"><img id="nav_btn_17" class="fl" src="{__skinpath__}images/top_nav/nav_17.png" width="88" height="22" alt="" /></a>
                <a href="{__root__}contact.asp"><img id="nav_btn_0" class="fl" src="{__skinpath__}images/top_nav/nav_0.png" width="89" height="22" alt="" /></a>

                <div class="cl"></div>
            </div>
        </div>
    </div>
</div>

<div class="wrap">
    <div id="main_div">