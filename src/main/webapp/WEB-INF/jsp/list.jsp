<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>列表</title>
		<%@include file="/script/myJs/common.jspf"%>
		<style type="text/css">
		 .layui-form-radio i {
			  top: 0;
			  width: 15px;
			  height: 15px;
			  line-height: 15px;
			  border: 1px solid #d2d2d2;
			  font-size: 10px;
			  border-radius: 2px;
			  background-color: #fff;
			  color: #fff !important;
			}
			.layui-form-radioed i {
			  position: relative;
			  width: 12px;
			  height: 15px;
			  border-style: solid;
			  background-color: #6A8BF5;
			  color: #6A8BF5 !important;
			}
			/* 使用伪类画选中的对号 */
			.layui-form-radioed i::after, .layui-form-radioed i::before {
			  content: "";
			  position: absolute;
			  top: 8px;
			  left: 3px;
			  display: block;
			  width: 12px;
			  height: 2px;
			  border-radius: 4px;
			  background-color: #fff;
			  -webkit-transform: rotate(-45deg);
			  transform: rotate(-45deg);
			}
			.layui-form-radioed i::before {
			  position: absolute;
			  top: 10px;
			  left: 1px;
			  width: 5px;
			  transform: rotate(-135deg);
			}
		</style>
	</head>
	<body>
		<div class="layui-fluid">
			<div class="layui-card">
				<%-- 用户查询条件 --%>
				<form lay-filter="from" class="layui-form layui-card-header layuiadmin-card-header-auto">
					<input type="hidden" id="user_one" name="one">
					<div class="layui-form-item">
						<div class="layui-inline">
							<input type="text" name="dbAddr" placeholder="请输入DB地址" class="layui-input" value="127.0.0.1">
						</div>
						<div class="layui-inline">
							<input type="text" name="dbUserName" placeholder="请输入DB用户名" class="layui-input" value="root">
						</div>
						<div class="layui-inline">
							<input type="text" name="dbPwd" placeholder="请输入DB密码" class="layui-input" value="root"> <!-- EGHJDKhdsng.&jdsk456 -->
						</div>
						<div class="layui-inline">
							<button type="button" lay-submit lay-filter="connDb" class="layui-btn layuiadmin-btn-useradmin" onclick="connDb()">
								<i class="layui-icon layuiadmin-button-btn"></i>连接DB
							</button>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline" style="width: 182px">
							<select name="instanceName" lay-filter="dbList">
			      			</select>
						</div>
						<div class="layui-inline" style="width: 182px">
							<select name="tableName" lay-filter="dbTableList">
			      			</select>
						</div>
						<div class="layui-inline" style="width: 182px">
							<input type="text" id="four" name="four" placeholder="请输入实体名称"  class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<input type="text" name="two" placeholder="请输入公司域名" class="layui-input" value="jingmax.com">
						</div>
						<div class="layui-inline">
							<input type="text" name="three" placeholder="请输入项目模块" class="layui-input" value="jm">
						</div>
						<div class="layui-inline">
							<input type="text" name="five" placeholder="请输入作者" class="layui-input" value="zhanghc">
						</div>
						<div class="layui-inline" style="width: 182px">
					       <select name = "templateLib" lay-filter="">
					        <c:forEach items="${files}" var = "file" >
					             <option value="${file.text }">${file.text }</option>
					        </c:forEach>
					            </select>
					     </div>
						<div class="layui-inline">
							<button type="button" lay-submit lay-filter="createFrom" class="layui-btn layuiadmin-btn-useradmin" onclick="createFrom()">
								<i class="layui-icon layuiadmin-button-btn"></i>生成表单
							</button>
						</div>
						<div class="layui-inline">
							<button type="button" lay-submit lay-filter="createFile" class="layui-btn layuiadmin-btn-useradmin" onclick="createFile()">
								<i class="layui-icon layuiadmin-button-btn"></i>生成文件
							</button>
						</div>
					</div>
				</form>
				<div class="layui-card-body">
					<div style="padding-bottom: 10px;">
					</div>
					<%-- 数据表格 --%>
					<table id="table" class="layui-table layui-form" id="dbEntityList" name="dbEntityList" lay-filter="dbEntityList">
						<%-- <colgroup>
						</colgroup> 
						<thead>
							<tr>
								<th>字段</th>
								<th>名称</th>
								<th>类型</th>
								<th>页面展示</th>
								<th>必填项</th>
								<th>查询条件</th>
								<th>排序</th>
							</tr>
						</thead>
						<tbody>
						<tr>
								<td>
									NAME
									<input type="hidden" name="name" value="名称">
								</td>
								<td>
									<input type="text" name="four" placeholder="请输入名称" class="layui-input" value="名称">
								</td>
								<td>
									<input type="radio" name="sex" value="nan" title="输入" checked>
									<input type="radio" name="sex" value="nan" title="选择">
									<input type="radio" name="sex" value="nan" title="单选">
									<input type="radio" name="sex" value="nan" title="多选">
									<input type="radio" name="sex" value="nan" title="文本域">
								</td>
								<td>
									<input type="checkbox" name="switch" lay-skin="switch" lay-text="开启|关闭">
								</td>
								<td>
									<input type="checkbox" name="switch" lay-skin="switch" lay-text="开启|关闭">
								</td>
								<td>
									<input type="radio" name="sex" value="nan" title="关闭" checked>
									<input type="radio" name="sex" value="nan" title="等于">
									<input type="radio" name="sex" value="nan" title="模糊">
								</td>
								<td>
									<input type="radio" name="sex" value="nan" title="关闭" checked>
									<input type="radio" name="sex" value="nan" title="倒序">
									<input type="radio" name="sex" value="nan" title="正序">
								</td>
							</tr> 
						</tbody>--%>
					</table>
				</div>
			</div>
		</div>
	</body>
	<%@include file="/script/myJs/tail.jspf"%>
	<script type="text/javascript">
		//页面加载完毕，执行如下方法：
		$(function() {
			layui.form.on("select(dbList)", function(data) {
				initDbTableList({"dbAddr" : $("input[name='dbAddr']").val(), 
								 "dbUserName" : $("input[name='dbUserName']").val(), 
							   	 "dbPwd" : $("input[name='dbPwd']").val(), 
								 "dbInstanceName" :  data.value});
			});
			
			layui.form.on("select(dbTableList)", function(data) {
				initDbTableEntity({"dbTableEntity" :  data.value});
			});
		});
		
		// 连接DB
		function connDb(){
			layui.form.on("submit(connDb)", function(data) {
				$.ajax({
					url : "home/dbList",
					data : data.field,
					success : function(obj) {

						if (!obj.succ) {
							layer.alert(obj.msg, {"title" : "提示消息"});
							return;
						}
						
						var html = [];
						for (var i in obj.data) {
							html.push("<option value=\""+obj.data[i].id+"\">"+obj.data[i].text+"</option>");
						}
						
						var dbListOjb = $("[lay-filter='dbList']");
						dbListOjb.empty();
						dbListOjb.html(html.join(""));
						
						layui.form.render(null, "from");
					}
				});
			});
		}
		
		// 初始化数据库表
		function initDbTableList(params) {
			$.ajax({
				url : "home/dbTableList",
				data : params,
				success : function(obj) {
					
					if (!obj.succ) {
						layer.alert(obj.msg, {"title" : "提示消息"});
						return;
					}
					
					var html = [];
					for (var i in obj.data) {
						html.push("<option value=\""+obj.data[i].id+"\">"+obj.data[i].text+"</option>");
					}
										
					var dbListOjb = $("[lay-filter='dbTableList']");
					dbListOjb.empty();
					dbListOjb.html(html.join(""));
					
					layui.form.render(null, "from");
				}
			});
		}
		
		// 初始化实体名称
		function initDbTableEntity(params) {
			$.ajax({
				url : "home/dbTableEntity",
				data : params,
				success : function(obj) {
					
					if (!obj.succ) {
						layer.alert(obj.msg, {"title" : "提示消息"});
						return;
					}
					
					$("#four").val(obj.data);
					
					layui.form.render(null, "from");
				}
			});
		}
		
		// 生成表单
		function createFrom(){
			layui.form.on("submit(createFrom)", function(data) {
				$.ajax({
					url : "home/createFrom",
					data : {"dbAddr" : $("input[name='dbAddr']").val(), 
							"dbUserName" : $("input[name='dbUserName']").val(), 
					   		"dbPwd" : $("input[name='dbPwd']").val(),
					   		"dbName" : $("select[name='instanceName']").val(),
							"dbTableName" : $("select[name='tableName']").val()},
					success : function(obj) {

						if (!obj.succ) {
							layer.alert(obj.msg, {"title" : "提示消息"});
							return;
						}

						var html = [];
						
						var dbEntityList = $("[lay-filter='dbEntityList']");
						dbEntityList.empty();
						html.push("<thead>");
						html.push("<tr>");
						html.push("<th>字段</th>");
							html.push("<th>名称</th>");
							html.push("<th>类型</th>");
							html.push("<th>页面展示</th>");
							html.push("<th>必填项</th>");
							html.push("<th>查询条件</th>");
							html.push("<th>排序</th>");
							html.push("</tr>");
						html.push("<tbody>");
						for (var i in obj.data) {
							html.push("<tr>");
							html.push("<td>");
							html.push(obj.data[i].code);
							html.push("<input type='hidden' name='"+obj.data[i].code+"_code' value='"+obj.data[i].code+"'>");
							html.push("</td>");
							html.push("<td>");
							html.push("<input type='text'  style='border-style:none' name='"+obj.data[i].code+"_name' placeholder='请输入名称' class='layui-input' value='"+obj.data[i].name+"'>");
							html.push("</td>");
							html.push("<td>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='1' title='输入' checked>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='2' title='选择'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='3' title='单选'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='4' title='多选'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='5' title='文本域'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='6' title='时间'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_type' value='7' title='数据字典'>");
							html.push("</td>");
							html.push("<td>");
							html.push("<input type='checkbox' name='"+obj.data[i].code+"_web' lay-skin='switch' lay-filter='web' value='1' lay-text='开启|关闭'  checked>");
							html.push("</td>");
							html.push("<td>");
							html.push("<input type='checkbox' name='"+obj.data[i].code+"_required' lay-skin='switch' lay-filter='required' value='1' lay-text='开启|关闭'  checked>");
							html.push("</td>");
							html.push("<td>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_search' value='0' title='关闭' checked>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_search' value='1' title='等于' >");
							html.push("<input type='radio' name='"+obj.data[i].code+"_search' value='2' title='模糊' >");
							html.push("</td>");
							html.push("<td>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_sort' value='0' title='关闭' checked='checked'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_sort' value='1' title='倒序'>");
							html.push("<input type='radio' name='"+obj.data[i].code+"_sort' value='2' title='正序'>");
							html.push("</td>");
							html.push("</tr>");
						}
						html.push("</tbody>");
						
						var dbEntityList = $("[lay-filter='dbEntityList']");
						dbEntityList.append(html.join(""));
						layui.form.render(null, "dbEntityList");
					}
				});
			});
		}
		
		// 生成文件
		function createFile() {
			layui.form.on("submit(createFile)", function(data) {
				var specs = [];
				$("[lay-filter='dbEntityList'] tbody tr").each(function (index, domEle) {
					var spec = {};
				 		$(domEle).find("td").each(function (index1, domEle1) {
				 			$(domEle1).find("input").each(function (index1, domEle2) {
								var field = $(domEle2).attr("name");								
								var fieldNameSize = field.split("_");
								var fieldName = fieldNameSize[fieldNameSize.length - 1]

								var value = $(domEle2).val();
								var type = $(domEle2).attr("type");
								if(type == "hidden" || type == "text"){
									spec[fieldName] = $(this).val();
								}
								if(type == "radio" ){
									$("input[name='"+field+"']:checked").each(function(){
										spec[fieldName] = $(this).val();
									}); 
								}
								if(type == "checkbox" ){
									spec[fieldName] = 0;
									$("input[name='"+field+"']:checked").each(function(){
										spec[fieldName] = $(this).val();
									});
								}
							});
						});
				specs.push(spec);
				});
			 	data.field.searchJson = JSON.stringify(specs);
				data.field.realmName = $("input[name='two']").val();
				data.field.projectName = $("input[name='three']").val();
				data.field.author = $("input[name='five']").val();
				data.field.templateName = $("select[name='templateLib']").val();
				
					$.ajax({
						url : "home/createFile",
						data : data.field,
						async: false,
						success : function(obj) {
							console.log(obj.path);
							window.location.href = '/home/downLoad?path='+obj.path;
							
							layui.form.render(null, "from");
						}
					});
					/* window.location.href = '/createFile?dbAddr=' + $("input[name='dbAddr']").val()
					+ "&dbUserName=" + $("input[name='dbUserName']").val() 
				   	+ "&dbPwd=" + $("input[name='dbPwd']").val()
				   	+ "&instanceName=" + $("select[name='instanceName']").val()
		   			+ "&tableName=" + $("select[name='tableName']").val()
		   			+ "&realmName=" + $("input[name='two']").val()
		   			+ "&projectName=" + $("input[name='three']").val()
				   	+ "&author=" + $("input[name='five']").val()
		   			+ "&entityName=" + $("select[name='tableName']").val()
		   			+ "&searchJson=" + JSON.stringify(specs); */
			});
		}
		
		
        //监听开关事件
        layui.form.on('switch(web)', function (data) {
        	console.log(data);
            var contexts;
            var sta;
            var x = data.elem.checked;//判断开关状态
            if (x==true) {
            	console.log("开");
            } else {
            	console.log("关");
            }
        });
       layui.form.on('switch(required)', function (data) {
        	console.log(data);
            var contexts;
            var sta;
            var x = data.elem.checked;//判断开关状态
            if (x==true) {
            	 
            }
        });
	</script>
</html>
