<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

	<form action="pro" method="post" class="form-horizontal" role="form" id="main">
		<input type="hidden" name="type" value="updatePro" />
		<input type="hidden" name="id" value="${pro.id }" />
		<div class="form-group">
			<label for="firstname" class="col-sm-2 control-label">名称</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="name"
					value="${pro.name }">
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