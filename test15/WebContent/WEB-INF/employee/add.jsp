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
	<form action="emp?type=add" method="post" class="form-horizontal" role="form"
		id="main"  enctype="multipart/form-data">
		<div class="form-group">
			<label for="firstname" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="name"
					placeholder="请输入姓名">
			</div>
		</div>
		<div class="form-group">
			<label for="lastname" class="col-sm-2 control-label">性别</label>
			<div class="col-sm-10">
				<input type="radio" name="sex" value="男" checked>男 <input
					type="radio" name="sex" value="女">女
			</div>
		</div>

		<div class="form-group">
			<label for="lastname" class="col-sm-2 control-label">年龄</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="lastname" name="age"
					placeholder="请输入年龄">
			</div>
		</div>

		<div class="form-group">
			<label for="lastname" class="col-sm-2 control-label">名称</label>
			<div class="col-sm-10">
				<select name="depID" class="form-control">
					<option value="">请选择部门</option>
					<c:forEach items="${depList }" var="dep">
						<option value="${dep.id }">${dep.name }</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<input type="file" value="选择文件" name="myfile" />

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-primary">保存</button>
			</div>
		</div>
	</form>
</body>
</html>