<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	<form action="dep" method="post" class="form-horizontal" role="form"
		id="main">
		<input type="hidden" name="type" value="addDep" />
		<div class="form-group">
			<label for="firstname" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="name"
					placeholder="请输入姓名">
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