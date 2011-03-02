<div id="right_div" class="fr">
    <div class="right_bar" id="right_result">
        <div class="title"><span>科研成果</span></div>
        <ul class="big_ul"  id="kycg_ul">
            <li><a href="?p=papers">论文</a></li>
            <li><a href="?p=awards">科技奖励</a></li>
            <li><a href="?p=patents">专利</a></li>
            <li><a href="?p=application">工业应用</a></li>
        </ul>
    </div>

    <div class="right_bar" id="right_news">
        <div class="title"><span>学术交流</span></div>
        <ul class="no_cir">
            {#:__commlist__}
            <li><a href="{__commlist__.url}" title="{__commlist__.title}" target="_blank">{__commlist__.shorttitle}</a></li>
            {/#:__commlist__}
        </ul>
        <div style="width: 166px; margin-left: auto; margin-right: auto;">{__commflash__}</div>
    </div>
</div>
