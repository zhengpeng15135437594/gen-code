<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" uri="myTag/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>${tableName}列表</title>
		<%@include file="/script/myJs/common.jspf"%>
		<style type="text/css">
			.left {
				width: 280px;
				padding: 5px;
				height: 800px;
				overflow: auto;
				margin-top: 15px;
			}
			.right {
				position: absolute;
				top: 0;
				right: 0;
				left: 280px;
			}
		</style>
	</head>
	<body>
		<div class="left">
			<div class="layui-card" style="height: 100%;">
				<ul id="${entityName}Tree" class="ztree"></ul>
				<div id="${entityName}TreeMenu"></div>
			</div>
		</div>
		<div class="right">
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
							<button type="button" class="layui-btn layui-btn-primary layuiadmin-btn-useradmin" onclick="${entityName}${entityNameFU}et();">
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
		var ${entityName}Tree;//${tableName}树对象
		var ${entityName}TreeMenuId = "${entityName}TreeMenu"; //${tableName}表格ID
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
		
			//初始化${tableName}树
			function init${entityNameFU}Tree() {
				${entityName}Tree = $.fn.zTree.init($("#${entityName}Tree"), {
					async : {
						enable : true,
						url : "${entityName}/treeList",
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
			}
		
		//${tableName}查询
		function ${entityName}Query() {
			layui.table.reload(${entityName}TableId, {"where" : $.fn.my.serializeObj(${entityName}QueryForm)});
		}
	
		//${tableName}重置
		function ${entityName}${entityNameFU}et() {
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
		
		//到达移动${tableName}页面
		function to${entityNameFU}MoveForBtn(){
			var ${entityName}TableRows = layui.table.checkStatus(${entityName}TableId);
			if (${entityName}TableRows.data.length != 1) {
				layer.alert("请选择一行数据！", {"title" : "提示消息"});
				return;
			}
			
			$.ajax({
				url : "${entityName}/toMove",
				dataType : "html",
				success : function(obj) {
					layer.open({
						title : "选择${tableName}",
						type : 1,
						area : ["300px", "500px"],
						content : obj,
						resize : false,
						btn : [],
						yes : function(index, layero){
							do${entityNameFU}Edit(index);
						},
						success: function(layero, index) {
							$.ajax({
								url : "${entityName}/move${entityNameFU}TreeList",
								success : function(obj) {
									var list = obj;
									var treeList = [];
									var treeMap = {};
									var idFiled = "ID";
									var textFiled = "NAME";
									var checkedFiled = "CHECKED";
									var parentField = "PARENT_ID";
									var parentField = "PARENT_ID";
									var iconClsFiled = "ICON";

									for (var i = 0; i < list.length; i++) {
										list[i]["id"] = list[i][idFiled];
										list[i]["title"] = list[i][textFiled];
										if(list[i][checkedFiled]){
											list[i]["checked"] = true;
										}
										list[i]["iconCls"] = list[i][iconClsFiled];
										treeMap[list[i]["id"]] = list[i];
									}

									for (var i = 0; i < list.length; i++) {
										if (treeMap[list[i][parentField]] && list[i]["id"] != list[i][parentField]) {
											if (!treeMap[list[i][parentField]]["children"]) {
												treeMap[list[i][parentField]]["children"] = [];
											}
											treeMap[list[i][parentField]]["children"].push(list[i]);
										} else {
											treeList.push(list[i]);
										}
									}
									
									layui.tree.render({
										id : "${entityName}MoveTreeId",
										elem : "#${entityName}MoveTree",
										data : treeList,
										click : function(obj) {
											var sourceId = ${entityName}TableRows.data[0].ID;
											var sourceName = ${entityName}TableRows.data[0].NAME;
											var targetId = obj.data.ID;
											var targetName = obj.data.NAME;
											if(sourceId == targetId){
												layer.alert("源${tableName}和目标${tableName}一致！", {"title" : "提示消息"});
												return;
											}
											if(obj.data.PARENT_SUB.indexOf(${entityName}TableRows.data[0].PARENT_SUB) >= 0){
												layer.alert("父${tableName}不能移动到子${tableName}下！", {"title" : "提示消息"});
												return;
											}
											
											do${entityNameFU}Move(sourceId, sourceName, targetId, targetName, index);
										}
									});
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
						init${entityNameFU}Tree();
						${entityName}Query();
						
						if(!obj.succ){
							parent.$.messager.alert("提示消息", obj.msg, "info");
							return;
						}
						
						layer.close(index);
						layer.close(${entityName}DialogIndex);
					}
				});
			});
		}
		
		//刷新${tableName}
		function ${entityName}TreeFlush() {
			${entityName}Tree.reAsyncChildNodes(null, "refresh");
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
