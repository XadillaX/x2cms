<%
	'--------------------------
	' * 后台首页
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	'--------------------------
	' 本CMS遵循GPL协议开发
	' 使用EasyASP和EasyIDE
	' 请保留版权信息
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim PageTitle
	PageTitle = "后台首页"
	
	dim okOS, okCPUS, okCPU
	
' 获取服务器常用参数
sub getsysinfo()
  on error resume next
  Set WshShell = server.CreateObject("WScript.Shell")
  Set WshSysEnv = WshShell.Environment("SYSTEM")
  okOS = cstr(WshSysEnv("OS"))
  okCPUS = cstr(WshSysEnv("NUMBER_OF_PROCESSORS"))
  okCPU = cstr(WshSysEnv("PROCESSOR_IDENTIFIER"))
  if isempty(okCPUS) then
    okCPUS = Request.ServerVariables("NUMBER_OF_PROCESSORS")
  end if
  if okCPUS & "" = "" then
    okCPUS = "(未知)"
  end if
  if okOS & "" = "" then
    okOS = "(未知)"
  end if
end sub

function cSize(tSize)
  if tSize>=1073741824 then
    cSize=int((tSize/1073741824)*1000)/1000 & " GB"
  elseif tSize>=1048576 then
    cSize=int((tSize/1048576)*1000)/1000 & " MB"
  elseif tSize>=1024 then
    cSize=int((tSize/1024)*1000)/1000 & " KB"
  else
    cSize=tSize & "B"
  end if
end function

getsysinfo()
%>
<!--#include file="admin_common_top.asp" -->
<div class="mytable" style="border: none;">
	<table class="mytable" style="border: none;" border="0" cellspacing="0" cellpadding="0">
    	<tr>
        	<td width="50%" valign="bottom"><span style="font-size: 50px; font-family: 'Times New Roman', Times, serif; color: #900;">Welcome!</span></td>
        	<td align="right" valign="bottom"><strong>&copy;<a href="<%=sys_web%>"><%=sys_name%></a></strong>&nbsp;<%=sys_ver%> powered by <%=sys_author%> / Last update: <%=sys_pubdate%></td>
    	</tr>
	</table>
    <div class="hr"></div>
    
    <table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="25%">服务器项目 / 组件</td>
        <td width="25%">属性</td>
        <td width="25%">服务器项目 / 组件</td>
        <td width="25%">属性</td>
    </tr>
    <tr class="table_row table_row_clr_1">
        <td>软件当前版本</td>
        <td><strong>&copy;<a href="<%=sys_web%>"><%=sys_name%></a></strong>&nbsp;<%=sys_ver%></td>
        <td>当前使用数据库</td>
        <td>Microsoft Access</td>
    </tr>
    <tr class="table_row table_row_clr_1">
        <td>服务器域名 / IP</td>
        <td><%=Request.ServerVariables("SERVER_NAME")%> / <%=Request.ServerVariables("LOCAL_ADDR")%></td>
        <td>Web端口号</td>
        <td><%=Request.ServerVariables("SERVER_PORT")%></td>
    </tr>
    <tr class="table_row table_row_clr_2">
        <td>服务器操作系统</td>
        <td><%=okOS%></td>
        <td>服务器时间</td>
        <td><%=Now()%></td>
    </tr>
    <tr class="table_row table_row_clr_1">
        <td>服务器软件版本</td>
        <td><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
        <td>脚本引擎解释器</td>
        <td><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
    </tr>
    <tr class="table_row table_row_clr_2">
        <td>脚本超时设置</td>
        <td><%=Server.ScriptTimeout%>秒</td>
        <td>服务器CPU数量</td>
        <td><%=okCPUS%> 个</td>
    </tr>
    <tr class="table_row table_row_clr_1">
        <td>网站文件物理路径</td>
        <td><%=request.servervariables("appl_physical_path")%></td>
        <td>网站文件占用空间</td>
        <td>
        	<%
				dim fsoObj
				set fsoObj = server.CreateObject("Scripting.FileSystemObject")
				dim web_dir
				set web_dir = fsoObj.GetFolder(request.servervariables("appl_physical_path"))
				echo cSize(web_dir.Size)
			%>
        </td>
    </tr>
</table>

</div>
<!--#include file="admin_common_footer.asp" -->