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

#dep td {
	width: 200px;
}

#dep input {
	width: 100px;
}

#dep select {
	width: 100px;
	height: 28px
}

#dep .select {
	background: #337ab7;
}

#prev, #next, #shu {
	user-select: none;
	cursor: pointer;
}

#Rright {
	width: 500px;
	height: 600px;
}
</style>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
		var selectId = -1;

		$("#showAdd").click(function() {
			window.location.href = "dep?type=showAddDep";
		});
		$("#showUpdate").click(function() {
			if (selectId > -1) {
				window.location.href = "dep?type=showUpdateDep&id=" + selectId;
			} else {
				alert("请选中一行");
			}
		});

		$("#delete").click(function() {
			if (selectId > -1) {
				window.location.href = "dep?type=deleteDep&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});
		$("#manage").click(function() {
			if (selectId > -1) {
				window.location.href = "pro2dep?type=showManagePro&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});

		$("#manage2").click(function() {
			if (selectId > -1) {
				window.location.href = "pro2dep?type=m2&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});
		$("#manage3").click(function() {
			if (selectId > -1) {
				window.location.href = "pro2dep?type=m3&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});
		$("#manage4").click(function() {
			if (selectId > -1) {
				window.location.href = "pro2dep?type=m4&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});
		$("#btn5").click(function() {
				if(selectId>-1){

					$(this).attr("data-toggle","modal");
					$(this).attr("data-target","#myModal");
					$("#Rright").attr("src","pro2dep?type=m5&id="+selectId);
				}else{
					alert("请选中一行");
				}
		});
		
		$("tbody tr").click(function() {
			
			$("tr").removeClass("select");
			$(this).toggleClass("select");
			selectId = $(this).data("id");
		});
		
		
		$("ul #shu").click(function() {
			var index = $(this).index();
			var curPage = $("ul li").eq(index).text();
			window.location.href = "dep?curPage="+ curPage;
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


	<form action="dep" method="post" class="form-horizontal" role="form"
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
		<table id="dep" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>名称</th>
					<th>人数</th>

				</tr>
			</thead>
			<c:forEach items="${list }" var="dep">
				<tbody>
					<tr data-id="${dep.id }">
						<td id="tdID">${dep.id }</td>
						<td id="tdID">${dep.name }</td>
						<td id="tdID"><a href="emp?type=search&depID=${dep.id }">${dep.empCount }</a></td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div>
			<ul class="pagination">
				<li id="prev"><a
					href="dep?type=search&curPage=${p.curPage-1 }&name=${c.name}">上一页</a></li>
				<c:forEach begin="${p.start }" end="${p.end }" varStatus="status">
					<li id="shu"
						<c:if test="${p.curPage==status.index }"> class="active"</c:if>>
						<a href="dep?curPage=${status.index}&name=${c.name}">${status.index }</a>
					</li>
				</c:forEach>
				<li id="next"><a
					href="dep?type=search&curPage=${p.curPage+1 }&name=${c.name}">下一页</a></li>
			</ul>
		</div>
		<button type="button" id="showAdd" class="btn btn-primary">增加</button>
		<button type="button" id="showUpdate" class="btn btn-primary">修改</button>
		<button type="button" id="delete" class="btn btn-primary">删除</button>
		<button type="button" id="manage" class="btn btn-primary">管理项目</button>
		<button type="button" id="manage2" class="btn btn-primary">管理项目2</button>
		<button type="button" id="manage3" class="btn btn-primary">管理项目3</button>
		<button type="button" id="manage4" class="btn btn-primary">管理项目4</button>

		<button id="btn5" class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#myModal">项目管理5</button>



		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel"></h4>
					</div>
					<div class="modal-body">
						<iframe id="Rright" name="Rright" scrolling="no" frameborder="0"
							> </iframe>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
</body>

</div>
</body>
</html>