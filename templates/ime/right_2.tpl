<div id="right_div" class="fr">
    <div class="right_bar" id="right_direction">
        <div class="title"><span>科研方向</span></div>
        <table id="right_direction_table">
            <tr>
                <td class="t_r"><a href="\?p=surface"><img src="{__skinpath__}images/pics/nano.gif" width="56" height="41" alt="" /></a></td>
                <td class="t_l"><a href="\?p=nano">纳米结构与器件</a></td>
            </tr>
            <tr>
                <td class="t_r"><a href="\?p=surface"><img src="{__skinpath__}images/pics/energy.gif" width="56" height="41" alt="" /></a></td>
                <td class="t_l"><a href="\?p=energy">能源材料</a></td>
            </tr>
            <tr>
                <td class="t_r"><a href="\?p=surface"><img src="{__skinpath__}images/pics/surface.gif" width="56" height="41" alt="" /></a></td>
                <td class="t_l"><a href="\?p=surface">表面工程</a></td>
            </tr>
            <tr>
                <td class="t_r"><a href="\?p=surface"><img src="{__skinpath__}images/pics/bio.gif" width="56" height="41" alt="" /></a></td>
                <td class="t_l"><a href="\?p=bio">生物质材料</a></td>
            </tr>
        </table>
    </div>
	
	<div class="right_bar" id="right_news">
        <div class="title"><span><a href="\?p=communication">学术交流</a></span></div>
        <ul class="no_cir">
            {#:__commlist__}
            <li><a href="{__commlist__.url}" title="{__commlist__.title}" target="_blank">{__commlist__.shorttitle}</a></li>
            {/#:__commlist__}
        </ul>
        <div style="width: 166px; margin-left: auto; margin-right: auto;">{__commflash__}</div>
    </div>
</div>
