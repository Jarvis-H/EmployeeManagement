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
#pictures img{
 	width: 100px;
 	height: 100px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#upload").click(function(){
			var formData=new FormData();
			for(var i=0;i<$("[name=myfile]")[0].files.length;i++){
				
				formData.append("myfile",$("[name=myfile]")[0].files[i]);

			}
			$.ajax({
			
				url:"emp?type=upload",
				type:"post",
				cache:false,
				processData:false,
				contentType:false,
				data:formData,
				datatype:"text",
				success:function(data){
				
					var str="<img src='pic/"+data+"'/>";
					str+="<input type='hidden' name='photo' value='"+data+"'/>";
					$("#pictures").append(str);
					
				}
			})
		})
		$(document).on("click","#pictures img",function(){
			var path= $(this).next().val();

			$(this).next().remove();
			$(this).remove();
			$.ajax({
				url:"emp?type=deleteFile",
				type:"post",
				data:{path:path},
				datatype:"text",
				success:function(data){
					
				}
			})
		})
	})
</script>
</head>
<body>
	<form action="emp?type=add2" method="post" class="form-horizontal" role="form"
		id="main" >
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
		<div class="col-sm-8"><input type="file" value="选择文件" name="myfile" /></div>
		<div class="col-sm-3"><input type="button" id="upload" class="btn-primary form-control" value="上传" /></div>
		<div class="form-group" id="pictures">
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-primary">保存</button>
			</div>
		</div>
	</form>
</body>
</html>