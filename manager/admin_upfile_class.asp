<%
'==================================
'=文 件 名：upfile_class.asp
'=
'=功    能：定义文件上传类（可设置上传文件类型，默认设置只能上传图片）
'=作    者：新酷数据
'=日    期：2008-2-19 18:09
'=版    权：http://www.xksj.net
'=联系QQ：308588016 389057646
'==================================
'----------------------------------------------------------------------
'转发时请保留此声明信息,这段声明不并会影响你的速度!
'*******************     无惧上传类 V2.0    ************************************
'作者:梁无惧
'网站:http://www.25cn.com
'电子邮件:yjlrb@21cn.com
'版权声明:版权所有,源代码公开,各种用途均可免费使用,但是修改后必须把修改后的文件
'发送一份给作者.并且保留作者此版权信息
'**********************************************************************
'----------------------------------------------------------------------
'----------------------------------------------------------------------
'文件上传类
Class UpFile_Class

Dim Form,File, newfilename
Dim AllowExt_    '允许上传类型(白名单)
Dim NoAllowExt_    '不允许上传类型(黑名单)
Private    oUpFileStream    '上传的数据流
Private isErr_        '错误的代码,0或true表示无错
Private ErrMessage_    '错误的字符串信息
Private isGetData_    '指示是否已执行过GETDATA过程

    '添加的代码，删除包含非法代码的文件
Public Function alertAndRemoveFile(Byval PathAndFileName)
        on error resume next
        dim MyFileObject,MyTextFile,NeedDel,StrCheckFile
        alertAndRemoveFile=false
        Set MyFileObject=Server.CreateObject("Scripting.FileSystemObject")
        Set MyTextFile=MyFileObject.OpenTextFile(PathAndFileName)
        DO
            If MytextFile.AtEndOfStream Then Exit Do
            StrCheckFile=MytextFile.ReadLine
            if includeBadWord(StrCheckFile) Then'调用判断函数
                alertAndRemoveFile=true
                NeedDel=true
                Exit Do
            End If
        Loop
        MYTextFile.Close
        If NeedDel Then MyFileObject.DeleteFile PathAndFileName
        set MYTextFile=nothing
        set MyFileObject=nothing
    End Function
        '检查文本是否有有害代码
    Private Function includeBadWord(Byval FileStr)
        includeBadWord=false
        dim StrBadWord,ArrStrBadWord,i
        StrBadWord="server.|.createobject|execute|.encode|eval|request"'定义恶意代码
        ArrStrBadWord=split(StrBadWord,"|")
        For i=0 to ubound(ArrStrBadWord)
            if Instr(LCase(FileStr),ArrStrBadWord(i))>0 Then
                'response.write(ArrStrBadWord(i))
                includeBadWord=true
                Exit For
            End If
        Next
    End Function

'------------------------------------------------------------------
'类的属性
Public Property Get Version
    Version="无惧上传类 Version V2.0"
End Property

Public Property Get isErr        '错误的代码,0或true表示无错
    isErr=isErr_
End Property

Public Property Get ErrMessage        '错误的字符串信息
    ErrMessage=ErrMessage_
End Property

Public Property Get AllowExt        '允许上传类型(白名单)
    AllowExt=AllowExt_
End Property

Public Property Let AllowExt(Value)    '允许上传类型(白名单)
    AllowExt_=LCase(Value)
End Property

Public Property Get NoAllowExt        '不允许上传类型(黑名单)
    NoAllowExt=NoAllowExt_
End Property

Public Property Let NoAllowExt(Value)    '不允许上传类型(黑名单)
    NoAllowExt_=LCase(Value)
End Property

'----------------------------------------------------------------
'类实现代码

'初始化类
Private Sub Class_Initialize
    isErr_ = 0
    NoAllowExt=""        '黑名单,可以在这里预设不可上传的文件类型,以文件的后缀名来判断,不分大小写,每个每缀名用;号分开,如果黑名单为空,则判断白名单
    NoAllowExt=LCase(NoAllowExt)
    AllowExt=UploadExt         '白名单,可以在这里预设可上传的文件类型,以文件的后缀名来判断,不分大小写,每个后缀名用;号分开
    AllowExt=LCase(AllowExt)
    isGetData_=false
End Sub

