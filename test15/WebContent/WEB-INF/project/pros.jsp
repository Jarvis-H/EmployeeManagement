<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#main {
	width: 600px;
	text-align: center;
	margin: 20px auto;
}

#pro td {
	width: 200px;
}

#pro input {
	width: 100px;
}

#pro select {
	width: 100px;
	height: 28px
}
#pro .select{
background:#337ab7;
}


#prev,#next,#shu{
	user-select: none;
	cursor: pointer;
}
</style>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var selectId = -1;

		$("#showAdd").click(function() {
			window.location.href = "pro?type=showAddPro";
		});
		$("#showUpdate").click(function() {
			if (selectId > -1) {
				window.location.href = "pro?type=showUpdatePro&id=" + selectId;
			} else {
				alert("请选中一行");
			}
		});

		$("#delete").click(function() {
			if (selectId > -1) {
				window.location.href = "pro?type=deletePro&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});
		function doBatch(type) {
			var length = $("#pro .select").length;
			var ids = new Array();
			if (length > 0) {
				$("#pro .select").each(function(index, element) {
					ids.push($(this).data("id"));
				})
				
				window.location.href = "pro?type="+type+"&ids=" + ids;
			} else {
				alert("请选中数据");
			}
		}

		
		$("tbody tr").click(function() {
			$(this).toggleClass("select");
			selectId = $(this).data("id");
		});
		
		
		$("ul #shu").click(function() {
			var index = $(this).index();
			var curPage = $("ul li").eq(index).text();
			window.location.href = "pro?curPage="+ curPage;
		})

		if(${p.curPage} <= 1){
			$("#prev").addClass("disabled");
			$("#prev").find("a").attr("onClick","return false");
		}
		if(${p.curPage} >= ${p.pageNum}){
			$("#next").addClass("disabled");
			$("#next").find("a").attr("onClick","return false");
		}
	 
});
</script>
</head>
<body>


	<form action="pro" method="post" class="form-horizontal" role="form"
		id="main">
		<input type="hidden" name="type" value="search" />
		<div class="form-group">
			<div class="col-sm-4">
				<input type="text" class="form-control" name="name"
					placeholder="请输入姓名" value=${c.name }>
			</div>

			<div class="col-sm-4">
				<button type="submit" class="btn btn-primary">搜索</button>
			</div>
		</div>

	</form>


	<div id="main">
			<table id="pro" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>名称</th>
					
				</tr>
			</thead>
			<c:forEach items="${list }" var="pro">
				<tbody>
					<tr data-id="${pro.id }">
						<td id="tdID">${pro.id }</td>
						<td id="tdID">${pro.name }</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div>
		<ul class="pagination">
			<li id="prev"><a href="pro?type=search&curPage=${p.curPage-1 }&name=${c.name}" >上一页</a></li>
			<c:forEach begin="${p.start }" end="${p.end }" varStatus="status">
				<li id="shu" <c:if test="${p.curPage==status.index }"> class="active"</c:if>>
				<a href="pro?curPage=${status.index}&name=${c.name}">${status.index }</a></li>
			</c:forEach>
			<li id="next"><a href="pro?type=search&curPage=${p.curPage+1 }&name=${c.name}">下一页</a></li>
		</ul>
		</div>
		<button type="button" id="showAdd" class="btn btn-primary">增加</button>
		<button type="button" id="showUpdate" class="btn btn-primary">修改</button>
		<button type="button" id="delete" class="btn btn-primary">删除</button>

	</div>
</body>
</html>