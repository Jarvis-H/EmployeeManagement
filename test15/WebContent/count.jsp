<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//int i = 0;
		//if (application.getAttribute("i") != null) {
		//	i = (Integer) application.getAttribute("i");
		//}
		//if (session.isNew()) {
		//	i++;
		//}
		//application.setAttribute("i", i);
		int num = 0;
		if (session.isNew()) {//老session就不往下进行，节省资源
			String ip = request.getRemoteAddr();
			Set<String> set = new HashSet<String>();
			if (application.getAttribute("set") != null) {
				set = (Set<String>) application.getAttribute("set");
			}
			set.add(ip);
			num = set.size();
			application.setAttribute("set", set);
			application.setAttribute("num", num);
		}
	%>
	本网页共有<%=num %>人访问
	
</body>
</html>