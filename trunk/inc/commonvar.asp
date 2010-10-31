<%
	'--------------------------
	' * 通用变量
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	dim i, j, k
	dim result
	dim Title, Root, Skin, VisCount
	
	Title				=	Easp.db.RT("config", "id=1", "webname")
	Root				=	Easp.db.RT("config", "id=1", "root")
	Skin				=	Easp.db.RT("config", "id=1", "skin")
	Easp.tpl.FilePath	=	WebPath & SkinPath & Skin
	
	VisCount			=	Easp.db.RT("config", "id=1", "viscount") + 1
	result = Easp.db.UR("config", "id=1", Array("viscount:" & VisCount))
	if result = 0 Then
		VisCount = VisCount - 1
	End If
%>
