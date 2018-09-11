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

#sc td {
	width: 200px;
}

#sc input {
	width: 100px;
}

#sc select {
	width: 100px;
	height: 28px
}

#sc .select {
	background: #337ab7;
}

#prev, #next, #shu {
	user-select: none;
	cursor: pointer;
}
</style>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var selectId = -1;

		$("tbody tr").click(function() {
			$(this).toggleClass("select");
			selectId = $(this).data("id");
			
		});
		
		
		$("tbody tr").dblclick(function() {
			//$(this).focus();
			//$(this).unbind("dblclick");
			$(this).unbind("click");
			$(this).addClass("updateEmp");
			var value = $(this).children().eq(4).text();
			$(this).children().eq(4).html("<input id='inputId' type='text' name='value' value='"+value+"'/>");
		
			
			$("#inputId").blur(function() {
				var array = new Array();

				
				$(".updateEmp").each(function(index,element) {
					var id = $(this).data("id");
					var value=$(this).find("[name=value]").val();
					if(id!=0)
					
					var sc={
							id:id,
							value:value
					}
					array.push(sc); 
				})
				var str=JSON.stringify(array);
				str=str.replace(/{/g,"%7b");
				str=str.replace(/}/g,"%7d");
				//alert(str);
				window.location.href = "sc?type=updateBatch&scs=" + str;
			})

		})
		

		

		
		
		$("ul #shu").click(function() {
			var index = $(this).index();
			var curPage = $("ul li").eq(index).text();
			window.location.href = "sc?curPage="+ curPage;
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


	<form action="sc" method="post" class="form-horizontal" role="form"
		id="main">
		<input type="hidden" name="type" value="search" />
		<div class="form-group">
			<div class="col-sm-2">
				<input type="text" class="form-control" name="id" placeholder="ID"
					value=${c.emp.id!=-1?c.emp.id:''}>
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" name="name" placeholder="姓名"
					value=${c.emp.name }>
			</div>
			<div class="col-sm-2">
				<select name="dId" class="form-control">
					<option value="">部门</option>
					<c:forEach items="${depList }" var="dep">
						<option value="${dep.id }">${dep.name }</option>
					</c:forEach>
				</select>
			</div>

			<div class="col-sm-2">
				<select name="pId" class="form-control">
					<option value="">项目</option>
					<c:forEach items="${proList }" var="pro">
						<option value="${pro.id }">${pro.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" name="value"
					placeholder="成绩" value=${c.value!=-1?c.value:'' }>
			</div>

			<div class="col-sm-2">
				<button type="submit" class="btn btn-primary">搜索</button>
			</div>

		</div>

	</form>



	<div id="main">
		<table id="sc" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>姓名</th>
					<th>部门</th>
					<th>项目</th>
					<th>成绩</th>
					<th>等级</th>
				</tr>
			</thead>
			<c:forEach items="${list }" var="sc">
				<tbody>
					<tr data-id="${sc.id }">
						<td>${sc.emp.id }</td>
						<td>${sc.emp.name }</td>
						<td>${sc.emp.dep.name }</td>
						<td>${sc.pro.name }</td>
						<td>${sc.value }</td>
						<td>${sc.grade.value }</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div>
			<ul class="pagination">
				<li id="prev"><a href="sc?curPage=1">首页</a></li>
				<li id="prev"><a
					href="sc?type=search&curPage=${p.curPage-1 }&id=${c.emp.id!=-1?c.emp.id:'' }&name=${c.emp.name}&dId=${c.emp.dep.id!=-1?c.emp.dep.id:'' }&pId=${c.pro.id!=-1?c.pro.id:''}&value=${c.value!=-1?c.value:'' }">上一页</a></li>
				<c:forEach begin="${p.start }" end="${p.end }" varStatus="status">
					<li id="shu"
						<c:if test="${p.curPage==status.index }"> class="active"</c:if>>
						<a
						href="sc?type=search&curPage=${status.index}&id=${c.emp.id!=-1?c.emp.id:'' }&name=${c.emp.name}&dId=${c.emp.dep.id!=-1?c.emp.dep.id:''}&pId=${c.pro.id!=-1?c.pro.id:''}&value=${c.value!=-1?c.value:'' }">${status.index }</a>
					</li>
				</c:forEach>
				<li id="next"><a
					href="sc?type=search&curPage=${p.curPage+1 }&id=${c.emp.id!=-1?c.emp.id:'' }&name=${c.emp.name}&dId=${c.emp.dep.id!=-1?c.emp.dep.id:''}&pId=${c.pro.id!=-1?c.pro.id:''}&value=${c.value!=-1?c.value:'' }">下一页</a></li>
				<li id="prev"><a href="sc?curPage=${p.pageNum }">尾页</a></li>
			</ul>
		</div>
		

	</div>
</body>
</html>