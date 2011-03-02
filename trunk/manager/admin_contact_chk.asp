<%
    '--------------------------
    ' * 联系信息确定
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    ' 检查数据来源，若不是则警告且返回
    Easp.CheckDataFromA()

    ' 读取POST数据
    dim Pname, Pzip, Pphone, Pfax, Pemail, Pqq, Pqqname, Paddress
    dim sqlstr, sqlarr
    Pname = Easp.post("cname:s")
    Pzip = Easp.post("czip:s")
    Pphone = Easp.post("cphone:s")
    Pfax = Easp.post("cfax:s")
    Pemail = Easp.post("cemail:s")
    Pqq = Easp.post("cqq:s")
    Pqqname = Easp.post("cqqname:s")
    Paddress = Easp.post("caddress:s")
    
    sqlarr = Array("cname:" & Pname, "czip:" & Pzip, "cphone:" & Pphone, "cfax:" & Pfax, "cemail:" & Pemail, "cqq:" & Pqq, "cqqname:" & Pqqname, "caddress:" & Paddress)
    
    ' 写入数据
    if Easp.db.UR("contact", "cid=1", sqlarr) = 1 then
        ' 写入日志
        sqlstr = Easp.HtmlEncode(Easp.db.wUR("contact", "cid=1", sqlarr))
        Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "更新联系信息：SQL(" & sqlstr & ")。", "time:" & Now(), "ip:" & realip, "right:true")
        
        Easp.Alert "联系信息修改成功！"
    else
        sqlstr = Easp.HtmlEncode(Easp.db.wUR("contact", "cid=1", sqlarr))
        Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "更新联系信息：SQL(" & sqlstr & ")。", "time:" & Now(), "ip:" & realip)
        
        Easp.Alert "联系信息修改失败！"        
    end if
%>
