<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="bean.Employee"%>
<!DOCTYPE>
<html>
<head>
<style type="text/css">
#main {
	width: 400px;
	text-align: center;
	margin: 20px auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<%
		Employee emp = (Employee) request.getAttribute("emp");
		String ids = (String) request.getAttribute("ids");
	%>
	<form action="emp" method="post" class="form-horizontal" role="form"
		id="main">
		<input type="hidden" name="type" value="updateBatch1" /> <input
			type="hidden" name="ids" value="<%=ids%>" />
		<div class="form-group">
			<label for="firstname" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="name"
					value="<%=emp.getName()%>">
			</div>
		</div>
		<div class="form-group">
			<label for="lastname" class="col-sm-2 control-label">性别</label>
			<div class="col-sm-10">
				<input type="radio" name="sex" value="男"
					<%if (emp.getSex().equals("男")) {%> checked <%}%>>男 <input
					type="radio" name="sex" value="女"
					<%if (emp.getSex().equals("女")) {%> checked <%}%>>女
			</div>
		</div>

		<div class="form-group">
			<label for="lastname" class="col-sm-2 control-label">年龄</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="lastname" name="age"
					value="<%=emp.getAge()%>">
			</div>
		</div>


		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-primary">保存</button>
			</div>
		</div>
	</form>
</body>
</html>