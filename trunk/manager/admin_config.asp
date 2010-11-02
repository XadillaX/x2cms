<%
	'--------------------------
	' * 系统常量
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim PageTitle, config_rs
	PageTitle = "系统常量"
	
	set config_rs = Easp.db.GRD("config", "id=1")
%>
<!--#include file="admin_common_top.asp" -->
<table class="mytable" border="0" cellspacing="0" cellpadding="0">
	<tr class="table_title">
    	<td colspan="4">常量设置</td>
    </tr>
    <form action="admin_config_chk.asp" method="post">
	<tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">网站名称：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
        	<input class="ipt" type="text" name="webname" id="webname" value="<%=config_rs("webname")%>" />
            <span class="hint">*请输入网站名称</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">网站根地址：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
        	<input class="ipt" type="text" name="root" id="root" value="<%=config_rs("root")%>" />
            <span class="hint">*首页所在目录的地址，最后不用加"/"</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">选择模板方案：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
        	<select id="skin" name="skin">
            	<%
					for i = 0 to SkinCount - 1
				%>
                <option value="<%=SkinList(i)%>" <%=iif(SkinList(i) = config_rs("skin"), "selected", "")%>><%=SkinList(i)%></option>
                <%
					next
				%>
            </select>
            <span class="hint">*选择模板方案</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">计数器：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
        	<input class="ipt" type="text" name="viscount" id="viscount" value="<%=config_rs("viscount")%>" />
            <span class="hint">*修改浏览量</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">&nbsp;</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">&nbsp;
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">网站标题：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
        	<input class="ipt" type="text" name="webtitle" id="webtitle" value="<%=config_rs("webtitle")%>" />
            <span class="hint">*修改显示在浏览器标题栏的文字</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">网站关键字：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
            <textarea id="keyword" name="keyword"><%=config_rs("keyword")%></textarea>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">网站描述：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
            <textarea id="description" name="description"><%=config_rs("description")%></textarea>
        </td>
    </tr>
    <tr class="table_ipt_tr">
	    <td width="19%" style="text-align: right; font-weight: bold;">统计代码：</td>
        <td width="3%">&nbsp;</td>
	    <td width="78%">
            <textarea id="countcode" name="countcode"><%=config_rs("countcode")%></textarea>
        </td>
    </tr>
    <tr class="table_btn_tr">
    	<td colspan="4">
        	<input class="btn" type="submit" name="submit" id="submit" value="确认修改" />
            <input class="btn" type="reset" name="reset" id="reset" value="重新填写" />
        </td>
    </tr>
    </form>
</table>
<!--#include file="admin_common_footer.asp" -->