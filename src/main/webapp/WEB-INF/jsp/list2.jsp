<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>列表页面</title>
		<%@include file="/script/myJs/common.jspf"%>
	</head>
	<body>
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false">
				<div id="onlineUserToolbar" style="padding:0 30px;">
					<div class="conditions" style="padding: 10px 0px;">
						<span class="con-span">企业域名： </span>
						<input id="realmName" name="realmName" class="easyui-textbox" value="jingmax.com" style="width:166px;height:35px;line-height:35px;">
						<span class="con-span"></span>
						<span class="con-span">子模块： </span>
						<input id="projectName" name="projectName" class="easyui-textbox" value="jm" style="width:166px;height:35px;line-height:35px;">
						<span class="con-span"></span>
						<span class="con-span">作者： </span>
						<input id="author" name="author" class="easyui-textbox" value="zhanghc" style="width:166px;height:35px;line-height:35px;">
					</div>
					<div class="conditions" style="padding: 10px 0px;">
							<span class="con-span">DB地址： </span>
							<input id="ip" name="ip" class="easyui-textbox" value="127.0.0.1" style="width:166px;height:35px;line-height:35px;">
							<span class="con-span"></span>
							<span class="con-span">用户名： </span>
							<input id="userName" name="userName" class="easyui-textbox" value="root" style="width:166px;height:35px;line-height:35px;">
							<span class="con-span"></span>
							<span class="con-span">密码： </span>
							<input id="password" name="password" class="easyui-textbox" value="root" style="width:166px;height:35px;line-height:35px;">
							<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true" onclick="conn();">连接  DB</a>
					</div>
					<div class="conditions" style="padding: 10px 0px;">
						<span class="con-span">DB库： </span>
						<input id="instanceName" name="instanceName" value="" class="easyui-textbox" style="width:166px;height:35px;line-height:35px;">
						<span class="con-span"></span>
						<span class="con-span">DB表： </span>
						<input id="tableName" name="tableName" value="" class="easyui-textbox" style="width:166px;height:35px;line-height:35px;">
						<span class="con-span"></span>
						<span class="con-span">实体名称： </span>
						<input id="entityName" name="entityName" value="" class="easyui-textbox" style="width:166px;height:35px;line-height:35px;">
						<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true" onclick="gen();">生成表格</a>
					</div>
					<div class="conditions" style="padding: 10px 0px;">
						<span class="con-span">模板库：</span>
						<input id="templateLib" name="templateLib" class="easyui-textbox" value="" style="width:166px;height:35px;line-height:35px;">
						<span class="con-span"></span>
						<span class="con-span"></span>
						<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true" onclick="gen();">生成文件</a>
					</div>
				</div>
				<%-- 在线用户数据表格 --%>
				<table id="table" class="layui-table">
	                <thead>
		                <tr>
		                    <th>事件名</th>
		                    <th>参数</th>
		                    <th>描述</th>
		                </tr>
		                </thead>
		                <tbody>
		                <tr>
		                    <td>onLoadSuccess</td>
		                    <td>data</td>
		                    <td>在数据加载成功的时候触发。</td>
		                </tr>
		                <tr>
		                    <td>onLoadError</td>
		                    <td>none</td>
		                    <td>在载入远程数据产生错误的时候触发。</td>
		                </tr>
	                </tbody>
                </table>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		//定义变量
		
		//页面加载完毕，执行如下方法：
		$(function() {
			$("#table").datagrid();
			$('#instanceName').combobox({
				 required:true,
				 editable:false,
				 valueField:'id',    
			     textField:'text',
			     onSelect: function(rec){    
			         $('#tableName').combobox('reload', '/tableList?ip=' + $("#ip").val() + "&userName=" + $("#userName").val() + "&password=" + $("#password").val() 
			        		  + "&instanceName=" + rec.id);  
			     }
			 });
			 
			 $('#tableName').combobox({
				 required:true,
				 editable:false,
				 valueField:'id',    
			     textField:'text'
			 });
			 
			 $('#templateLib').combobox({
				 required:true,
				 editable:false,
				 valueField:'id',    
			     textField:'text', 
			     url:'/templateList',
			     value:"后台模板"
			 });
			 
			 $('#realmName').validatebox({    
				 required: true
			 });
			 
			 $('#projectName').validatebox({    
				 required: true
			 });
		});
		
		function conn(){
		    $('#instanceName').combobox({
		        url:'/list?ip=' + $("#ip").val() + "&userName=" + $("#userName").val()+ "&password=" + $("#password").val()    
		    });
		}
		
		function gen(){
		   window.location.href = '/gen?ip=' + $("#ip").val() + "&userName=" + $("#userName").val() 
				   	+ "&password=" + $("#password").val() + "&author=" +  $("#author").val() 
				   	+ "&instanceName=" + $("#instanceName").combobox("getValue")
		   			+ "&tableName=" + $("#tableName").combobox("getValue")
		   			+ "&realmName=" + $("#realmName").val()
		   			+ "&projectName=" + $("#projectName").val()
		   			+ "&entityName=" + $("#entityName").val() ;
		}
		
	</script>
</html>