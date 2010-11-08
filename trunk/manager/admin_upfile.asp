<%
'==================================
'=文 件 名：Ft_upfile.asp
'=
'=功    能：上传文件（可设置上传文件大小/上传目录/非法检测字符,）
'=注意事项：请随时关注当前木马的发展，及时添加木马关键字到检测程序中；如果要关闭检测函数，请在本页参数设置处设置
'=作    者：新酷数据
'=日    期：2008-2-19 18:09
'=版    权：http://www.xksj.net
'=联系QQ：308588016 389057646
'==================================
%>
<!--#include file="admin_common.asp"-->
<!--#include file="admin_upfile_class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body { background: #eee; padding-top: 3px; font-size: 12px; }
</style>
</head>
<body topmargin="0" leftmargin="0" class="tablebody">
<%
dim upfile,upmax,updir,updir2,checkupfile,SaveFilename, chk, filebb, strArray
'==================================
'=参数设置：
'upmax为上传文件大小，此处设置为300KB，计算方法为 307200/1024=300K，注意不能过大，否则影响后面的自动检测功能；
'updir为上传目录，按月分别建立，总目录在程序根目录下的FUploadFile中；
'checkupfile为检测函数使用开关，0为关闭，1为启用
'==================================
upmax=UploadMax
updir2 = UploadPath & year(date)&"-"&month(date)&"/" 
updir="../" & updir2
checkupfile=1 '检测函数使用开关，0为关闭，1为启用
set upfile=new upfile_class
upfile.GetData (upmax)
'检查上传文件夹
set chk = Server.CreateObject("Scripting.FileSystemObject")
if chk.FolderExists(Server.MapPath(updir)) =false then
	chk.CreateFolder(Server.MapPath(updir))
end if
set chk=nothing
'执行保存文件代码
dim path,FSPath
FSPath=Easp.Fso.MapPath(updir)
path =FSPath & "\" & upfile.file("img").filename

upfile.AutoSave "img",path
select case upfile.isErr
	case 1
   		Response.Write "你没有填写上传数据&nbsp;&nbsp;[<a href='admin_upload.asp'>重新上传</a>]"
	case 2
		response.Write "文件过大，应小于"&upmax/1024&"KB&nbsp;&nbsp;[<a href='admin_upload.asp'>重新上传</a>]"
	case 3
		response.Write "该文件类型不允许上传&nbsp;&nbsp;[<a href='admin_upload.asp'>重新上传</a>]"
	case else
		if checkupfile=1 then 
		Dim objFSO,objTS,strText,ComStr
		filebb=updir&upfile.file("img").filename
		Set objFSO=Server.CreateObject("Scripting.FileSystemObject")
		If Easp.Fso.IsFile(Easp.Fso.MapPath(filebb)) Then
			Set objTS=objFSO.OpenTextFile(Server.MapPath(filebb),1)
			strText=lcase(objTS.ReadAll)
			objTS.Close
			'禁止字符，可随时添加
			ComStr="cookie|.getfolder|.createfolder|.deletefolder|.createdirectory|.deletedirectory|0n error resume next|站长助手|密码|海阳|adodb.stream|createobject|scripting.filesystemobject|strbackdoor|password|command.com"
			ComStr=ComStr&"|.saveas|wscript.shell|shell.application|script.encode|folderpath|session|request|iframe|frame|execute|object|server.mappath" 
			strArray=split(ComStr,"|")
			for i=0 to ubound(strArray)
				if instr(strText,strArray(i))<>0 then
					objFSO.DeleteFile Server.MapPath(filebb),True
					response.write"<font color=red>非法文件，禁止上传！</font>&nbsp;&nbsp;[<a href='admin_upload.asp'>重新上传</a>]"
					response.end
				end if
			next
			Set objFSO=nothing
		else
			response.write"该文件不存在"
		end if
	end if
		response.write"<script>parent.Dvbbs_Composition.document.body.innerHTML+='<img src="&updir&upfile.file("img").filename &">'</script>"
		'==================================
		'代码检测结束
		'==================================
		response.Write "<font color=green>上传成功！</font>文件路径 "&WebPath&updir2&upfile.newfilename &"&nbsp;&nbsp;[<a href='admin_upload.asp'>继续上传</a>]"
end select
set upfile=nothing
Function GetFilePath(FullPath,str)
	If FullPath <> "" Then
		GetFilePath = left(FullPath,InStrRev(FullPath, str))
	Else
		GetFilePath = ""
	End If
End function
%>
