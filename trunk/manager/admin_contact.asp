<%
    '--------------------------
    ' * 后台联系管理
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    dim PageTitle, contact_rs
    PageTitle = "联系信息"
    
    set contact_rs = Easp.db.GRD("contact", "cid=1")
%>
<!--#include file="admin_common_top.asp" -->
<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td colspan="4">联系信息</td>
    </tr>
    <form action="admin_contact_chk.asp" method="post">
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">公司名称：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="cname" id="cname" value="<%=contact_rs("cname")%>" />
            <span class="hint">*请输入公司名称</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">公司地址：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="caddress" id="caddress" value="<%=contact_rs("caddress")%>" />
            <span class="hint">*公司所在的地址</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">公司邮编：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="czip" id="czip" value="<%=contact_rs("czip")%>" />
            <span class="hint">*公司所在地址的邮编</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">公司电话：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="cphone" id="cphone" value="<%=contact_rs("cphone")%>" />
            <span class="hint">*公司电话</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">公司传真：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="cfax" id="cfax" value="<%=contact_rs("cfax")%>" />
            <span class="hint">*公司传真</span>
        </td>
    </tr>
    
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">&nbsp;</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">&nbsp;
            
        </td>
    </tr>    
    
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">客服邮箱：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="cemail" id="cemail" value="<%=contact_rs("cemail")%>" />
            <span class="hint">*修改客服的邮箱</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">客服ＱＱ：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="cqq" id="cqq" value="<%=contact_rs("cqq")%>" />
            <span class="hint">*修改客服的QQ号码</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">ＱＱ昵称：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="cqqname" id="cqqname" value="<%=contact_rs("cqqname")%>" />
            <span class="hint">*修改客服的QQ昵称</span>
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
