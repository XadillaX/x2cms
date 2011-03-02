{#include:header.tpl}
<link rel="stylesheet" type="text/css" href="{__skinpath__}css/artlist.css" />
<div id="main_board" class="fl">
    <div id="main_board_main">
        &nbsp;
        <div id="main_board_main_inside">
            {#:__chnav__}
                <h2 class="ch_type_h2">{__chnav__.type}</h2>
                <div class="gray_hr"></div>
                <div class="artlist_content_list">
                    <ul class="artlist_ul">
                        {#:__chnavlist__}
                        <li><a target="_blank" href="{__chnavlist__.url}" title="{__chnavlist__.title}">{__chnavlist__.shorttitle}</a>　[{__chnavlist__.time}]</li>
                        {/#:__chnavlist__}
                    </ul>
                    <div class="more fr"><a href="{__chnav__.url}" title="更多...">更多...</a></div>
                    <div class="cl"></div>
                </div>
            {/#:__chnav__}
        </div>
        &nbsp;
    </div>
    <div id="main_board_bottom"></div>
</div>

{#include:right_2.tpl}
{#include:footer.tpl}
