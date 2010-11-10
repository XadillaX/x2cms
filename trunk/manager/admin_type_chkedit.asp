<%
    '--------------------------
    ' * 栏目修改
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    dim action, ptid, ptype, ptypeurl, pfather, pcount, ppage, ppagecode, ptpl, pord, tmp_rs, f_rs
    dim code, ncode, flag, sqlstr
    action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "错误的指向连接。")
    
    select case action
        case "add"                                        ' 增加栏目
            ' 验证输入合法性
            ptype = Easp.CheckForm(Easp.Post("type:s"), "", 1, "请输入栏目名称")
            ptpl = Easp.CheckForm(Easp.Post("tpl:s"), "", 0, "请正确模板！")
            ptypeurl = Easp.CheckForm(Easp.Post("typeurl:s"), "english", 1, "URL的GET值只允许是英文！")
            pfather = Easp.CheckForm(Easp.Post("father:n"), "number", 1, "父路径不正确！")
            ppage = Easp.Post("page:s")
            pord = Easp.CheckForm(Easp.Post("ord:n:0"), "number", 1, "错误的排序！")
            
            if not Easp.fso.IsFile(WebPath & SkinPath & nowskin & ptpl) and ptpl <> "" then Easp.Alert "此模板不存在！" & ptpl

            result = Easp.db.RT("type", Array("typeurl:" & ptypeurl), "typeurl")
            if result <> "" then
                Easp.Alert "已存在的URL-GET值！"
            end if
            
            tmp_rs = Easp.db.GRD("type", Array("tid:" & pfather))
            if not Easp.Has(tmp_rs) then
                Easp.Alert "不存在的父路径！"
            end if
            
            ' 写入数据库
            result = Easp.db.AR("type", Array("tpl:" &ptpl, "type:" & ptype, "typeurl:" & ptypeurl, "page:" & iif(ppage = "page", true, false), "ord:" & pord, "father:" & pfather))
            if result = 0 then 
                code = "数据库错误！"
                ncode = "添加栏目：数据库错误。"
                flag = false
            else
                code = "栏目添加成功！"
                ncode = "添加栏目 " & ptype & " ：成功。"
                flag = true
            end if
            
            SetLog Username, ncode, flag
            Easp.AlertUrl code, "admin_type.asp?seed=" & now()
            
        case "edit_art_type"                            ' 修改栏目
            ' 验证输入合法性
            ptid = Easp.CheckForm(Easp.Post("tid:n"), "", 1, "非法提交！")
            ptype = Easp.CheckForm(Easp.Post("type:s"), "", 1, "非法提交！")
            pfather = Easp.CheckForm(Easp.Post("father:n"), "", 1, "非法提交！")
            ptypeurl = Easp.CheckForm(Easp.Post("typeurl:s"), "", 1, "非法提交！")
            pord = Easp.CheckForm(Easp.Post("ord:n"), "", 1, "非法提交！")
            pcount = Easp.CheckForm(Easp.Post("count:n"), "", 1, "非法提交！")
            ppagecode = Easp.CheckForm(Easp.Post("pagecode:s"), "", 0, "非法提交！")
            ptpl = Easp.CheckForm(Easp.Post("tpl:s"), "", 0, "请正确模板！")
            
            if not Easp.fso.IsFile(WebPath & SkinPath & nowskin & ptpl) and ptpl <> "" then Easp.Alert "此模板不存在！" & WebPath & SkinPath & ptpl
            
            ' 验证自递归目录
            if ptid = pfather then Easp.Alert "不能成为自己的子目录！"
            
            ' 验证父递归目录
            if cstr(pfather) <> cstr(-1) then
                f_rs = Easp.db.RT("type", "tid=" & pfather, "father")
                while f_rs <> -1
                    if cstr(f_rs) = cstr(ptid) then Easp.Alert "不能成为子目录的子目录！"
                    
                    f_rs = Easp.db.RT("type", "tid=" & f_rs, "father")
                wend
            end if
            
            result = Easp.db.RT("type", Array("typeurl:" & ptypeurl), "tid")
            if result <> "" and cstr(result) <> cstr(ptid) then
                Easp.Alert "已存在的URL-GET值！"
            end if
            
            tmp_rs = Easp.db.GRD("type", Array("tid:" & pfather))
            if not Easp.Has(tmp_rs) then
                Easp.Alert "不存在的父路径！"
            end if
            
            ' 开始修改，修改父路径文章数
            f_rs = pfather
            while cstr(f_rs) <> cstr(-1)
                sqlstr = "update [type] set [count] = [count] - " & pcount & " where tid=" & f_rs
                Easp.db.Exec sqlstr
                ' echo sqlstr & endl
                
                f_rs = Easp.db.RT("type", "tid=" & f_rs, "father")
            wend
            
            ' 修改此栏目
            Easp.db.UR "type", "tid=" & ptid, Array("tpl:" & ptpl, "pagecode:" & ppagecode, "type:" & ptype, "father:" & pfather, "typeurl:" & ptypeurl, "ord:" & pord)
            SetLog Username, "修改栏目""" & ptype & """成功！", true
            Easp.AlertUrl "修改栏目""" & ptype & """成功！", "admin_type.asp?seed=" & now()
            
        case "del"                                        ' 删除栏目
            ' 验证输入合法性
            ptid = Easp.CheckForm(Easp.Post("tid:n"), "", 1, "非法提交！")
            
            result = Easp.db.DR("type", "tid=" & ptid & " or father=" & ptid)
            if result = 0 then
                code = "数据库错误！"
                ncode = "删除栏目：数据库错误。"
                flag = false
            else
                code = "栏目删除成功！"
                ncode = "删除栏目：TID" & ptid & "成功。"
                flag = true
            end if
            
            SetLog Username, ncode, flag
            Easp.Alert code
            
        case else
            Easp.Alert "错误的指令！"
    end select
%>