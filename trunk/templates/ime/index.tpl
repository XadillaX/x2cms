<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="{__keyword__}" />
    <meta name="DEscription" content="{__description__}" />
    <meta name="Author" content="{__sysauthor__}" />
    <title>{__title__} - {__webtitle__}</title>
    <link rel="stylesheet" type="text/css" href="{__skinpath__}css/base.css" />
    <link rel="stylesheet" type="text/css" href="{__skinpath__}css/index.css" />
    <script type="text/javascript" src="{__root__}js/easyui/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="iepngfix_tilebg.js"></script>
<style type="text/css">
img, div, input {
    _behavior: url("iepngfix.htc");
}
</style>
</head>
<body>
    <div id="main_wraper">
        <div id="text_div"><img src="{__skinpath__}images/index_top_text.png" alt="" width="564" height="153" border="0" usemap="#Map" />
            <map name="Map" id="Map">
                <area title="{__webtitle__}" shape="rect" coords="122,101,580,193" href="{__root__}" />
            </map>
        </div>

        <!--Body Start-->
        <div id="body_div">
            <div id="lan_div" class="fl">
                <ul>
                    <li><a href="http://ime.nbut.cn/">中文</a></li>
                    <li><a href="http://ime.nbut.cn/en">English</a></li>
                </ul>
            </div>
            <div id="frame_div" class="fl">
                <span class="black_18">研究所简介</span>
                <div id="frame_text_div">
                    <div id="frame_1" tp="0">
                        　　材料工程研究所以材料学省级重点学科为依托，整合机械工程学院和化学工程学院相关学科科研团队的力量，2009年1月成立的独立设置研究所，属学校正处级内设机构。研究所是宁波工程学院首个以开展科研工作为主的专门机构，主要承担学科建设和科学研究任务，具体从事材料科学与工程技术方面的研究，并履行服务教学、服务地方的使命，努力为宁波经济发展作出贡献。<br />
                        <p>　　我校的材料学研究可追溯至90年代初成立的"材料工艺研究所"，1996年承担"宁波市刀模具工程技术研究中心"建设任务，成为我市首批重点实验室。目前研究所下辖宁波市刀模具工程技术研究中心和宁波工程学院生物质绿色转化重点实验室，并将适时组建能源材料研究中心等，以满足学院科技创新和宁波经济发展的需要。<br /></p>
                        <p>　　研究所现有正教授级岗人员6人，具有博士学位人员8人；并积极与重点院校合作，联合培养博士研究生5人。2005年以来，先后完成国家863、973、省重大、省市基金及攻关等项目10多项，获得省级科学技术奖4项，市级科技进步奖6项，发表SCI论文29篇，分别有一人次荣获市教育服务经济贡献奖、青年科技奖及突出贡献专家等荣誉。<br /></p>
                        <p>　　"知行合一，科学发展"。宁波工程学院材料工程研究所热忱欢迎社会各界积极参与我所的建设，共同为繁荣科学，振兴经济，为创建高水平工程技术大学添砖加瓦。<br /></p>
                        <p>　　忠心感谢领导、专家教授、广大企业家的支持帮助和厚爱！<br /></p>
                    </div>
                </div>
            </div>
            <div id="btns_div" class="fl">
                <a href="{__root__}?p=intro"><img src="{__skinpath__}images/index_btns/btns_03.jpg" width="108" height="28" alt="研究所概况" /></a><br />
                <a href="{__root__}?p=news"><img src="{__skinpath__}images/index_btns/btns_05.jpg" width="108" height="28" alt="新闻动态" /></a><br />
                <a href="{__root__}?p=result"><img src="{__skinpath__}images/index_btns/btns_06.jpg" width="108" height="28" alt="科研成果" /></a><br />
                <a href="{__root__}?p=direction"><img src="{__skinpath__}images/index_btns/btns_07.jpg" width="108" height="28" alt="科研方向" /></a><br />
                <a href="{__root__}?p=subject"><img src="{__skinpath__}images/index_btns/btns_08.jpg" width="108" height="27" alt="学科建设" /></a><br />
                <a href="{__root__}?p=graduate"><img src="{__skinpath__}images/index_btns/btns_09.jpg" width="108" height="28" alt="研究生教育" /></a><br />
                <a href="{__root__}?p=platform"><img src="{__skinpath__}images/index_btns/btns_10.jpg" width="108" height="28" alt="公共平台" /></a><br />
                <a href="{__root__}contact.asp"><img src="{__skinpath__}images/index_btns/btns_11.jpg" width="108" height="28" alt="联系我们" /></a><br />
            </div>
            <div class="cl"></div>
            <div id="cnt_div" class="fr">累计访问：{__viscount__}</div>
            <div class="cl"></div>
        </div>
        <!--Body End-->

        <div id="foot_div">
            <div class="fl" id="copyright_l"><br /><br />{__copyright__}</div>
            <div class="fl" id="copyright_r">
                <br />
                {__address__}<br />
                邮编: {__zip__}　Tel.{__phone__}<br />
                Website: <a href="{__root__}">{__root__}</a><br />
            </div>
            <div class="cl"></div>
        </div>
    </div>
