﻿<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config2.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"News_List")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If Action="Save" Then
	NewsTitle=ReplaceBadChar(Trim(Request("NewsTitle")))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	NewsSPic=Trim(Request("NewsSPic"))
	NewsBPic=Trim(Request("NewsBPic"))
	NewsAuthor=ReplaceBadChar(Trim(Request("NewsAuthor")))
	Keywords=ReplaceBadChar(Trim(Request("Keywords")))
	NewsContent=Trim(Request("NewsContent"))
	NewsLock=ReplaceBadChar(Trim(Request("NewsLock")))	
	NewsVisit=ReplaceBadChar(Trim(Request("NewsVisit")))
	PostTime=Trim(Request("PostTime"))
	If PostTime="" Or IsDate(PostTime)=false Then
		PostTime=Now()
	End If
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From NewsInfo Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("NewsTitle")=NewsTitle
	Rs("ClassID")=ClassID
	Rs("NewsSPic")=NewsSPic
	Rs("NewsBPic")=NewsBPic
	Rs("NewsAuthor")=NewsAuthor
	Rs("Keywords")=Keywords
	Rs("NewsContent")=NewsContent
	Rs("NewsLock")=NewsLock
	Rs("NewsVisit")=NewsVisit
	Rs("PostTime")=PostTime
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u4fe1\u606f\u7f16\u8f91\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='News_List.asp?ClassID="&ClassID&"&Page="&Page&"';</script>")
	Response.End()
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：信息管理 >> 编辑信息</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">信息内容需填写标题，选择所对应的类别。<br /></td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From NewsInfo Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	ClassID=Rs("ClassID")
	NewsTitle=Rs("NewsTitle")
	NewsSPic=Rs("NewsSPic")
	NewsBPic=Rs("NewsBPic")
	NewsAuthor=Rs("NewsAuthor")
	Keywords=Rs("Keywords")
	PostTime=Rs("PostTime")
	NewsContent=Rs("NewsContent")
	NewsLock=Rs("NewsLock")
	NewsVisit=Rs("NewsVisit")
End If
Rs.Close
Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#NewsTitle").val()=="")
	{
		alert("\u4fe1\u606f\u6807\u9898\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NewsTitle").focus();
		return false;
	}
	if ($("#ClassID").val()=="0")
  {
    alert("请选择栏目!");
    $("#ClassID").focus();
    return false;
  }
	return true;	
}
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
});
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="4">编辑信息</th>
</tr>
<tr>
<td class="Right" align="right" width="15%">信息标题：</td>
<td class="Right" width="35%"><input type="text" id="NewsTitle" name="NewsTitle" value="<%=NewsTitle%>" class="Input200px"/></td>
<td class="Right" width="15%" align="right">信息类别：</td>
<td width="35%"><select id="ClassID" name="ClassID" style="width:200px;">
<option value="0">|--请选择栏目</option>
<%=GetSelect("NewsClass",0)%>
</select></td>
</tr>
<tr>
<td class="Right" align="right">信息小图：</td>
<td class="Right"><input type="text" id="NewsSPic" name="NewsSPic" value="<%=NewsSPic%>" class="Input200px"/> <a href="javascript:OpenImageBrowser('NewsSPic');">浏览...</a></td>
<td class="Right" align="right">信息大图：</td>
<td><input type="text" id="NewsBPic" name="NewsBPic" value="<%=NewsBPic%>" class="Input200px"/> <a href="javascript:OpenImageBrowser('NewsBPic');">浏览...</a></td>
</tr>
<tr>
<td class="Right" align="right">发 布 人：</td>
<td class="Right"><input type="text" id="NewsAuthor" name="NewsAuthor" value="<%=NewsAuthor%>" class="Input200px"/></td>
<td class="Right" align="right">发布时间：</td>
<td><input type="text" id="PostTime" name="PostTime" value="<%=FormatTime(PostTime,1)%>" class="Input200px"/></td>
</tr>
<tr>
<td class="Right" align="right">关 键 字：</td>
<td colspan="2" class="Right"><input type="text" id="Keywords" name="Keywords" value="<%=Keywords%>" class="Input200px" style="width:370px"/></td>
<td>多个关键字请用“|”（竖线）隔开</td>
</tr>
<tr>
<td class="Right" align="right" valign="top">信息内容：</td>
<td colspan="3"><%=Editor("NewsContent",NewsContent)%>
</td>
</tr>
<tr style="display:none">
<td class="Right" align="right">浏览人群：</td>
<td class="Right"><input type="radio" id="NewsVisit" name="NewsVisit" value="0" checked="checked"<%If NewsVisit="0" Then Response.Write(" checked=""checked""")%>/>所有人群<input type="radio" id="NewsVisit" name="NewsVisit" value="1"<%If NewsVisit="1" Then Response.Write(" checked=""checked""")%>/>网站会员</td>
<td class="Right" align="right">信息状态：</td>
<td><input type="radio" id="NewsLock" name="NewsLock" value="0" checked="checked"<%If NewsLock="0" Then Response.Write(" checked=""checked""")%>/>解锁状态<input type="radio" id="NewsLock" name="NewsLock" value="1"<%If NewsLock="1" Then Response.Write(" checked=""checked""")%>/>锁定状态</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>