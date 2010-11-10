<%
    '--------------------------
    ' * 栏目列表
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    dim rs, PageTitle
    PageTitle = "栏目列表"    
    
    ' 获取数据
    set rs = Easp.db.GR("type", "father=-1", "ord asc")
%>
<!--#include file="admin_common_top.asp" -->

<script type="text/javascript">
/* Initialze */
$(function(){
    $("#loading_hint").css("left", (document.body.clientWidth - 200) / 2);
    
    $("#del_type").dialog();
    $("#del_type").dialog('close');
    $("#edit_type").dialog();
    $("#edit_type").dialog("close");
    
    KE.show({
        id : 'ipt_edit_pagecode_page',
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
    });
    
    $("#edit_type_page").dialog();
    $("#edit_type_page").dialog("close");
});

/* Edit Dialog function */
function type_edit(tid)
{
    $("#loading_hint").show("normal");
    
    var json_obj;
    $.get(
        "admin_json.asp?action=type_get_info&tid=" + tid + "&seed=" + Math.random(),
        function(data){
            json_obj = eval("(" + data + ")");
            var row = json_obj.type[0];
            
            $("#ipt_edit_tid").val(row.tid);
            $("#ipt_edit_tpl").val(row.tpl);
            $("#ipt_edit_count").val(row.count);
            $("#ipt_edit_type").val(row.type);
            $("#ipt_edit_typeurl").val(row.typeurl);
            $("#ipt_edit_ord").val(row.ord);
            $("#edit_type .sel_" + row.father).attr("selected", "selected");
            
            /* Open dialog */
            $("#edit_type").dialog({
                title: '编辑栏目 - ' + row.type,
                buttons:[{
                    text:'确定',
                    iconCls:'icon-ok',
                    handler:function(){
                        $("#edit_type_form").submit();
                    }
                },{
                    text:'取消',
                    handler:function(){
                        $('#edit_type').dialog('close');
                    }
                }]
            });    
            
            $("#loading_hint").hide("normal");
        }
    );
}

/* Edit Dialog function */
function type_edit_page(tid)
{
    $("#loading_hint").show("normal");
    var json_obj;
    $.get(
        "admin_json.asp?action=type_get_info&tid=" + tid + "&seed=" + Math.random(),
        function(data){
            json_obj = eval("(" + data + ")");
            
            var row = json_obj.type[0];
            
            $("#ipt_edit_tpl_page").val(row.tpl != null ? row.tpl : "");
            KE.html('ipt_edit_pagecode_page', row.pagecode != null ? row.pagecode : "");
            $("#ipt_edit_tid_page").val(row.tid);
            $("#ipt_edit_count_page").val(row.count);
            $("#ipt_edit_type_page").val(row.type);
            $("#ipt_edit_typeurl_page").val(row.typeurl);
            $("#ipt_edit_ord_page").val(row.ord);
            $("#edit_type_page .sel_" + row.father).attr("selected", "selected");
            
            //alert(data);
            
            /* Open dialog */
            $("#edit_type_page").dialog({
                title: '编辑栏目 - ' + row.type,
                buttons:[{
                    text:'确定',
                    iconCls:'icon-ok',
                    handler:function(){
                        $("#edit_type_page_form").submit();
                    }
                },{
                    text:'取消',
                    handler:function(){
                        $('#edit_type_page').dialog('close');
                    }
                }]
            });    
            
            $("#loading_hint").hide("normal");
        }
    );
}

/* Del Dialog function */
function type_del(tid, type, count)
{
    if(count != 0)
    {
        alert("此栏目文章统计不为0，不能删除！");
        return;
    }
    
    $("#del_type_tid").val(tid);
    
    /* Open dialog */
    $("#del_type").dialog({
        title: '删除栏目 - ' + type,
        buttons:[{
            text:'确定',
            iconCls:'icon-ok',
            handler:function(){
                $("#del_type_form").submit();
            }
        },{
            text:'取消',
            handler:function(){
                $('#del_type').dialog('close');
            }
        }]
    });    
}
</script>

<div class="hint_div" id="loading_hint" style="top: 300px; display: none;">
    <img src="images/loading.gif" width="16" height="16" /> 载入中...
</div>

<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="6%" valign="middle">编号</td>
        <td width="35%" valign="middle">栏目名称</td>
        <td width="15%" valign="middle">编辑 / 删除</td>
        <td width="7%" valign="middle">类型</td>
        <td width="7%" valign="middle">统计</td>
        <td width="22%" valign="middle">GET值</td>
        <td width="8%" valign="middle">排序</td>
    </tr>
    <%    
        for i = 1 to rs.PageSize
            if rs.Eof then exit for
                echo AdminType_GetThisType(rs, 0)
            rs.MoveNext()
        next
        if Easp.Has(rs) then rs.MoveFirst()
    %>
</table>
<div class="hr"></div>

