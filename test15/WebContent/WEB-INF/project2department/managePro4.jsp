<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>

<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>拖动+排序</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}

#main {
	width: 600px;
	margin: 20px auto;
}

ul {
	width: 600px;
	height: 200px;
	border: 5px solid #337ab7;;
	margin-bottom: 30px;
	padding: 20px;
}

li {
	list-style: none;
	background: #337ab7;
	height: 40px;
	line-height: 40px;
	float: left;
	margin-left: 5px;
	color: #fff;
	padding: 0 20px;
	margin-top: 10px;
	border-radius: 3px;
}
</style>
<script>
	$(function() {

		var noProLeft=$("#noPro").offset().left;
		var noProTop=$("#noPro").offset().top;
		var noProWidth=parseFloat($("#noPro").css("width"));
		var noProHeight=parseFloat($("#noPro").css("height"));
		var startLeft;
		var startTop;
		$(".pro").draggable({

			start : function() {
				startLeft=$(this).offset().left;
				startTop=$(this).offset().top;
			},
			stop : function() {

				var stopLeft=$(this).offset().left;
				var stopTop=$(this).offset().top;
				if (stopLeft>=noProLeft&&stopLeft<=noProLeft+noProWidth&&stopTop>=noProTop&&stopTop<=noProTop+noProWidth) {
					var pro=$(this);
					var proId = $(this).data("id");
					$.ajax({
						url : "pro2dep",
						type : "post",
						data : {
							type : "deletePro2Dep2",
							depId : "${depId}",
							proId : proId
						},
						dataType : "text",
						success : function(data) {
							if(data=="true"){
								pro.css("position","static");
								$("#noPro").append(pro);
								pro.css("position","relative");
								pro.css("left","0");
								pro.css("top","0");
							}
						}
					})
					
					
				}else{

					$(this).offset({left:startLeft,top:startTop})
				}
				
			}
		})
		
		
		var proLeft=$("#pro").offset().left;
		var proTop=$("#pro").offset().top;
		var proWidth=parseFloat($("#pro").css("width"));
		var proHeight=parseFloat($("#pro").css("height"));
		$(".noPro").draggable({

			start : function() {
				startLeft=$(this).offset().left;
				startTop=$(this).offset().top;
			},
			stop : function() {

				var stopLeft=$(this).offset().left;
				var stopTop=$(this).offset().top;
				if (stopLeft>=proLeft&&stopLeft<=proLeft+proWidth&&stopTop>=proTop&&stopTop<=proTop+proWidth) {
					var pro=$(this);
					var proId = $(this).data("id");
					$.ajax({
						url : "pro2dep",
						type : "post",
						data : {
							type : "addPro2",
							depId : "${depId}",
							proId : proId
						},
						dataType : "text",
						success : function(data) {
							if(data=="true"){
								pro.css("position","static");
								$("#pro").append(pro);
								pro.css("position","relative");
								pro.css("left","0");
								pro.css("top","0");
							}
						}
					})
					
					
				}else{

					$(this).offset({left:startLeft,top:startTop})
				}
				
			}
		});
		
		
		$("ul, li").disableSelection();
	});
</script>
</head>

<body>
	<div id="main">
		<h1>${headName}</h1>
		<ul id="pro">
			<c:forEach items="${pro2deplist }" var="pro">
				<li class="pro" data-id="${pro.id }">${pro.name}</li>
			</c:forEach>
		</ul>

		<ul id="noPro">
			<c:forEach items="${proNotdeplist }" var="pro">
				<li class="noPro" data-id="${pro.id }">${pro.name}</li>
			</c:forEach>
		</ul>
	</div>
</body>

</html>