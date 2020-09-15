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
			<div class="layui-row layui-col-space10">
				<div class="layui-col-md2">
					<div class="layui-card">
						<div class="layui-form">
			      			<ul id="${entityName}Tree" class="ztree"></ul>
			 			</div>
					</div>
				</div>
				<div class="layui-col-md10">
					<div class="layui-card">
						<%-- ${tableName}查询条件 --%>
						<form id="${entityName}QueryForm" class="layui-form layui-card-header layuiadmin-card-header-auto">
							<input type="hidden" id="${entityName}_one" name="one">
							<div class="layui-form-item">
								<div class="layui-inline">
									<input type="text" name="two" placeholder="请输入ID" class="layui-input">
								</div>
						<#list conditionInfoList as condition>
							<#if condition.search == 1>
								<div class="layui-inline">
									<input type="text" name="${condition.pageInName}" placeholder="请输入${condition.name}" class="layui-input">
								</div>
							</#if>
							<#if condition.search == 2>
								<div class="layui-inline">
									<input type="text" name="${condition.pageInName}" placeholder="请输入${condition.name}" class="layui-input">
								</div>
							</#if>
						</#list>
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
								<my:auth url="${entityName}/toMove"><a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="${entityName}Move"><i class="layui-icon layui-icon-edit"></i>移动</a></my:auth>
								<my:auth url="${entityName}/doDel"><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="${entityName}Del"><i class="layui-icon layui-icon-delete"></i>删除</a></my:auth>
							</script>
							<%-- ${tableName}数据表格 --%>
							<table id="${entityName}Table" lay-filter="${entityName}Table"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<%@include file="/script/myJs/tail.jspf"%>
	<script type="text/javascript">
		//定义变量
		var ${entityName}QueryForm = $("#${entityName}QueryForm"); //${tableName}查询对象
		var ${entityName}Tree; //${tableName}树对象
		var curSel${entityNameFU}Id = ""; //当前选中的${tableName}ID
		var curSel${entityNameFU}Name = ""; //当前选中的${tableName}名称
		
		//页面加载完毕，执行如下方法：
		$(function() {
			init${entityNameFU}Table();
			init${entityNameFU}Tree();
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
				<my:auth url="${entityName}/toEdit">to${entityNameFU}Edit(obj.data.ID);</my:auth>
			});
			layui.table.on("tool(${entityName}Table)", function(obj){
				var data = obj.data;
				if(obj.event === "${entityName}Edit") {
					to${entityNameFU}Edit(obj.data.ID);
				} else if(obj.event === "${entityName}Move") {
					to${entityNameFU}Move(obj.data);
				} else if(obj.event === "${entityName}Del") {
					do${entityNameFU}Del(obj.data.ID);
				}
			});
		}
		
		//初始化${tableName}树
		function init${entityNameFU}Tree() {
			${entityName}Tree = $.fn.zTree.init($("#${entityName}Tree"), {
				async : {
					url : "${entityName}/treeList",
					enable : true,
					dataFilter : ztreeDataFilter
				},
				callback : {
					onClick : function(event, treeId, treeNode) {
						curSel${entityNameFU}Id = treeNode.ID;
						curSel${entityNameFU}Name = treeNode.NAME;
						$("#${entityName}_one").val(curSel${entityNameFU}Id);
						${entityName}Query();
					},
					onAsyncSuccess : function(event, treeId, msg, treeNode) {
						var ${entityName}Tree = $.fn.zTree.getZTreeObj(treeId);
						${entityName}Tree.expandAll(true);
						
						if (!curSel${entityNameFU}Id) {
							var rootNode = ${entityName}Tree.getNodesByFilter(function(node) { return (node.level == 0); }, true);
							${entityName}Tree.selectNode(rootNode);
							
							curSel${entityNameFU}Id = rootNode.ID;
							curSel${entityNameFU}Name = rootNode.NAME;
							$("#${entityName}_one").val(curSel${entityNameFU}Id);
							return;
						}
						
						var curNode = ${entityName}Tree.getNodeByParam("id", curSel${entityNameFU}Id, null);
						${entityName}Tree.selectNode(curNode);
						
						${entityName}Query();
					}
				}
			});
			
			$("#${entityName}Tree").height($(window).height() - 45);
		}
		
		//${tableName}查询
		function ${entityName}Query() {
			layui.table.reload("${entityName}Table", {"where" : $.fn.my.serializeObj(${entityName}QueryForm)});
		}
	
		//${tableName}重置
		function ${entityName}Reset() {
			${entityName}QueryForm[0].reset();
			${entityName}Query();
		}
		
		//到达添加${tableName}页面
		function to${entityNameFU}Add() {
			if(!curSel${entityNameFU}Id){
				layer.alert("请选择上级${tableName}！", {"title" : "提示消息"});
				return;
			}
			
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
							$("#${entityName}_parentId").val(curSel${entityNameFU}Id);
							$("#${entityName}_parentName").val(curSel${entityNameFU}Name);
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
							${entityName}TreeFlush();
							
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
			$("[lay-filter='${entityName}EditBtn']").click();
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
							${entityName}TreeFlush();
							
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
			$("[lay-filter='${entityName}EditBtn']").click();
		}

		//完成删除${tableName}
		function do${entityNameFU}Del(id) {
			layer.confirm("确定要删除？", function(index) {
				$.ajax({
					url : "${entityName}/doDel",
					data : {id : id},
					success : function(obj) {
						${entityName}TreeFlush();
						
						if (!obj.succ) {
							layer.alert(obj.msg, {"title" : "提示消息"});
							return;
						}
						
						layer.close(index);
					}
				});
			});
		}
		
		//到达移动${tableName}页面
		function to${entityNameFU}Move(${entityName}Obj){
			$.ajax({
				url : "${entityName}/toMove",
				dataType : "html",
				success : function(obj) {
					layer.open({
						title : "选择${tableName}",
						area : ["300px", "500px"],
						content : obj,
						btn : ["移动", "取消"],
						type : 1,
						yes : function(index, layero){
							var ${entityName}MoveTreeObj = $.fn.zTree.getZTreeObj("${entityName}MoveTree");
							var ${entityName}MoveNodes = ${entityName}MoveTreeObj.getSelectedNodes();
							if (${entityName}MoveNodes.length != 1) {
								layer.alert("请选择一行数据！", {"title" : "提示消息"});
								return;
							}
							
							var sourceId = ${entityName}Obj.ID;
							var sourceName = ${entityName}Obj.NAME;
							var targetId = ${entityName}MoveNodes[0].ID;
							var targetName = ${entityName}MoveNodes[0].NAME;
							if(sourceId == targetId){
								layer.alert("源${tableName}和目标${tableName}一致！", {"title" : "提示消息"});
								return;
							}
							if(${entityName}MoveNodes[0].PARENT_SUB.indexOf(${entityName}Obj.PARENT_SUB) >= 0){
								layer.alert("父${tableName}不能移动到子${tableName}下！", {"title" : "提示消息"});
								return;
							}
							
							do${entityNameFU}Move(sourceId, sourceName, targetId, targetName, index);
						},
						success: function(layero, index) {
							$.fn.zTree.init($("#${entityName}MoveTree"), {
								async : {
									url : "${entityName}/treeList",
									otherParam : {
										
									},
									enable : true,
									dataFilter : ztreeDataFilter
								},
								callback : {
									onAsyncSuccess : function(event, treeId, msg, treeNode) {
										var rootNode = ${entityName}Tree.getNodesByFilter(function(node) { return (node.level == 0); }, true);
										${entityName}Tree.selectNode(rootNode);
									}
								}
							});
						}
					});
				}
			});
		}
		
		//完成移动${tableName}
		function do${entityNameFU}Move(sourceId, sourceName, targetId, targetName, ${entityName}DialogIndex){
			layer.confirm("确定要移动【"+sourceName+"】到【"+targetName+"】？", {title : "确认消息"}, function(index){
				var params = {"sourceId" : sourceId, "targetId" : targetId};
				$.ajax({
					url : "${entityName}/doMove",
					data : params,
					success : function(obj){
						${entityName}TreeFlush();
						
						if(!obj.succ){
							layer.alert(obj.msg, {"title" : "提示消息"});
							return;
						}
						
						layer.close(index);
						layer.close(${entityName}DialogIndex);
					}
				});
			});
			$("[lay-filter='${entityName}MoveBtn']").click();
		}
		
		//刷新${tableName}
		function ${entityName}TreeFlush() {
			${entityName}Tree.reAsyncChildNodes(null, "refresh");
			init${entityNameFU}Table();
		}
		
	</script>
</html>
