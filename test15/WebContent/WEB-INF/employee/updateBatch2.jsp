<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="bean.Employee"%>
<!DOCTYPE>
<html>
<head>
<style type="text/css">
#main {
	width: 900px;
	text-align: center;
	margin: 20px auto;
}

.emp {
	width: 400px;
	float: left;
	margin: 10px 50px 10px 0;
	border: 1px dashed #ccc;
	padding: 20px 20px 20px 0;
}

#saveBtn {
	clear: both;
	text-align: center;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$().ready(function() {

		$("#save").click(function() {
			var emps = "";
			$(".emp").each(function(index, element) {
				var id = $(this).find("[name=id]").val();
				var name = $(this).find("[name=name]").val();
				var sex = $(this).find("[name=sex]:checked").val();
				var age = $(this).find("[name=age]").val();
				emps += id + "," + name + "," + sex + "," + age + ";";
			})
			emps = emps.substring(0, emps.length - 1);
			window.location.href = "emp?type=updateBatch2&emps="+emps;
		})

	})
</script>
</head>
<body>
	<%
		List<Employee> list = (List<Employee>) request.getAttribute("list");
	%>
	<div id="main">
		<%
			for (Employee emp : list) {
		%>
		<form action="emp" method="post" class="form-horizontal emp">

			<input type="hidden" name="type" value="updateBatch1" /> <input
				type="hidden" name="id" value="<%=emp.getId()%>" />
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
		</form>
		<%
			}
		%>
		<div id="saveBtn">
			<button id="save" type="button" class="btn btn-primary">保存</button>
		</div>
	</div>
</body>
</html>