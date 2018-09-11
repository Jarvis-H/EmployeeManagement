<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#mes {
	color: red;
}
</style>
<script src="js/jquery.js"></script>
<script>
	$(document).ready(function() {
		function showMessage(mes) {
			$("#mes").html(mes);
			setTimeout(function() {
				$("#mes").html("")}, 1000)

		}

		$("form").submit(function() {

			var name = $("#username").val();
			if (name == "") {
				showMessage("账号不能为空");
				return false;
			}
			var pwd = $("#password").val();
			var pwd1 = $("#password1").val();
			if (pwd == "") {
				showMessage("密码不能为空");
				return false;
			}
			if (pwd == "") {
				showMessage("密码不能为空");
				return false;
			}
			if (pwd.length <= 6) {
				showMessage("密码长度大于6位");
				return false;
			}
			if (pwd1 == "") {
				showMessage("请再次输入密码");
				return false;
			}
			if (pwd == pwd1) {

			} else {
				showMessage("两次密码不相同");
				return false;
			}
		});
	});
</script>
</head>
<body>
	<div
		style="width: 600px; margin: 20px auto; margin-top: 120px; text-align: center;">
		<form action="user" method="post" class="form-horizontal">
			<h1>欢迎注册</h1>
			<input type="hidden" name="type" value="doRegister" />
			<div class="form-group" id="main">
				<div>
					<label>账号</label> <input type="text" id="username" name="username"
						placeholder="请输入账号" value="${name }" />
				</div>

				<div>
					<label>密码</label> <input type="password" id="password"
						name="password" placeholder="请输入密码" />
				</div>
				<div>
					<label>确认</label> <input type="password" id="password1"
						name="random" placeholder="请再次输入密码" />
				</div>
				<div id="mes" style="height: 40px;"></div>
			</div>
			<input type="submit" value="注册" />
		</form>
	</div>
</body>
</html>