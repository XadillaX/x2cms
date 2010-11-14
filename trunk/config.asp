<%
    '--------------------------
    ' * 主配置文件
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
    Option Explicit
%>
<%
    dim WebPath, DBFile, SkinPath, VCodeSession, SessionPre, AdminPath, AdminMaxTime, UploadPath, UploadMax, UploadExt
    dim DefaultPageSize
    
    WebPath            =    "/"                                            ' 网站绝对路径
    DBFile            =    "data/database.mdb"                            ' 数据库相对路径
    SkinPath        =    "templates/"                                ' 模板文件夹相对路径
    VCodeSession    =    "x2cms_vcode"                                ' 验证码Session
    SessionPre        =    "x2cms_xcoder_"                                ' Session前缀
    AdminPath        =    WebPath & "manager/"                        ' 管理员目录
    AdminMaxTime    =    36000                                        ' 管理员最大登录时间
    UploadPath        =    "attached/"                                    ' 上传路径
    UploadMax        =    4096000                                        ' 最大上传大小
    UploadExt        =    "doc;rar;ppt;gif;txt;jpg;png;bmp;zip;swf"    ' 上传允许后缀
    DefaultPageSize    =    10                                            ' 默认分页大小
%>
<!--#include file="inc/easp/easp.asp" -->
<!--#include file="inc/easyide.asp" -->
<%
    Easp.Use "tpl"
    Easp.Use "Fso"
    Easp.Use "List"
%>
<!--#include file="conn.asp" -->
<!--#include file="inc/func.asp" -->
<!--#include file="inc/commonvar.asp" -->
<!--#include file="inc/commontag.asp" -->
