<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#main {
	width: 600px;
	margin: 20px auto;
}

#pro, #noPro {
	width: 700px;
	height: 200px;
	border: 1px solid #337ab7;
	border-radius: 3px;
	
}

#btn {
	width: 240px;
	margin: 20px auto;
}

#add {
}

.pro {
	background: #337ab7;
	height: 40px;
	line-height: 40px;
	float:left;
	margin-left: 5px;
	color: #fff;
	padding: 0 20px;
	margin-top: 10px;
	border-radius: 3px;
}
.select{
	background: #d9534f;
}
</style>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".pro").click(function() {
			$(this).toggleClass("select");
		})
		$("#add").click(function() {
			if($("#noPro").find(".select").length>0){
				var proId=$("#noPro").find(".select").data("id");
				$.ajax({
					url:"pro2dep",
					type:"post",
					data:{type:"addPro2",depId:"${depId}",proId:proId},
					dataType:"text",
					success:function(data){
						if (data=="true") {
							
							var pro=$("#noPro").find(".select");
							pro.removeClass("select");
							$("#pro").append(pro);
						}
					}
				})
			}else {
				alert("请选择数据");
			}
		})
		
		$("#adds").click(function() {
			var proIds="";
			if($("#noPro").find(".select").length>0){
				
				$(".select").each(function(){
					  proIds +=$(this).data("id")+",";
					});
				
				$.ajax({
					url:"pro2dep",
					type:"post",
					data:{type:"addPros",depId:"${depId}",proIds:proIds},
					dataType:"text",
					success:function(data){
						if (data=="true") {
							
							var pro=$("#noPro").find(".select");
							pro.removeClass("select");
							$("#pro").append(pro);
						}
					}
				})
			}else {
				alert("请选择数据");
			}
		})
		

		
		$("#delete").click(function() {
			if($("#pro").find(".select").length>0){
				var proId=$("#pro").find(".select").data("id");
				$.ajax({
					url:"pro2dep",
					type:"post",
					data:{type:"deletePro2Dep2",depId:"${depId}",proId:proId},
					dataType:"text",
					success:function(data){
						if (data=="true") {
							
							var pro=$("#pro").find(".select");
							pro.removeClass("select");
							$("#noPro").append(pro);
						}
					}
				})
			}else {
				alert("请选择数据");
			}
		})
		
		$("#deletes").click(function() {

			var proIds="";
			if($("#pro").find(".select").length>0){
				$(".select").each(function(){
						proIds +=$(this).data("id")+",";
				});
				$.ajax({
					url:"pro2dep",
					type:"post",
					data:{type:"deletePro2Dep2s",depId:"${depId}",proIds:proIds},
					dataType:"text",
					success:function(data){
						if (data=="true") {
							
							var pro=$("#pro").find(".select");
							pro.removeClass("select");
							$("#noPro").append(pro);
						}
					}
				})
			}else {
				alert("请选择数据");
			}
		})
		
	});
</script>
</head>
<body>


	<div id="main">
		<h1>${headName}</h1>
		<div id="pro">
			<c:forEach items="${pro2deplist }" var="pro">
				<div class="pro" data-id="${pro.id }">${pro.name}</div>
			</c:forEach>

		</div>
		<div id="btn">
			<button id="add" type="button" class="btn btn-primary">↑</button>
			<button id="adds" type="button" class="btn btn-primary">↑↑</button>
			
			<button id="delete" type="button" class="btn btn-primary">↓</button>
			<button id="deletes" type="button" class="btn btn-primary">↓↓</button>
		</div>
		<div id="noPro">
			<c:forEach items="${proNotdeplist }" var="pro">
				<div class="pro" data-id="${pro.id }">${pro.name}</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>