<script type="text/javascript">
var med = false;
    function Marquee()
    {
        if(med)
        {
            var mg_top = $("#frame_1").attr("tp");
            mg_top--;
            if(mg_top < -504) 
            {
                mg_top = 147;
            }
            $("#frame_1").attr("tp", mg_top);
        
            $("#frame_1").css("margin-top", mg_top + "px");
            setTimeout("Marquee()", 100);
        }
        else
        {
            $("#frame_1").css("margin-top", "0px");
            $("#frame_1").attr("tp", "0");
        }
    }

$("#frame_1").hover(
    function(){
        med = true;
        setTimeout("Marquee()", 100);
    },

    function(){
        med = false;
    }
);

function resize(){
    var l = (document.body.clientWidth <= 670) ? 0 : ((document.body.clientWidth - 670) / 2);
   
    $("#E, #S").css("left", (l - 110) + "px");
    $("#E").css("top", "362px");
    $("#S").css("top", "458px");
    $("#B, #N").css("left", (l + 276) + "px");
    $("#B").css("top", "490px");
    $("#N").css("top", "574px");

    $("#E, #S").hover(
        function(){
            $(this).attr("src", "{__skinpath__}images/cc_l.png");
        },

        function(){
            $(this).attr("src", "{__skinpath__}images/cc_l_2.png");
        }
    );

    $("#B, #N").hover(
        function(){
            $(this).attr("src", "{__skinpath__}images/cc_r.png");
        },

        function(){
            $(this).attr("src", "{__skinpath__}images/cc_r_2.png");
        }
    );
}

window.onresize = resize;

$(function(){
    resize();
});
</script>
<!--[if IE]>
<script type="text/javascript">
$(function(){
    var l = (document.body.clientWidth <= 670) ? 0 : ((document.body.clientWidth - 670) / 2);
    $("#E, #S").css("left", (l - 111) + "px");
    $("#E").css("top", "362px");
    $("#S").css("top", "458px");
    $("#B, #N").css("left", (l + 275) + "px");
    $("#B").css("top", "490px");
    $("#N").css("top", "574px");
});
</script>
<![endif]-->
    <a href="{__root__}?p=energy"><img class="circle" id="E" src="{__skinpath__}images/cc_l_2.png" width="45" height="46" alt="" /></a>
    <a href="{__root__}?p=surface"><img class="circle" id="S" src="{__skinpath__}images/cc_l_2.png" width="45" height="46" alt="" /></a>
    <a href="{__root__}?p=bio"><img class="circle" id="B" src="{__skinpath__}images/cc_r_2.png" width="45" height="46" alt="" /></a>
    <a href="{__root__}?p=nano"><img class="circle" id="N" src="{__skinpath__}images/cc_r_2.png" width="45" height="46" alt="" /></a>
</body>
</html>