<%
    '--------------------------
    ' * 后台文章编辑
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    dim PageTitle, content_rs, action, root_rs
    dim tid, title, content, src, tm, hit, url, titlecolor, picurl, author, istj, isflash, ispic, cid

    action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "非法操作！")
    set root_rs = Easp.db.GR("type", "father=-1", "ord asc")
    
    ' 判断动作Action
    if action = "add" then
        tid = Easp.Get("tid:n")
        ' echo tid
    elseif action = "edit" then
        cid = Easp.CheckForm(Easp.Get("cid:n"), "", 1, "非法操作！")
        set content_rs = Easp.db.GRD("content", "cid=" & cid)
        if not Easp.Has(content_rs) then 
            Easp.Alert "没有此文章信息！"
        end if
        tid = content_rs("tid")
        title = content_rs("title")
        content = content_rs("content")
        src = content_rs("source")
        url = content_rs("url")
        titlecolor = content_rs("titlecolor")
        picurl = content_rs("picurl")
        istj = content_rs("istj")
        isflash = content_rs("isflash")
        ispic = content_rs("ispic")
    end if
    
    PageTitle = iif(action = "add", "内容添加", "内容编辑")
%>
<!--#include file="admin_common_top.asp" -->

<!-- KindEditor Js code -->
<script type="text/javascript">
KE.show({
    id : 'content',
    cssPath : '../js/kindeditor/skins/default.css',
    afterCreate : function(id) {
        KE.event.ctrl(document, 13, function() {
            KE.util.setData(id);
            document.forms['submit_form'].submit();
        });

        KE.event.ctrl(KE.g[id].iframeDoc, 13, function() {
            KE.util.setData(id);
            document.forms['submit_form'].submit();
        });
    },
    resizeMode : 1,
    allowPreviewEmoticons : false,
    allowUpload : false,
    skinType: "default"
});
</script>
<!-- KindEditor Js code -->

<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <form action="admin_content_content_chkedit.asp?action=<%=action%>" method="post">
    <tr class="table_title">
        <td colspan="3">
            <%=iif(action="add", "添加文章", "修改文章")%>
            <%
                if action = "edit" then
            %>
            <input type="hidden" name="cid" value="<%=cid%>" />
            <%
                end if
            %>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">文章标题：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="title" id="title" value="<%=iif(action = "edit", title, "")%>" />
            <!--<input type="hidden" name="titlecolor" value="#ff0000" />-->
            <span class="hint">*请输入文章标题</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">文章栏目：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <select name="tid">
                <%    
                    dim select_rst
                    select_rst = ""
                    for i = 1 to root_rs.PageSize
                        if root_rs.Eof then exit for
                        select_rst = select_rst & AdminType_GetThisType_Select(root_rs, 1, tid)
                        root_rs.MoveNext()
                        
                        if not root_rs.EOF then
                            select_rst = str_replace("(" & 1 & "__pendding__)", select_rst, "┇")
                        else
                            select_rst = str_replace("(" & 1 & "__pendding__)", select_rst, "┇")
                        end if
                    next
                    
                    echo select_rst
                %>
            </select>
            
            <span class="hint">*请选择栏目</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">属性：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input name="istj" type="checkbox" id="istj" <%=iif(istj, "checked=""checked""", "")%> /><label for="istj">推荐</label>
            <input name="isflash" type="checkbox" id="isflash" <%=iif(isflash, "checked=""checked""", "")%> /><label for="istj">幻灯</label>
            <input name="ispic" type="checkbox" id="ispic" <%=iif(ispic, "checked=""checked""", "")%> /><label for="istj">图片</label>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">文章出处：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="source" id="source" value="<%=iif(action="edit", src, "本站")%>" />
            <span class="hint">*请输入文章出处</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">连接地址：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="url" id="url" value="<%=iif(action="edit", url, "")%>" />
            <span class="hint">*若此文章不需要外链，请留空</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">文件上传：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <iframe src="admin_upload.asp" scrolling="no" frameborder="0" height="25" width="100%"></iframe>
            <span class="hint">*上传</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">详细内容：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <textarea style="height: 400px; width: 100%;" name="content" id="content"><%=iif(action="edit", content, "")%></textarea>
            <span class="hint">*文章的详细内容</span>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td width="19%" style="text-align: right; font-weight: bold;">图片URL：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%">
            <input class="ipt" type="text" name="picurl" id="picurl" value="<%=iif(action="edit", picurl, "")%>" />
            <span class="hint">*若此文章不是图片文章，请留空</span>
        </td>
    </tr>
    <tr class="table_btn_tr">
        <td colspan="4">
            <input class="btn" type="submit" name="submit" id="submit" value="发布" />
            <input class="btn" type="reset" name="reset" id="reset" value="重新填写" />
        </td>
    </tr>
    </form>
</table>
<!--#include file="admin_common_footer.asp" -->