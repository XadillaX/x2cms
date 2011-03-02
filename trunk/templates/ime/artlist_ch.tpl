{#include:header.tpl}
<link rel="stylesheet" type="text/css" href="{__skinpath__}css/artlist.css" />
<div id="main_board" class="fl">
    <div id="main_board_main">
        &nbsp;
        <div id="main_board_main_inside">
                <h2 class="ch_type_h2">{__title__}</h2>
                <div class="gray_hr"></div>
                <div class="artlist_content_list">
                    <ul class="artlist_ul">
                        {#:__artlist__}
                        <li><a  target="_blank" href="{__artlist__.url}" title="{__artlist__.title}">{__artlist__.shorttitle}</a>　[{__artlist__.time}]</li>
                        {/#:__artlist__}
                    </ul>
                    <div class="pager fr">{__pager__}</div>
                    <div class="cl"></div>
                </div>
        </div>
        &nbsp;
    </div>
    <div id="main_board_bottom"></div>
</div>
{#include:right_2.tpl}
{#include:footer.tpl}
