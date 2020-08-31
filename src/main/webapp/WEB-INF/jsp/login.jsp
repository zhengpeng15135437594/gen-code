<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>登录</title>
		<script type="text/javascript">
			if (top != self) {
			    top.location = self.location;
			}
		</script>
		<%@include file="/script/myJs/common.jspf"%>
		<link rel="stylesheet" href="script/layuiadmin/style/login.css" media="all">
	</head>
	<body>
		<div class="layadmin-user-login layadmin-user-display-show">
			<div class="layadmin-user-login-main">
				<div class="layadmin-user-login-box layadmin-user-login-header">
					<h2>login</h2>
					<p>登录</p>
				</div>
				<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
					<form class="layui-form" action="home/doLogin" method="post">
						<div class="layui-form-item">
							<label class="layadmin-user-login-icon layui-icon layui-icon-username" for="loginName"></label>
							<input type="text" name="loginName" lay-verify="required" placeholder="在此输入用户名" class="layui-input">
						</div>
						<div class="layui-form-item">
							<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="pwd"></label>
							<input type="password" name="password" id="password" lay-verify="required" placeholder="在此输入密码" class="layui-input">
						</div>
						<div class="layui-form-item">
							<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">登 入</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="script/layuiadmin/layui/layui.all.js"></script>
	<script>
	/* layui.use('form', function(){
		  var form = layui.form;
			//提交
		    form.on('submit(LAY-user-login-submit)', function(obj){
		      //请求登入接口
		      $.ajax({
		        url: "home/doLogin" //实际使用请改成服务端真实接口
		        ,data: obj.field
		        ,success: function(res){
			          if(res.data == 'ok'){
			          //登入成功的提示与跳转
			          layer.msg('登入成功', {
			            offset: '15px'
			            ,icon: 1
			            ,time: 1000
			          }, function(){
			            location.href = '../home/index'; //后台主页
			          });
			        }
			          if(res.data == 'error'){
				          //登入成功的提示与跳转
				          layer.msg('登录名或密码错误', {
				            offset: '15px'
				            ,icon: 1
				            ,time: 1000
				          }, function(){
				            location.href = '../home/login'; //登录页
				          });
				    }
		        }
		      });
		    });
		}); */
	</script>
</html>