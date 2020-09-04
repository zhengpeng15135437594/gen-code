<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" uri="myTag/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>${tableName}列表</title>
		<%@include file="/script/myJs/common.jspf"%>
	</head>
	<body>
		<div class="layui-fluid">
			<div class="layui-card">
				<%-- ${tableName}查询条件 --%>
				<form id="${entityName}QueryForm" class="layui-form layui-card-header layuiadmin-card-header-auto">
					<div class="layui-form-item ">
						<div class="layui-inline">
							<input type="text" name="one" placeholder="请输入ID" class="layui-input">
						</div>
						<div class="layui-inline">
							<button type="button" class="layui-btn layuiadmin-btn-useradmin" onclick="${entityName}Query();">
								<i class="layui-icon layuiadmin-button-btn"></i>查询
							</button>
							<button type="button" class="layui-btn layui-btn-primary layuiadmin-btn-useradmin" onclick="${entityName}Reset();">
								<i class="layui-icon layuiadmin-button-btn"></i>重置
							</button>
						</div>
					</div>
				</form>
				<div class="layui-card-body">
					<div style="padding-bottom: 10px;">
						<my:auth url="${entityName}/toAdd"><button class="layui-btn layuiadmin-btn-useradmin" onclick="to${entityNameFU}Add();">添加</button></my:auth>
					</div>
					<script type="text/html" id="${entityName}Toolbar">
						<my:auth url="${entityName}/toEdit"><a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="${entityName}Edit"><i class="layui-icon layui-icon-edit"></i>修改</a></my:auth>
						<my:auth url="${entityName}/doDel"><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="${entityName}Del"><i class="layui-icon layui-icon-delete"></i>删除</a></my:auth>
					</script>
					<%-- ${tableName}数据表格 --%>
					<table id="${entityName}Table" lay-filter="${entityName}Table"></table>
				</div>
			</div>
		</div>
	</body>
	<%@include file="/script/myJs/tail.jspf"%>
	<script type="text/javascript">
		//定义变量
		var ${entityName}QueryForm = $("#${entityName}QueryForm"); //${tableName}查询对象
		
		//页面加载完毕，执行如下方法：
		$(function() {
			init${entityNameFU}Table();
		});
	
		//初始化${tableName}表格
		function init${entityNameFU}Table() {
			layui.table.render({
				elem : "#${entityName}Table",
				url : "${entityName}/list",
				cols : [[
						<#list conditionInfoList as conditionInfo>
						<#if conditionInfo.web == 1>
						<#if conditionInfo.type == 6>
						{field : "${conditionInfo.code}_STR", title : "${conditionInfo.name}", align : "center"},
						</#if>
						<#if conditionInfo.type == 7>
						{field : "${conditionInfo.code}_NAME", title : "${conditionInfo.name}", align : "center"},
						</#if>
						{field : "${conditionInfo.code}", title : "${conditionInfo.name}", align : "center"},
						</#if>
						</#list>
						{fixed: 'right', title : "操作 ", toolbar : "#${entityName}Toolbar", align : "center"}
						]],
				page : true,
				height : "full-180",
				method : "post",
				defaultToolbar : [],
				parseData: function(${entityName}){
					return {
						"code" : ${entityName}.succ,
						"msg" : ${entityName}.msg,
						"count" : ${entityName}.data.total,
						"data" : ${entityName}.data.rows
					};
				},
				request: {
					pageName: "curPage",
					limitName: "pageSize"
				}, 
				response: {
					statusCode : true
				}
			});
			layui.table.on("rowDouble(${entityName}Table)", function(obj){
				<my:auth url="${entityName}/toEdit">to${entityNameFU}EditForDblClick(obj.data.ID);</my:auth>
			});
			layui.table.on("tool(${entityName}Table)", function(obj){
				var data = obj.data;
				if(obj.event === "${entityName}Edit") {
					to${entityNameFU}Edit(obj.data.ID);
				} else if(obj.event === "${entityName}Del") {
					do${entityNameFU}Del(obj.data.ID);
				}
			});
		}
		
		//${tableName}查询
		function ${entityName}Query() {
			layui.table.reload(${entityName}Table, {"where" : $.fn.my.serializeObj(${entityName}QueryForm)});
		}
	
		//${tableName}重置
		function ${entityName}Reset() {
			${entityName}QueryForm[0].reset();
			${entityName}Query();
		}
		
		//到达添加${tableName}页面
		function to${entityNameFU}Add() {
			$.ajax({
				url : "${entityName}/toAdd",
				dataType : "html",
				success : function(obj) {
					layer.open({
						title : "添加${tableName}",
						area : ["800px", "500px"],
						content : obj,
						btn : ["添加", "取消"],
						type : 1,
						yes : function(index, layero){
							do${entityNameFU}Add(index);
						},
						success: function(layero, index){
							layui.form.render(null, "${entityName}EditFrom");
						}
					});
				}
			});
		}

		//完成添加${tableName}
		function do${entityNameFU}Add(${entityName}AddDialogIndex) {
			layui.form.on("submit(${entityName}EditBtn)", function(data) {
				layer.confirm("确定要添加？", function(index) {
					$.ajax({
						url : "${entityName}/doAdd",
						data : data.field,
						success : function(obj) {
							${entityName}Query();
							
							if (!obj.succ) {
								layer.alert(obj.msg, {"title" : "提示消息"});
								return;
							}
							
							layer.close(index);
							layer.close(${entityName}AddDialogIndex);
						}
					});
				});
			});
			$("#${entityName}EditBtn").click();
		}
		
		//到达修改${tableName}页面
		function to${entityNameFU}Edit(id) {
			$.ajax({
				url : "${entityName}/toEdit",
				data : {"id" : id},
				dataType : "html",
				success : function(obj) {
					layer.open({
						title : "修改${tableName}",
						area : ["800px", "500px"],
						content : obj,
						btn : ["修改", "取消"],
						type : 1,
						yes : function(index, layero){
							do${entityNameFU}Edit(index);
						},
						success: function(layero, index){
							<#list conditionInfoList as conditionInfo>
								<#if conditionInfo.type == 6>
							layui.laydate.render({elem: "#${conditionInfo.entityCode}",type: "datetime"});
								</#if>
							</#list>
							layui.form.render(null, "${entityName}EditFrom");
						}
					});
				}
			});
		}

		//完成修改${tableName}
		function do${entityNameFU}Edit(${entityName}EditDialogIndex) {
			layui.form.on("submit(${entityName}EditBtn)", function(data) {
				layer.confirm("确定要修改？", function(index) {
					$.ajax({
						url : "${entityName}/doEdit",
						data : data.field,
						success : function(obj) {
							${entityName}Query();
							
							if (!obj.succ) {
								layer.alert(obj.msg, {"title" : "提示消息"});
								return;
							}
							
							layer.close(index);
							layer.close(${entityName}EditDialogIndex);
						}
					});
				});
			});
			$("#${entityName}EditBtn").click();;
		}

		//完成删除${tableName}
		function do${entityNameFU}DelForBtn() {
			layer.confirm("确定要删除？", function(index) {
				$.ajax({
					url : "${entityName}/doDel",
					data : {id : id},
					success : function(obj) {
						${entityName}Query();
						
						if (!obj.succ) {
							layer.alert(obj.msg, {"title" : "提示消息"});
							return;
						}
						
						layer.close(index);
					}
				});
			});
		}

	</script>
</html>