'类结束
Private Sub Class_Terminate    
    on error Resume Next
    '清除变量及对像
    Form.RemoveAll
    Set Form = Nothing
    File.RemoveAll
    Set File = Nothing
    oUpFileStream.Close
    Set oUpFileStream = Nothing
End Sub
'分析上传的数据
Public Sub GetData (MaxSize)
     '定义变量
    on error Resume Next
    if isGetData_=false then 
        Dim RequestBinDate,sSpace,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo
        Dim sFormValue,sFileName
        Dim iFindStart,iFindEnd
        Dim iFormStart,iFormEnd,sFormName
        '代码开始
        If Request.TotalBytes < 1 Then    '如果没有数据上传
            isErr_ = 1
            ErrMessage_="没有数据上传"
            Exit Sub
        End If
        If MaxSize > 0 Then '如果限制大小
            If Request.TotalBytes > MaxSize Then
            isErr_ = 2    '如果上传的数据超出限制大小
            ErrMessage_="上传的数据超出限制大小"
            Exit Sub
            End If
        End If
        Set Form = Server.CreateObject ("Scripting.Dictionary")
        Form.CompareMode = 1
        Set File = Server.CreateObject ("Scripting.Dictionary")
        File.CompareMode = 1
        Set tStream = Server.CreateObject ("ADODB.Stream")
        Set oUpFileStream = Server.CreateObject ("ADODB.Stream")
        oUpFileStream.Type = 1
        oUpFileStream.Mode = 3
        oUpFileStream.Open 
        oUpFileStream.Write Request.BinaryRead (Request.TotalBytes)
        oUpFileStream.Position = 0
        RequestBinDate = oUpFileStream.Read 
        iFormEnd = oUpFileStream.Size
        bCrLf = ChrB (13) & ChrB (10)
        '取得每个项目之间的分隔符
        sSpace = MidB (RequestBinDate,1, InStrB (1,RequestBinDate,bCrLf)-1)
        iStart = LenB(sSpace)
        iFormStart = iStart+2
        '分解项目
        Do
            iInfoEnd = InStrB (iFormStart,RequestBinDate,bCrLf & bCrLf)+3
            tStream.Type = 1
            tStream.Mode = 3
            tStream.Open
            oUpFileStream.Position = iFormStart
            oUpFileStream.CopyTo tStream,iInfoEnd-iFormStart
            tStream.Position = 0
            tStream.Type = 2
            tStream.CharSet = "utf-8"
            sInfo = tStream.ReadText            
            '取得表单项目名称
            iFormStart = InStrB (iInfoEnd,RequestBinDate,sSpace)-1
            iFindStart = InStr (22,sInfo,"name=""",1)+6
            iFindEnd = InStr (iFindStart,sInfo,"""",1)
            sFormName = Mid    (sinfo,iFindStart,iFindEnd-iFindStart)
            '如果是文件
            If InStr (45,sInfo,"filename=""",1) > 0 Then
                Set oFileInfo = new FileInfo_Class
                '取得文件属性
                iFindStart = InStr (iFindEnd,sInfo,"filename=""",1)+10
                iFindEnd = InStr (iFindStart,sInfo,""""&vbCrLf,1)
                sFileName = Mid    (sinfo,iFindStart,iFindEnd-iFindStart)
                oFileInfo.FileName = GetFileName(sFileName)
                oFileInfo.FilePath = GetFilePath(sFileName)
                oFileInfo.FileExt = GetFileExt(sFileName)
                iFindStart = InStr (iFindEnd,sInfo,"Content-Type: ",1)+14
                iFindEnd = InStr (iFindStart,sInfo,vbCr)
                oFileInfo.FileMIME = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
                oFileInfo.FileStart = iInfoEnd
                oFileInfo.FileSize = iFormStart -iInfoEnd -2
                oFileInfo.FormName = sFormName
                file.add sFormName,oFileInfo
            else
            '如果是表单项目
                tStream.Close
                tStream.Type = 1
                tStream.Mode = 3
                tStream.Open
                oUpFileStream.Position = iInfoEnd 
                oUpFileStream.CopyTo tStream,iFormStart-iInfoEnd-2
                tStream.Position = 0
                tStream.Type = 2
                tStream.CharSet = "utf-8"
                sFormValue = tStream.ReadText
                If Form.Exists (sFormName) Then
                    Form (sFormName) = Form (sFormName) & ", " & sFormValue
                    else
                    Form.Add sFormName,sFormValue
                End If
            End If
            tStream.Close
            iFormStart = iFormStart+iStart+2
            '如果到文件尾了就退出
        Loop Until (iFormStart+2) >= iFormEnd 
        RequestBinDate = ""
        Set tStream = Nothing
        isGetData_=true
    end if
End Sub

'保存到文件,自动覆盖已存在的同名文件
Public Function SaveToFile(Item,Path)
    SaveToFile=SaveToFileEx(Item,Path,True)
End Function

'保存到文件,自动设置文件名
Public Function AutoSave(Item,Path)
    AutoSave=SaveToFileEx(Item,Path,false)
End Function

'保存到文件,OVER为真时,自动覆盖已存在的同名文件,否则自动把文件改名保存
Private Function SaveToFileEx(Item,Path,Over)
    ' echo Path
    On Error Resume Next
    Dim oFileStream
    Dim tmpPath
    isErr=0
    Set oFileStream = CreateObject ("ADODB.Stream")
    oFileStream.Type = 1
    oFileStream.Mode = 3
    oFileStream.Open
    oUpFileStream.Position = File(Item).FileStart
    oUpFileStream.CopyTo oFileStream,File(Item).FileSize
    tmpPath=Path
    if Over then
        if isAllowExt(GetFileExt(tmpPath)) then
            oFileStream.SaveToFile tmpPath,2
        Else
            isErr_=3
            ErrMessage_="该后缀名的文件不允许上传!"
        End if
    Else
        dim my_path
        my_path = GetFilePath(Path)
        newfilename = File(item).filename
        if isAllowExt(File(Item).FileExt) then
            while Easp.Fso.IsFile(tmpPath)
                newfilename = GetNewFileName() & "."&File(Item).FileExt
                tmpPath = my_path&newfilename
            wend
            oFileStream.SaveToFile tmpPath,2
            ' echo tmpPath
        Else
            isErr_=3
            ErrMessage_="该后缀名的文件不允许上传!"
        End if
    End if
    oFileStream.Close
    Set oFileStream = Nothing
    if isErr_=3 then SaveToFileEx="" else SaveToFileEx=GetFileName(tmpPath)
    ' echo SaveToFileEx
End Function

'取得文件数据
Public Function FileData(Item)
    isErr_=0
    if isAllowExt(File(Item).FileExt) then
        oUpFileStream.Position = File(Item).FileStart
        FileData = oUpFileStream.Read (File(Item).FileSize)
        Else
        isErr_=3
        ErrMessage_="该后缀名的文件不允许上传!"
        FileData=""
    End if
End Function


'取得文件路径
Public function GetFilePath(FullPath)
  If FullPath <> "" Then
    GetFilePath = Left(FullPath,InStrRev(FullPath, "\"))
    Else
    GetFilePath = ""
  End If
End function

'取得文件名
Public Function GetFileName(FullPath)
  If FullPath <> "" Then
    GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
    Else
    GetFileName = ""
  End If
End function

'取得文件的后缀名
Public Function GetFileExt(FullPath)
  If FullPath <> "" Then
    GetFileExt = LCase(Mid(FullPath,InStrRev(FullPath, ".")+1))
    Else
    GetFileExt = ""
  End If
End function

'取得一个不重复的序号
Public Function GetNewFileName()
    dim ranNum
    dim dtNow
    dtNow=Now()
    ranNum=int(90000*rnd)+10000
    '以下这段由webboy提供
    GetNewFileName=year(dtNow) & right("0" & month(dtNow),2) & right("0" & day(dtNow),2) & right("0" & hour(dtNow),2) & right("0" & minute(dtNow),2) & right("0" & second(dtNow),2) & ranNum
End Function

Public Function isAllowExt(Ext)
    if NoAllowExt="" then
        isAllowExt=cbool(InStr(1,";"&AllowExt&";",LCase(";"&Ext&";")))
        else
        isAllowExt=not CBool(InStr(1,";"&NoAllowExt&";",LCase(";"&Ext&";")))
    end if
End Function
End Class
'----------------------------------------------------------------------------------------------------
'文件属性类
Class FileInfo_Class
Dim FormName,FileName,FilePath,FileSize,FileMIME,FileStart,FileExt
End Class

%>
