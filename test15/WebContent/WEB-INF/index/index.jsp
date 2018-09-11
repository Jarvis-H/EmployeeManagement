<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

#main {
	height: 600px;
	overflow: hidden;
}

a {
	color: #fff;
	text-decoration: none;
}

#left {
	width: 400px;
	height: 600px;
	float: left;
	padding-left: 20px;

}

#right {
	width: 800px;
	height: 600px;
}

#top, #bottom {
	clear: both;
	height: 80px;
	background: #337ab7;
	height: 80px;
}

.yi {
	width: 160px;
	height: 40px;
	background: #337ab7;
	color: #fff;
	margin-top: 10px;
	border-radius: 3px;
	text-align: center;
	line-height: 40px;
}

.er {
	list-style: none;
	width: 160px;
	display: none;
}

.er li {
	margin-top: 5px;
	text-align: center;
	background: #337a97;
	color: #fff;
	height: 30px;
	line-height: 30px;
	font-size: 14px;
}

.er a {
	color: #000;
}
#count{
	float: right;
	color: #fff;
	line-height: 140px;
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
var websocket = null;

//判断当前浏览器是否支持WebSocket
if ('WebSocket' in window) {
	websocket = new WebSocket("ws://192.168.0.164:8080/test15/websocket");
} else {
	alert('没有建立websocket连接')
}

//连接发生错误的回调方法 
websocket.onerror = function() {
	//setMessage("错误");
};

//连接成功建立的回调方法
websocket.onopen = function(event) {
	//setMessage("建立连接");
}

//接收到消息的回调方法
websocket.onmessage = function(event) {
	$("#count").html(event.data);
}

//连接关闭的回调方法
websocket.onclose = function() {
	//setMessage("close");
}

//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口。
window.onbeforeunload = function() {
	websocket.close();
}



//关闭连接
function closeWebSocket() {
	websocket.close();
}



	$(document).ready(function() {
		$(".yi").click(function() {
			$(this).next().slideToggle(500);
		})
		
	})
</script>
</head>
<body>
	<div id="container">
		<div id="top">
			<div id="count">本网页共有<%=application.getAttribute("num") %>人访问</div>
			<%
			int num = 0;
			if (application.getAttribute("num") != null) {
				num = (Integer) application.getAttribute("num");
			}
			application.setAttribute("num",num);
			%>
			
		</div>
		<div id="main">
			<div id="left">
				<div class="yi">员工管理</div>
				<ul class="er">
					<li><a href="emp" target="right">员工管理</a></li>
					<li><a href="emp?type=showAdd" target="right">员工添加</a></li>
				</ul>
				<div class="yi">部门管理</div>
				<ul class="er">
					<li><a href="dep" target="right">部门管理</a></li>
					<li><a href="dep?type=showAddDep" target="right">部门添加</a></li>
				</ul>
				<div class="yi">项目管理</div>
				<ul class="er">
					<li><a href="pro" target="right">项目管理</a></li>
					<li><a href="pro?type=showAddPro" target="right">项目添加</a></li>
				</ul>
				<div class="yi">绩效管理</div>
				<ul class="er">
					<li><a href="sc" target="right">绩效管理</a></li>
					<li><a href="sc" target="right">成绩修改</a></li>
				</ul>
			</div>
			<iframe id="right" name="right" scrolling="no" frameborder="0"
				src="emp"></iframe>
		</div>
		<div id="bottom"></div>
	</div>
</body>
</html>