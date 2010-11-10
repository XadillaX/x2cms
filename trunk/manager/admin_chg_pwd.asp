<%
    '--------------------------
    ' * 修改密码
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    dim PageTitle
    PageTitle = "修改密码"
    
    if Easp.Get("action:s") = "ChgOK" then
        dim prepwd, pwd, repwd, rs
        
        ' 验证是否为空
        prepwd = Easp.CheckForm(Easp.Post("prepwd:s"), "", 1, "请输入原密码。")
        pwd = Easp.CheckForm(Easp.Post("pwd:s"), "", 1, "请输入新密码。")
        repwd = Easp.CheckForm(Easp.Post("repwd:s"), "", 1, "请确认原密码。")
        
        ' 验证密码正确性
        if pwd <> repwd then Easp.Alert "两次新密码输入不正确！"
        if str_len(pwd) < 5 or str_len(pwd) > 16 then
            Easp.Alert "新密码必须在5到16个长度之间！"
        end if
        
        ' 加密密码
        prepwd = LCase(md5(prepwd))
        pwd = LCase(md5(pwd))
        
        ' 查找数据库
        set rs = Easp.db.GRD("admin", Array("password:" & prepwd, "username:" & Username))
        
        ' 写入日志
        if Easp.Has(rs) then
            result = Easp.db.UR("admin", "aid=" & aid, Array("password:" & pwd))
            if result = 1 then
                SetLog Username, "修改密码成功。", true
            else
                SetLog Username, "修改密码失败：数据库错误。", false
            end if
            
            Easp.Alert iif(result = 1, "修改成功！", "修改失败！")
        else
            SetLog Username, "修改密码失败：原密码输入错误。", false
            Easp.Alert "原密码输入错误！"
        end if
    else
%>
<!--#include file="admin_common_top.asp" -->
<form action="admin_chg_pwd.asp?action=ChgOK" method="post">
<table class="mytable" width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr class="table_title">
    <td colspan="3"><span class="hint"><%=session(SessionPre & "admin_username")%></span> 密码修改</td>
  </tr>
  <tr class="table_ipt_tr">
    <td width="19%" class="t_r">原密码：</td>
    <td width="3%">&nbsp;</td>
    <td width="78%"><input class="ipt" type="password" name="prepwd" id="prepwd" value="" /></td>
  </tr>
  <tr class="table_ipt_tr">
    <td width="19%" class="t_r">新密码：</td>
    <td width="3%">&nbsp;</td>
    <td width="78%"><input class="ipt" type="password" name="pwd" id="pwd" value="" /></td>
  </tr>
  <tr class="table_ipt_tr">
    <td width="19%" class="t_r">确定：</td>
    <td width="3%">&nbsp;</td>
    <td width="78%"><input class="ipt" type="password" name="repwd" id="repwd" value="" /></td>
  </tr>
  <tr class="table_btn_tr">
    <td colspan="4">
        <input class="btn" type="submit" name="submit" id="submit" value="确认修改" />
        <input class="btn" type="reset" name="reset" id="reset" value="重新填写" /></td>
  </tr>
</table>
</form>
<!--#include file="admin_common_footer.asp" -->
<%
    end if
%>