<fieldset class="admin_fieldset">
    <legend class="admin_legend">添加栏目</legend>
    <div>
    <form action="admin_type_chkedit.asp?action=add" method="post">
        <table style="border-top: 1px #ccc solid; margin-top: 10px; margin-bottom: 10px;" class="mytable"  border="0" cellspacing="0" cellpadding="0">
    <tr class="table_ipt_tr">
        <td width="19%" class="t_r">栏目名称：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%"><input type="text" name="type" id="type" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">父栏目：</td>
        <td>&nbsp;</td>
        <td>
            <select name="father">
                <option value="-1" class="sel_0" selected>根目录</option>
                <%    
                    dim select_rst
                    select_rst = ""
                    for i = 1 to rs.PageSize
                        if rs.Eof then exit for
                        select_rst = select_rst & AdminType_GetThisType_Select(rs, 1, -1)
                        rs.MoveNext()
                        
                        if not rs.EOF then
                            select_rst = str_replace("(" & 1 & "__pendding__)", select_rst, "┣")
                        else
                            select_rst = str_replace("(" & 1 & "__pendding__)", select_rst, "┗")
                        end if
                    next
                    
                    echo select_rst
                %>
            </select>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">URL的GET值：</td>
        <td>&nbsp;</td>
        <td><input type="text" name="typeurl" id="typeurl" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">排序：</td>
        <td>&nbsp;</td>
        <td><input type="text" name="ord" id="ord" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">类型：</td>
        <td>&nbsp;</td>
        <td>
            <label><input checked type="radio" name="page" value="notpage" id="page_radio" />文章</label>
            <label><input type="radio" name="page" value="page" id="page_radio" />单页</label>
        </td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">模板文件：</td>
        <td>&nbsp;</td>
        <td><input type="text" name="tpl" id="tpl" class="ipt" /> <span class="hint">*留空为默认</span></td>
    </tr>
            <tr class="table_ipt_tr"> </tr>
            <tr class="table_btn_tr">
                <td colspan="3"><input class="btn" type="submit" name="submit" id="submit" value="确认添加" />
            <input class="btn" type="reset" name="reset" id="reset" value="重新填写" /></td>
               </tr>
        </table>
</form>
    </div>
</fieldset>

<!-- 删除DIV -->
<div id="del_type" icon="icon-save" style="width: 360px;">
    <form action="admin_type_chkedit.asp?action=del" id="del_type_form" method="post">
        <div style="margin: 5px 5px 5px 5px;">确定删除？</div>
        <input type="hidden" id="del_type_tid" name="tid" value="" />
    </form>
</div>

<!-- 编辑文章栏目DIV -->
<div id="edit_type" icon="icon-save" style="width: 450px;">
    <form id="edit_type_form" action="admin_type_chkedit.asp?action=edit_art_type" method="post">
    <table style="border-top: 1px #ccc solid; margin-top: 10px; margin-bottom: 10px;" class="mytable"  border="0" cellspacing="0" cellpadding="0">
        <tr class="table_ipt_tr">
            <td width="19%" class="t_r">栏目名称：</td>
            <td width="3%">&nbsp;</td>
            <td width="78%"><input type="text" name="type" id="ipt_edit_type" class="ipt" /></td>
        </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">父栏目：</td>
            <td>&nbsp;</td>
            <td>
                <select name="father" id="ipt_edit_father">
                    <option value="-1" class="sel_-1" selected>根目录</option>
                    <%=select_rst%>
                </select>
            </td>
        </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">
            URL的GET值：</td>
            <td><input type="hidden" name="tid" id="ipt_edit_tid" class="ipt" />
            <input type="hidden" name="count" id="ipt_edit_count" class="ipt" /></td>
            <td><input type="text" name="typeurl" id="ipt_edit_typeurl" class="ipt" /></td>
        </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">排序：</td>
            <td>&nbsp;</td>
            <td><input type="text" name="ord" id="ipt_edit_ord" class="ipt" /></td>
        </tr>
        <tr class="table_ipt_tr">
        <td class="t_r">模板文件：</td>
        <td>&nbsp;</td>
        <td><input type="text" name="tpl" id="ipt_edit_tpl" class="ipt" /> <span class="hint">*留空为默认</span></td>
    </tr>

    </table>
</form>
</div>

<!-- 编辑单页栏目DIV -->
<div id="edit_type_page" icon="icon-save" style="width: 750px;">
    <form id="edit_type_page_form" action="admin_type_chkedit.asp?action=edit_art_type" method="post">
    <table style="border-top: 1px #ccc solid; margin-top: 10px; margin-bottom: 10px;" class="mytable"  border="0" cellspacing="0" cellpadding="0">
        <tr class="table_ipt_tr">
            <td width="19%" class="t_r">栏目名称：</td>
            <td width="3%">&nbsp;</td>
            <td width="78%"><input type="text" name="type" id="ipt_edit_type_page" class="ipt" /></td>
        </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">父栏目：</td>
            <td>&nbsp;</td>
            <td>
                <select name="father" id="ipt_edit_father_page">
                    <option value="-1" class="sel_-1" selected>根目录</option>
                    <%=select_rst%>
                </select>
            </td>
        </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">
            URL的GET值：</td>
            <td><input type="hidden" name="tid" id="ipt_edit_tid_page" class="ipt" />
            <input type="hidden" name="count" id="ipt_edit_count_page" class="ipt" /></td>
            <td><input type="text" name="typeurl" id="ipt_edit_typeurl_page" class="ipt" /></td>
        </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">排序：</td>
            <td>&nbsp;</td>
            <td><input type="text" name="ord" id="ipt_edit_ord_page" class="ipt" /></td>
        </tr>
        <tr class="table_ipt_tr">
        <td class="t_r">模板文件：</td>
        <td>&nbsp;</td>
        <td><input type="text" name="tpl" id="ipt_edit_tpl_page" class="ipt" /> <span class="hint">*留空为默认</span></td>
    </tr>
        <tr class="table_ipt_tr">
            <td class="t_r">内容：</td>
            <td>&nbsp;</td>
            <td><textarea name="pagecode" id="ipt_edit_pagecode_page" style="width: 550px; height: 250px;"></textarea></td>
        </tr>

    </table>
</form>
</div>

<!--#include file="admin_common_footer.asp" -->