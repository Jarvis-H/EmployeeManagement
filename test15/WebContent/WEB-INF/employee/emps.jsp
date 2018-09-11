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

#emp td {
	width: 200px;
}

#emp input {
	width: 100px;
}

#emp select {
	width: 100px;
	height: 28px
}
#emp .select{
background:#337ab7;
}


#prev,#next,#shu,#first,#last{
	user-select: none;
	cursor: pointer;
}
#imgId{
	width: 250px;
	height: 40px;
}
#bigPic{
	display:none;
	position:absolute;
	width:100px;
}
#bigPic img{
	width:100px;
	height: 100px;
}
</style>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var selectId = -1;

		$("#showAdd").click(function() {
			window.location.href = "emp?type=showAdd";
		});
		$("#showAdd2").click(function() {
			window.location.href = "emp?type=showAdd2";
		});
		$("#showUpdate").click(function() {
			if (selectId > -1) {
				alert(selectId);
				window.location.href = "emp?type=showUpdate&id=" + selectId;
			} else {
				alert("请选中一行");
			}
		});

		$("#delete").click(function() {
			if (selectId > -1) {
				window.location.href = "emp?type=delete&id=" + selectId;
			} else {
				alert("请选中一条数据");
			}
		});
		function doBatch(type) {
			var length = $("#emp .select").length;
			var ids = new Array();
			if (length > 0) {
				$("#emp .select").each(function(index, element) {
					ids.push($(this).data("id"));
				})
				
				window.location.href = "emp?type="+type+"&ids=" + ids;
			} else {
				alert("请选中数据");
			}
		}
		$("#deleteBatch").click(function() {
			doBatch("deleteBatch");

		});
		$("#showUpdateBatch1").click(function() {
			doBatch("showUpdateBatch1");

		});
		$("#showUpdateBatch2").click(function() {
			doBatch("showUpdateBatch2");
		});

		$("#updateBatch3").click(function() {
			//var emps="";
			var array = new Array();
			$(".updateEmp").each(function(index,element){
				var id = $(this).data("id");
				var name = $(this).find("[name=name]").val();
				var sex = $(this).find("[name=sex]").val();
				var age = $(this).find("[name=age]").val();
				//emps += id + "," + name + "," + sex + "," + age + ";";
				var emp={
						id:id,
						name:name,
						sex:sex,
						age:age
						
				}
				array.push(emp);
			})
			//emps = emps.substring(0,emps.length-1);
			var str=JSON.stringify(array);
			str=str.replace(/{/g,"%7b");
			str=str.replace(/}/g,"%7d");
			window.location.href = "emp?type=updateBatch3&emps=" + str;
		});
		
		$("tbody tr").click(function() {
			$(this).toggleClass("select");
			selectId = $(this).data("id");
		});
		
		$("tbody tr").dblclick(function() {
			$(this).unbind("dblclick");
			$(this).unbind("click");
			$(this).addClass("updateEmp");
			var name = $(this).children().eq(0).text();
			$(this).children().eq(0).html("<input type='text' name='name' value='"+name+"'/>");
		
			var sex = $(this).children().eq(1).text();
			if (sex=="男") {
				var select="<select name='sex'><option selected value='男'>男</option><option value='女'>女</option><select/>";
			}else{
				var select="<select name='sex'><option value='男'>男</option><option selected value='女'>女</option><select/>";
			}
			$(this).children().eq(1).html(select);
			
			var age = $(this).children().eq(2).text();
			$(this).children().eq(2).html("<input type='text' name='age' value='"+age+"'/>");
		

		})
		
		$("ul #shu").click(function() {
			var index = $(this).index();
			var curPage = $("ul li").eq(index).text();
			window.location.href = "emp?curPage="+ curPage;
		})

		if(${p.curPage} <= 1){
			$("#prev").addClass("disabled");
			$("#prev").find("a").attr("onClick","return false");
		}
		if(${p.curPage} >= ${p.pageNum}){
			$("#next").addClass("disabled");
			$("#next").find("a").attr("onClick","return false");
		}
		
		$("#emp img").hover(function(event) {
			var photo = $(this).attr("src");
			$("#bigPic img").attr("src",photo);
			$("#bigPic").show();
			$("#bigPic").css({left:event.pageX+10,top:event.pageY+10});
		},function(){
			$("#bigPic").hide();
		})
		

	
});
</script>
</head>
<body>


	<form action="emp" method="post" class="form-horizontal" role="form"
		id="main">
		
		
		<input type="hidden" name="type" value="search" />
		<div class="form-group">
			<div class="col-sm-2">
				<input type="text" class="form-control" name="name"
					placeholder="请输入姓名" value=${c.name }>
			</div>
			<div class="col-sm-2">
				<select name="sex" class="form-control">
					<option value="">请选择性别</option>
					<option value="男" <c:if test="${c.sex == '男' }">selected</c:if> >男</option>
					<option value="女" <c:if test="${c.sex == '女' }">selected</c:if>>女</option>
				</select>
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="lastname" name="age"
					placeholder="请输入年龄" value=${c.age!=-1?c.age:'' }>
			</div>
			<div class="col-sm-2">
				<select name="depID" class="form-control">
					<option value="">请选择部门</option>
					<c:forEach items="${depList }" var="dep">
						<option value="${dep.id }" <c:if test="${c.dep.id==dep.id }">selected</c:if>>${dep.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-sm-2">
				<button type="submit" class="btn btn-primary">搜索</button>
			</div>

		</div>

	</form>


	<div id="main">
			<table id="emp" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>姓名</th>
					<th>性别</th>
					<th>年龄</th>
					<th>部门</th>
					<th>头像</th>
				</tr>
			</thead>
			<c:forEach items="${list }" var="emp">
				<tbody>
					<tr data-id="${emp.id }">
						<td id="tdID">${emp.name }</td>
						<td id="tdID">${emp.sex }</td>
						<td id="tdID">${emp.age }</td>
						<td id="tdID">${emp.dep.name }</td>
						<td id="tdID"><c:if test="${not empty emp.pic}"><img id="imgId" src="pic/${emp.pic}"/></c:if></td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div>
		<ul class="pagination">
			<li id="first"><a href="emp?type=search&curPage=1" >首页</a></li>
			<li id="prev"><a href="emp?type=search&curPage=${p.curPage-1 }&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depID=${c.dep.id }" >上一页</a></li>
			<c:forEach begin="${p.start }" end="${p.end }" varStatus="status">
				<li id="shu" <c:if test="${p.curPage==status.index }"> class="active"</c:if>>
				<a href="emp?type=search&curPage=${status.index}&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depID=${c.dep.id }">${status.index }</a></li>
			</c:forEach>
			<li id="next"><a href="emp?type=search&curPage=${p.curPage+1 }&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depID=${c.dep.id }">下一页</a></li>
			<li id="last"><a href="emp?type=search&curPage=${p.pageNum }">尾页</a></li>
		</ul>
		</div>
		<button type="button" id="showAdd" class="btn btn-primary">增加</button>
		<button type="button" id="showAdd2" class="btn btn-primary">增加2</button>
		<button type="button" id="showUpdate" class="btn btn-primary">修改</button>
		<button type="button" id="showUpdateBatch1" class="btn btn-primary">批量修改1</button>
		<button type="button" id="showUpdateBatch2" class="btn btn-primary">批量修改2</button>
		<button type="button" id="updateBatch3" class="btn btn-primary">批量修改3</button>
		<button type="button" id="delete" class="btn btn-primary">删除</button>
		<button type="button" id="deleteBatch" class="btn btn-primary">批量删除</button>
	</div>
	<div id="bigPic"><img src=""/></div>
</body>
</html>