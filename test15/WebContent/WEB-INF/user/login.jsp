<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<style type="text/css">
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

	if(self!=top){
		top.location="user?type=showLogin";
	}
	$().ready(function() {
		$("#image").click(function() {
			$(this).attr("src","user?type=randomImage&"+Math.random());
		})
	})
</script>
</head>
<body>


	<div
		style="width: 600px; margin: 20px auto; margin-top: 120px; text-align: center;">
		<form action="user" method="post" class="form-horizontal">
			<h1>欢迎登陆</h1>
			<input type="hidden" name="type" value="doLogin" />
			<div class="form-group" id="main">
				<div>
					<label>账号</label> <input type="text" name="username"
						placeholder="请输入账号" value="${name }" />
				</div>

				<div>
					<label>密码</label> <input type="password" name="password"
						placeholder="请输入密码" />
				</div>
				<div>
					<label>验证</label> <input type="text" name="random"
						placeholder="请输入验证码" />
					<div><img id="image" src="user?type=randomImage"/></div>
					<div id="mes" style="height: 40px;">${mes }</div>
				</div>
			</div>
			<input type="submit" value="登陆" />
		</form>
	</div>
</body>
</html>