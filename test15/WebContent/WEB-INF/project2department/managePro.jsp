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
#depNAME{
	text-align: center;
}
#selectID{
	height: 30px;
}
#formID{
	width: 300px;
	float: left;
	margin-left: 80px;
	
}
#showAdd{
	margin-left: 20px;
}
#delete{
	margin-right: 150px;
}
</style>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var selectId = -1;

		$("#showAdd").click(function() {

			var proId=$("#selectID").val();
			window.location.href ="pro2dep?type=addPro&depId=${depId}&proId="+proId;
		})
			
		<c:if test="${f:length(proNotdeplist) == 0}">
			$("#showAdd").unbind("click");
			$("#showAdd").addClass("disabled");
		</c:if>
		$("#delete").click(function() {
			if (selectId > -1) {
				window.location.href = "pro2dep?type=deletePro2Dep&proId=" + selectId + "&depId="+${depId };
			} else {
				alert("请选中一条数据");
			}
		});

		
		$("tr").click(function() {
			$(this).toggleClass("select");
			selectId = $(this).data("id");
		});
});
</script>
</head>
<body>

	<div id="depNAME">
		<h1>${headName}</h1>
	</div>
	<div id="main">
			<table id="pro" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>名称</th>
					
				</tr>
			</thead>
			<c:forEach items="${pro2deplist }" var="pro2dep">
				<tbody>
					<tr data-id="${pro2dep.id }">
						<td id="tdID">${pro2dep.id }</td>
						<td id="tdID">${pro2dep.name }</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		

		
				<select  name="proId" id="selectID" >
					<c:forEach items="${proNotdeplist }" var="proN">
						<option value="${proN.id }">${proN.name }</option>
					</c:forEach>
				</select>



		
		<button type="button" id="showAdd" class="btn btn-primary">增加</button>
		<button type="button" id="delete" class="btn btn-primary">删除</button>

	</div>
</body>
</html>