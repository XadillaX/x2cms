{#include:header.tpl}
<!-- Main -->
<div style="margin-left: auto; margin-right: auto; text-align: center;">
<a href="{__root__}">首页</a> » {__mapstr__}
</div>
<div style="margin-left: auto; margin-right: auto; text-align: center;">
        {#:__chnav__}<a href="{__chnav__.url}">{__chnav__.type}</a> {/#:__chnav__}
</div>
<div id="main">
	<div class="shell">
		{__pagecode__}
	</div>
</div>
<!-- End Main -->
{#include:footer.tpl}
