{#include:header.tpl}
<link rel="stylesheet" type="text/css" href="{__skinpath__}css/artlist.css" />
<div id="main_board" class="fl">
    <div id="main_board_main">
        &nbsp;
        <div id="main_board_main_inside">
                <h2 class="ch_type_h2_content" style="margin-bottom: 3px;">{__title__}</h2>
                <span class="hint">分类：<a href="\?p={__typeurl__}">{__typetitle__}</a>　时间：{__publictime__}　浏览量：{__hit__}　来源：{__source__}　发布者：{__author__}</span>
                <div class="gray_hr" style="margin-bottom: 10px;"></div>
                <div class="artlist_content_list">
                    <!---->
                    {__content__}
                    <!---->
                </div>
                <div class="gray_hr" style="margin-top: 10px;"></div>
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 50%; text-align: left;"><< {__pre__.text}</td>
                        <td style="width: 50%; text-align: right;">{__next__.text} >></td>
                    </tr>
                </table>
        </div>
        &nbsp;
    </div>
    <div id="main_board_bottom"></div>
</div>

{#include:right_2.tpl}
{#include:footer.tpl}
