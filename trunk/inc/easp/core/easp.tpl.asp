<%
'######################################################################
'## easp.tpl.asp
'## -------------------------------------------------------------------
'## Feature     :   EasyAsp Templates Class
'## Version     :   v2.2 Alpha
'## Author      :   Coldstone(coldstone[at]qq.com)
'## Update Date :   2010/10/20 23:57:57
'## Description :   Use Templates with EasyAsp
'##
'######################################################################
Class EasyAsp_Tpl
	Private s_html, s_ohtml, s_unknown, s_dict, s_path, s_m, s_ms, s_me
	Private o_tag, o_blockdata, o_block, o_blocktag, o_blocks, o_attr
	Private b_asp

	Private Sub class_Initialize
		s_path = ""
		s_unknown = "keep"
		s_dict = "Scripting.Dictionary"
		Set o_tag = Server.CreateObject(s_dict) : o_tag.CompareMode = 1
		Set o_blockdata = Server.CreateObject(s_dict) : o_blockdata.CompareMode = 1
		Set o_block = Server.CreateObject(s_dict) : o_block.CompareMode = 1
		Set o_blocktag = Server.CreateObject(s_dict) : o_blocktag.CompareMode = 1
		Set o_blocks = Server.CreateObject(s_dict) : o_blocks.CompareMode = 1
		Set o_attr = Server.CreateObject(s_dict) : o_attr.CompareMode = 1
		s_m = "{*}"
		getMaskSE s_m
		b_asp = False
		s_html = ""
		s_ohtml = ""
	End Sub
	Private Sub Class_Terminate
		Set o_tag = Nothing
		Set o_blockdata = Nothing
		Set o_block = Nothing
		Set o_blockTag = Nothing
		Set o_blocks = Nothing
		Set o_attr = Nothing
	End Sub
	Public Property Get FilePath
		FilePath = s_path
	End Property
	Public Property Let FilePath(ByVal f)
		If Right(f,1)<>"/" Then f = f & "/"
		s_path = f
	End Property
	Public Property Let [File](ByVal f)
		Load(f)
	End Property
	Public Property Let [Source](ByVal s)
		LoadStr(s)
	End Property
	Public Property Get TagMask
		TagMask = s_m
	End Property
	Public Property Let TagMask(ByVal m)
		s_m = m
		getMaskSE s_m
	End Property
	Public Property Let Tag(ByVal s, ByVal v)
		Assign s, v
	End Property
	Public Property Get Tag(ByVal s)
		If o_tag.Exists(s) Then
			Tag = o_tag.Item(s)
		Else
			Tag = ""
		End If
	End Property
	Public Property Get AspEnable
		AspEnable = b_asp
	End Property
	Public Property Let AspEnable(ByVal b)
		b_asp = b
	End Property
	Public Property Get TagUnknown
		TagUnknown = s_unknown
	End Property
	Public Property Let TagUnknown(ByVal s)
		Select Case LCase(s)
			Case "1", "remove"
				s_unknown = "remove"
			Case "2", "comment"
				s_unknown = "comment"
			Case Else
				s_unknown = "keep"
		End Select
	End Property
	Public Function [New]()
		Set [New] = New EasyAsp_Tpl
	End Function
	Public Function Attr(ByVal s)
		If Not o_attr.Exists(s) Then Exit Function
		Attr = o_attr.Item(s)
	End Function
	Public Sub Load(ByVal f)
		s_html = LoadInc(s_path & f,"")
		s_ohtml = s_html
		SetBlocks()
	End Sub
	Public Sub LoadStr(ByVal s)
		s_html = s
		s_ohtml = s
		SetBlocks()
	End Sub
	Public Sub Reload()
		o_tag.RemoveAll
		o_blockdata.RemoveAll
		o_block.RemoveAll
		o_blockTag.RemoveAll
		o_blocks.RemoveAll
		o_attr.RemoveAll
		s_html = s_ohtml
		SetBlocks()
	End Sub
	Public Sub TagFile(ByVal tag, ByVal f)
		LoadToTag tag,0,f
	End Sub
	Public Sub TagStr(ByVal tag, ByVal s)
		LoadToTag tag,1,s
	End Sub
	Private Sub LoadToTag(ByVal tag, ByVal t, ByVal f)
		dim s
		If t = 0 Then
			s = LoadInc(s_path & f,"")
		Else
			s = f
		End If
		If Easp.Has(tag) Then
			s_html = Easp.regReplace(s_html, s_ms & tag & s_me, s)
		Else
			s_html = s_html & s
		End If
		SetBlocks()
	End Sub
	Public Default Sub Assign(ByVal s, ByVal v)
		dim i,f
		Select Case TypeName(v)
			Case "Recordset"
				If Easp.Has(v) Then
					For i = 0 To v.Fields.Count - 1
						Assign s & "." & v.Fields(i).Name, v.Fields(i).Value
						Assign s & "." & i, v.Fields(i).Value
					Next
				End If
			Case "EasyAsp_List"
				If v.Size > 0 Then
					For i = 0 To v.End
						Assign s & "." & i, v(i)
						Assign s & "." & v.IndexHash(i), v(i)
					Next
				End If
			Case Else
				If Easp.IsN(v) Then v = ""
				If o_tag.Exists(s) Then o_tag.Remove s
				o_tag.Add s, Cstr(v)
		End Select
	End Sub
	Public Sub Append(ByVal s, ByVal v)
		If Easp.IsN(v) Then v = ""
		dim tmp
		If o_tag.Exists(s) Then
			tmp = o_tag.Item(s) & Cstr(v)
			o_tag.Remove s
			o_tag.Add s, Cstr(tmp)
		Else
			o_tag.Add s, Cstr(v)
		End If
	End Sub
	Public Sub [Update](ByVal b)
		dim Matches, Match, tmp, s, rule, data
		s = BlockData(b)
		rule = Chr(0) & "(\w+?)" & Chr(0)
		Set Matches = Easp.regMatch(s, rule)
		Set Match = Matches
		For Each Match In Matches
			data = Match.SubMatches(0)
			If o_blocktag.Exists(data) Then
				s = Replace(s, Match.Value, o_blocktag.Item(data))
				o_blocktag.Remove(data)
			End If
		Next
		If o_blocktag.Exists(b) Then
			tmp = o_blocktag.Item(b) & s
			o_blocktag.Remove b
			o_blocktag.Add b, Cstr(tmp)
		Else
			o_blocktag.Add b, Cstr(s)
		End If
		Set Matches = Easp.regMatch(s_html, Chr(0) & b & Chr(0))
		Set Match = Matches
		For Each Match In Matches
			s = BlockTag(b)
			s_html = Replace(s_html, Match.Value, s & Match.Value)
		Next
		If o_block.Exists(b) Then o_block.Remove b
	End Sub
	Private Function LogicReplace(ByVal s)
		dim Matches, Match, result, condi, conds, cond, n, yes, no, x, e, f, cname, ckey, copera, cvalue
		Set Matches = Easp.RegMatch(s, s_ms & "#if\s+(.+?)"&s_me&"([\s\S]+?)(?:"&s_ms&"#else"&s_me&"([\s\S]+?))?"&s_ms&"/#if"&s_me)
		For Each Match In Matches
			condi = Match.SubMatches(0)
			yes = Match.SubMatches(1)
			no = Match.SubMatches(2)
			Set conds = Easp.RegMatch(condi,"(?:([^&)(\s}|}=<>!]+)([=<>!]{1,2})(['""])(.+?)\3)|(?:([^&()\s|}=<>!]+)([=<>!]{1,2})([^&)\s|}]+))")
			For Each cond In conds
				cname = cond.Value
				Set e = Easp.RegMatch(cname,"@([\w\.]+)")
				For Each f In e
					n = f.SubMatches(0)
					cname = Replace(cname, f.Value, Easp.IIF(o_tag.Exists(n),o_tag.Item(n),""))
				Next
				Set e = Nothing
				Set x = Easp.RegMatch(cname,"^([^=<>!]*)([=<>!]{1,2})(['""]?)(.*)\3$")
				ckey = x(0).SubMatches(0)
				copera = x(0).SubMatches(1)
				cvalue = x(0).SubMatches(3)
				condi = Replace(condi, cond.Value, Comp(ckey,copera,cvalue))
				condi = Replace(condi, "&&", " And ")
				condi = Replace(condi, "||", " Or ")
				Set x = Nothing
			Next
			s = Replace(s, Match.Value, Easp.IIF(Eval(condi), yes, no))
			Set conds = Nothing
		Next
		Set Matches = Nothing
		LogicReplace = s
	End Function
	Private Function Comp(ByVal k, ByVal o, ByVal v)
		On Error Resume Next
		dim tmp,m,ma,mb : tmp = False
		Select Case o
			Case "=","=="
				m = Replace(k,"\%","")
				If Instr(m,"%")>0 Then
					ma = Easp.CLeft(m,"%")
					mb = Easp.CRight(m,"%")
					tmp = (CLng(ma) Mod CLng(mb) = v)
				Else
					tmp = (CStr(k) = CStr(v))
				End If
			Case "<>","!=" tmp = (CStr(k) <> CStr(v))
			Case ">=" tmp = (CDbl(k) >= CDbl(v))
			Case "<=" tmp = (CDbl(k) <= CDbl(v))
			Case ">" tmp = (CDbl(k) > CDbl(v))
			Case "<" tmp = (CDbl(k) < CDbl(v))
		End Select
		Comp = Easp.IIF(Err.Number=0,tmp,False)
	End Function
	Public Function GetHtml()
		s_html = LogicReplace(s_html)
		dim Matches, Match, n, b
		Set Matches = Easp.RegMatch(s_html, s_ms & "(.+?)" & s_me)
		For Each Match In Matches
			n = Match.SubMatches(0)
			If o_tag.Exists(n) Then
				s_html = Replace(s_html, Match.Value, o_tag.Item(n))
			End If
		Next
		Set Matches = Easp.regMatch(s_html, Chr(0) & "(\w+?)" & Chr(0))
		For Each Match In Matches
			b = Match.SubMatches(0)
			Select Case s_unknown
				Case "keep"
					If o_block.Exists(b) Then [Update](b)
				Case "remove"
					'Do Nothing
				Case "comment"
					s_html = Replace(s_html, Match.Value, "<!-- Unknown Block '"&b&"' -->")
			End Select
			s_html = Replace(s_html, Match.Value, "")
		Next
		Set Matches = Easp.RegMatch(s_html, s_ms & "(.+?)" & s_me)
		select case s_unknown
			case "keep"
				'Do Nothing
			case "remove"
				For Each Match In Matches
					s_html = Replace(s_html, Match.Value, "")
				Next
			case "comment"
				For Each Match In Matches
					s_html = Replace(s_html, Match.Value, "<!-- Unknown Tag '" & Match.Submatches(0) & "' -->")
				Next
		End select
		Set Matches = Nothing
		GetHtml = s_html
	End Function
	Public Sub Show()
		Easp.W GetHtml
	End Sub
	Public Sub SaveAs(ByVal p)
		Easp.Use "Fso"
		Call Easp.Fso.CreateFile(p,GetHtml)
	End Sub
	Public Function MakeTag(ByVal t, ByVal f)
		dim s,e,a,i,m
		If Instr(t,":")>0 Then
			m = Easp.CRight(t,":")
			t = Easp.CLeft(t,":")
			m = Easp.DateTime(Now,m)
		End If
		Select Case Lcase(t)
			Case "css"
				s = "<link href="""
				e = """ rel=""stylesheet"" type=""text/css"" />"
			Case "js"
				s = "<scr"&"ipt type=""text/javascript"" src="""
				e = """></scr"&"ipt>"
			Case "author", "keywords", "description", "copyright", "generator", "revised", "others"
				MakeTag = MakeTagMeta("name",t,f)
				Exit Function
			Case "content-type", "expires", "refresh", "set-cookie"
				MakeTag = MakeTagMeta("http-equiv",t,f)
				Exit Function
		End Select
		a = Split(f,"|")
		For i = 0 To Ubound(a)
			a(i) = s & Trim(a(i)) & Easp.IfThen(Easp.Has(m),"?" & m) & e
		Next
		MakeTag = Join(a,vbCrLf)
	End Function
	Private Function MakeTagMeta(ByVal m, ByVal t, ByVal s)
		MakeTagMeta = "<meta " & m & "=""" & t & """ content=""" & s & """ />"
	End Function
	Private Sub getMaskSE(ByVal m)
		s_ms = Easp.RegEncode(Easp.CLeft(m,"*"))
		s_me = Easp.RegEncode(Easp.CRight(m,"*"))
	End Sub
	Private Function LoadInc(ByVal f, ByVal p)
		dim h,pa,rule,inc,Match,incFile,incStr
		pa = Easp.IIF(Left(f,1)="/","",p)
		If b_asp Then
			h = Easp.GetInclude( pa & f )
		Else
			h = Easp.Read( pa & f )
		End If
		rule = "(<!--[\s]*)?" & s_ms & "#include:(.+?)" & s_me & "([\s]*-->)?"
		If Easp.Test(h,rule) Then
			If Easp.isN(p) Then
				If Instr(f,"/")>0 Then p = Left(f,InstrRev(f,"/"))
			Else
				If Instr(f,"/")>0 Then p = pa & Left(f,InstrRev(f,"/"))
			End If
			Set inc = Easp.regMatch(h,rule)
			For Each Match In inc
				incFile = Match.SubMatches(1)
				incStr = LoadInc(incFile, p)
				h = Replace(h,Match,incStr)
			Next
			Set inc = Nothing
		End If
		LoadInc = h
	End Function
	Private Sub SetBlocks()
		dim Matches, Match, rule, n, i, j
		i = 0
		rule = "(<!--[\s]*)?" & s_ms & "#:(.+?)" & s_me
		If Not Easp.Test(s_html, rule) Then Exit Sub
		Set Matches = Easp.regMatch(s_html,rule)
		For Each Match In Matches
			n = Match.SubMatches(1)
			If o_blocks.Exists(i) Then o_blocks.Remove i
			o_blocks.Add i, n
			i = i + 1
		Next
		For j = i-1 To 0 Step -1
			Begin o_blocks.item(j)
		Next
	End Sub
	Private Sub Begin(ByVal b)
		dim Matches, Match, rule, data, attrs, attr, att, aname, avalue, atag
		rule = "(<!--[\s]*)?(" & s_ms & ")#:(" & b & ")(" & s_me & ")([\s]*-->)?([\s\S]+?)(<!--[\s]*)?\2/#:\3\4([\s]*-->)?"
		If Instr(b," ")>0 Then
			attrs = Easp.CRight(b, " ")
			b = Easp.CLeft(b, " ")
		  rule = "(<!--[\s]*)?(" & s_ms & ")#:(" & b & " " & Easp.RegEncode(attrs) & ")(" & s_me & ")([\s]*-->)?([\s\S]+?)(<!--[\s]*)?\2/#:" & b & "\4([\s]*-->)?"
		End If
		Set Matches = Easp.regMatch(s_html, rule)
		Set Match = Matches
		For Each Match In Matches
			data = Match.SubMatches(5)
			If o_blockdata.Exists(b) Then
				o_blockdata.Remove(b)
				o_block.Remove(b)
			End If
			o_blockdata.Add b, Cstr(data)
			o_block.Add b, Cstr(b)
			If Easp.Has(attrs) Then
				Set attr = Easp.RegMatch(attrs,"((\w+)=(['""])(.+?)\3)|((\w+)=([^\s]+))")
				For Each att In attr
					aname = Easp.CLeft(att.Value, "=")
					avalue = Easp.RegReplace(att.Value, "\w+=(['""]?)(.+?)\1", "$2")
					atag = b & "." & aname
					If o_attr.Exists(atag) Then o_attr.Remove(atag)
					o_attr.Add atag, avalue
				Next
			End If
			s_html = Easp.regReplace(s_html, rule, Chr(0) & b & Chr(0))
		Next
	End Sub
	Private Function BlockData(ByVal b)
		dim tmp, s
		If o_blockdata.Exists(b) Then
			tmp = o_blockdata.Item(b)
			s = UpdateBlockTag(tmp)
			BlockData = s
		Else
			BlockData = "<!--" & Chr(0) & b & Chr(0) & "-->"
		End If
	End Function
	Private Function BlockTag(ByVal b)
		dim tmp, s
		If o_blockdata.Exists(b) Then
			tmp = o_blocktag.Item(b)
			s = UpdateBlockTag(tmp)
			BlockTag = s
			o_blocktag.Remove(b)
		Else
			BlockTag = "<!--" & Chr(0) & b & Chr(0) & "-->"
		End If
	End Function
	Private Function UpdateBlockTag(ByVal s)
		s = LogicReplace(s)
		dim Matches, Match, data, rule
		Set Matches = Easp.RegMatch(s, s_ms & "(.+?)" & s_me)
		For Each Match In Matches
			data = Match.SubMatches(0)
			If o_tag.Exists(data) Then
				rule = Match.Value
				If Easp.isN(o_tag.Item(data)) Then
					s = Replace(s, rule, "")
				Else
					s = Replace(s, rule, o_tag.Item(data))
				End If
			End If
		Next
		UpdateBlockTag = s
	End Function
End Class
%>