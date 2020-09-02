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
				<form id="${entityName}QueryForm" class="layui-form layui-card-header layuiadmin-card-header-auto">
					<div class="layui-form-item layui-form-item-ex">
						<div class="layui-inline">
							<div class="layui-input-block">
								<input type="text" name="one" placeholder="请输入索引" class="layui-input">
							</div>
						</div>
						<div class="layui-inline">
							<div class="layui-input-block">
								<input type="text" name="two" placeholder="请输入键" class="layui-input">
							</div>
						</div>
						<div class="layui-inline">
							<div class="layui-input-block">
								<input type="text" name="three" placeholder="请输入值" class="layui-input">
							</div>
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
					<div id="${entityName}Toolbar" style="display: none;">
						<div class="layui-btn-container">
							<my:auth url="${entityName}/toAdd"><button class="layui-btn layuiadmin-btn-useradmin" onclick="to${entityNameFU}Add();">添加</button></my:auth>
							<my:auth url="${entityName}/toEdit"><button class="layui-btn layui-btn-primary layuiadmin-btn-useradmin" onclick="to${entityNameFU}EditForBtn();">修改</button></my:auth>
							<my:auth url="${entityName}/doDel"><button class="layui-btn layui-btn-primary layuiadmin-btn-useradmin" onclick="do${entityNameFU}DelForBtn();">删除</button></my:auth>
						</div>
					</div>
					<%-- 数据表格 --%>
					<table id="${entityName}Table" lay-filter="${entityName}Table"></table>
				</div>
			</div>
		</div>
	</body>
	<%@include file="/script/myJs/tail.jspf"%>
	<script type="text/javascript">
		//定义变量
		var ${entityName}TableId = "${entityName}Table";//${tableName}表格ID
		var ${entityName}QueryForm = $("#${entityName}QueryForm"); //${tableName}查询对象
		
		//页面加载完毕，执行如下方法：
		$(function() {
			init${entityNameFU}Table();
		});
	
		//初始化${tableName}表格
		function init${entityNameFU}Table() {
			layui.table.render({
				elem : "#" + ${entityName}TableId,
				url : "${entityName}/list",
				toolbar : "#${entityName}Toolbar",
				cols : [[
						<#list conditionInfoList as conditionInfo>
						<#if conditionInfo.code == "ID">
						{field : "ID", title : "", checkbox : true},
						<#elseif conditionInfo.code != "ID">
						<#if conditionInfo.web == 1>
						<#if conditionInfo.type == 6>
						{field : "${conditionInfo.code}_STR", title : "${conditionInfo.name}", align : "center"}<#sep>,</#sep>
						</#if>
						<#if conditionInfo.type == 7>
						{field : "${conditionInfo.code}_NAME", title : "${conditionInfo.name}", align : "center"}<#sep>,</#sep>
						</#if>
						{field : "${conditionInfo.code}", title : "${conditionInfo.name}", align : "center"}<#sep>,</#sep>
						</#if>
						</#if>
						</#list>
						]],
				page : true,
				height : "full-135",
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
			layui.table.on("rowDouble("+${entityName}TableId+")", function(obj){
				<my:auth url="${entityName}/toEdit">to${entityNameFU}EditForDblClick(obj.data.ID);</my:auth>
			});
		}
		
		//${tableName}查询
		function ${entityName}Query() {
			layui.table.reload(${entityName}TableId, {"where" : $.fn.my.serializeObj(${entityName}QueryForm)});
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
						type : 1,
						area : ["800px", "500px"],
						content : obj,
						resize : false,
						btn : ["添加", "取消"],
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
						type : 1,
						area : ["800px", "500px"],
						content : obj,
						resize : false,
						btn : ["修改", "取消"],
						yes : function(index, layero){
							do${entityNameFU}Edit(index);
						},
						success: function(layero, index){
							layui.form.render(null, "${entityName}EditFrom");
						}
					});
				}
			});
		}

		//到达修改${tableName}页面
		function to${entityNameFU}EditForBtn() {
			var ${entityName}TableRows = layui.table.checkStatus(${entityName}TableId);
			if (${entityName}TableRows.data.length != 1) {
				layer.alert("请选择一行数据！", {"title" : "提示消息"});
				return;
			}
			
			to${entityNameFU}Edit(${entityName}TableRows.data[0].ID);
		}

		//到达修改${tableName}页面
		function to${entityNameFU}EditForDblClick(id) {
			to${entityNameFU}Edit(id);
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
			//校验数据有效性
			var ${entityName}TableRows = layui.table.checkStatus(${entityName}TableId);
			if (${entityName}TableRows.data.length == 0) {
				layer.alert("请选择一行或多行数据！", {"title" : "提示消息"});
				return;
			}
			
			//删除
			layer.confirm("确定要删除？", function(index) {
				$.ajax({
					url : "${entityName}/doDel",
					data : $.fn.my.serializeField(${entityName}TableRows.data),
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
		
		<#list conditionInfoList as conditionInfo>
		<#if conditionInfo.type == 6>
		layui.laydate.render({
	        elem: '#${conditionInfo.entityCode}'
	        ,type: 'datetime'
	      })
		</#if>
		</#list>
	</script>
</html>
