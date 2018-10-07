# EmployeeManagement
## 员工管理系统
.概述
  项目主要分四个模块，员工管理，部门管理，项目管理，绩效管理。采用三层架构，显示层，业务逻辑层，数据访问层。主要实现功能为各个模块对数据库的增删改查以及相关的业务功能。
  主要用到的技术，HTML+CSS+JS+JQ，MySql，servlet，JSP，EL表达式，JSTL标签，WebSocket。

2.功能描述
2.1 基本增删改查
  Dao层从数据库中查到所有数据，利用request作为载体将数据发到前台页面，前台页面使用table展示数据。
  双击行拿到原始数据，在原来位置通过jq操作dom放置文本框，下拉列表，点击保存，拿到修改后的数据在放置在url中（字符串拼接或者使用json对象），后台拿到后进行数据库的update操作。
  选中多行点击修改按钮可以进行批量修改，将选中的行数据的id通过字符串形式发向后台，在Dao层查到数据后再转发到批量修改页面。在Dao层循环显示出相应数据，保存时分别获取数据，封装成JSON数据，在后台解析成相应的类的list保存在数据库。
  添加时显示添加页面，或者Bootstrap模态框。   删除只需要拿到选中的数据的id即可。

2.2 条件搜索
  组合条件搜索，在前台页面拿到选中或者填写的搜索条件，后台进行判断，字符串拼接组合sql语句

2.3 员工管理
  员工管理需要给员工分配部门，从数据库中查到所有部门列表，以下拉列表形式显示在修改或者添加的页面，数据保存时只需要发回对应的部门id即可。

2.4 项目管理
  一个项目需要由不同的部门去做，可以进行部门的分配。前台实现方式有4种

以表格形式显示项目已经包含的部门，可以点击移除将部门移出项目组；以下拉列表形式显示不在项目组中的部门，点击添加将部门添加到项目组中。
上下分区，上方区域显示已包含部门，下方区域显示不在项目组中的部门，点击添加或者移除按钮进行操作。
显示形式同上，部门添加或移除可以使用拖拽。
显示形式同上，但不是以新页面显示，以Bootstrap模态框显示。
  选中部门点击添加移除，或者鼠标拖动移入相应区域（通过坐标计算，可以设置一定误差值提高用户体验度），即发送Ajax请求，成功后将被操作的部门顺序放入对应的区域。
  后台只需拿到数据执行update操作。

2.5 部门管理
  部门管理可以看到本部门员工数，本部门项目数，点击项目数可以对本部门的所有项目进行管理，给部门分配员工。实现形式同项目管理形式。

2.6 绩效管理
  以table形式显示数据，每行显示员工姓名，部门，项目，以及绩效成绩和等级。双击项目不为空的行，可以对员工绩效更改，输入成绩当鼠标焦点移开时自动保存。

2.7 登录,注册
  首次访问时未登录直接跳转到登陆页面，输入用户名密码验证码登录。后台收到数据后，先进性验证码验证，验证成功后通过用户名在数据库中查找对应数据。预设用户名唯一，若查到数据与用户输入数据相同则返回登录成功，并将登录信息放入session，否则根据不成功原因返回对应提示。
  注册时输入用户名密码，在前台验证符合规则通过后发到后台，将用户信息insert into数据表，若出现重复则返回对应提示。

2.8 当前人数，网站访问总人数
  主页面上方显示当前在线人数以及访问本网站的名次。当前在线人数使用WebSocket实现，名次则存放在本次会话session中，网站访问总人数则放在Application中。

2.9 分页查询，页数显示
  封装PageInfo对象存储分页信息。

2.10 图片上传，显示，放大镜
  使用input的file属性，form表单enctype="multipart/form-data"实现文件上传，共实现有两种方式

直接将form表单中输入的信息和图片上传
基于上一种方式的改进。先将图片上传，返回图片名并将图片显示在上传按钮下方。用户可以根据需要选择继续上传或者删除（点击图片即可），不在修改后只需将输入的信息和图片名发到后台存入数据库。
3 功能实现
3.1 组合条件搜索
  根据用户输入的数据进行判断，拼接字符串

//员工搜索示例
    public String sqlConcat(Employee e, int type) {
		String condition1 = " count(1)";
		String condition2 = " *";
		String condition = type == 1 ? condition1 : condition2;
		String sql = "select " + condition + " from employee where 1=1";
		if (e.getName().length() > 0) {
			sql += " and name like '%" + e.getName() + "%'";
		}
		if (e.getSex().length() > 0) {
			sql += " and sex='" + e.getSex() + "'";
		}
		if (e.getAge()!=null && e.getAge() != 0) {
			sql += " and age=" + e.getAge();
		}
		if (e.getdId()!=null && e.getdId() != 0) {
			sql += " and d_id=" + e.getdId();
		}
		return sql;
	}
3.4 鼠标拖拽
  方式一，使用Bootstrap插件中的draggable事件。

/*
	*拖拽
	*/
	//pro的容器坐标
	var proLeft=$("#pro").offset().left;
	var proTop=$("#pro").offset().top;
	//pro的容器高度和宽度
	//parseFloat去掉单位转化为纯数字
	var proWidth=parseFloat($("#pro").css("width"));
	var proHeight=parseFloat($("#pro").css("height"));
	//定义初始坐标的变量
	var startLeft;
	var startTop;
	$( ".pro" ).draggable({
		
        start: function() {
          //定义初始坐标,else需要用到
          startLeft=$(this).offset().left;
          startTop=$(this).offset().top;
        },
    
        stop: function() {
        	//停止时的坐标点
        	var stopLeft=$(this).offset().left;
        	var stopTop=$(this).offset().top;
        	//判断停止的坐标是否在pro的容器内
        	if(stopLeft>=proLeft && stopLeft<=proLeft+proWidth && stopTop>=proTop && stopTop<=proTop+proHeight){
        		//拿到proId
        		var proId =$(this).data("id");
        		var pro=$(this);
        		$.ajax({
        			url:"d2p",
					type:"post",
					data:{type:"add2", depId:${dep.id}, proId:proId}, 
					dataType:"text",
					success:function(data){
						
						if(data="true"){
							//设成流布局才能自动排列到最后
							pro.css("position","static");
							
							//将拖动的pro拼到最后一个pro的后面
							//ajax里面的this值得是整个ajax这里不能用
							$("#pro").append(pro);
							
							//拼好之后再变成相对布局才可以继续拖动
							pro.css("position","relative");
							
							//默认0,0则他就会在他为流布局时该在的位置 
							pro.css("left","0");
							pro.css("top","0");
						}				
					}
        		})
        	}else{
        		//返回原位置
        		$(this).offset({left:startLeft, top:startTop});
        	}
        }
    });
		
  方式二，使用jq开发，原理：对要移动的dom对象绑定click时间，当单击触发事件后设置对象的css属性，position为relative，left和top的位置为鼠标的坐标，并绑定mousemove事件，鼠标移动并防止坐标超出页面边界，同时改变dom对象的位置。触发mouseup事件后用当前dom坐标与要移入的区域边界进行判断，若已经移入则发Ajax请求，同时将该dom元素放入移入的区域，设置css属性position为static。如没有移入，则只要将css属性position设置为static，回到原位置。

var inDiv = $("#indep").offset();
		var inX = inDiv.left;
		var inY = inDiv.top;
		var outDiv = $("#outdep").offset();
		var outX = outDiv.left;
		var outY = outDiv.top;

		$(document).on("mousedown",'#outdep .dep',function(e) {
					var dep = $(this);
					$(dep).addClass("move")
					var positionDiv = $(this).offset();
					var distenceX = e.pageX - positionDiv.left;
					var distenceY = e.pageY - positionDiv.top;
					var x = 0;
					var y = 0;
					$(document).mousemove(function(e) {
								x = e.pageX - distenceX;
								y = e.pageY - distenceY;
								$(dep).css({
									'position' : 'absolute',
									'left' : x-10 + 'px',
									'top' : y-20 + 'px'
								});
								if (x < 0) {
									x = 0;
								} else if (x > $(document).width()
										- $(this).outerWidth(true)) {
									x = $(document).width()
											- $(this).outerWidth(true);
								}
								if (y < 0) {
									y = 0;
								} else if (y > $(document).height()
										- $(this).outerHeight(true)) {
									y = $(document).height()
											- $(this).outerHeight(true);
								}
								$(this).css({
									'left' : x + 'px',
									'top' : y + 'px'
								});
							});
					$(document).mouseup(function() {
						$(document).off('mousemove');
						var finalX = parseInt($(dep).css("left").substring(0,$(dep).css("left").length-2))
						var finalY = parseInt($(dep).css("top").substring(0,$(dep).css("top").length-2))
						if((finalX < inX + 600 && finalX > inX) && (finalY < inY + 150 && finalY > inY)){
							var pid = $("h3").data("pid");
							var did = $(dep).data("did")
							add(pid, did)
						}else{
							dep.css("position","static")
						}
					});
				});
3.5 绩效焦点移出
  文本框获得焦点focus事件
  文本框失去焦点blur事件，当文本框失去焦点触发blur事件，获得文本框的内容，发Ajax请求，拿到返回信息为true时移除input，将文本框内容放在相应单元格，并实时修改等级一列。

	function save() {
		var modify = $(".modify");//拿到被修改的一行
		
		var id = modify.data("id");
		var eid = modify.children(".name").data("eid");
		var pid = modify.children(".pro").data("pid");
		var value = modify.find("[name=value]").val();
		modify.find(".value").empty();
		modify.find(".value").text(value);
		modify.removeClass(".modify");
		$.ajax({
			url : "score",
			type : "post",
			data : {
				type : "modify",
				id : id,
				eid : eid,
				pid : pid,
				value : value
			},
			dataType : "json",
			success : function(data) {
				$("table").bind();

				if (data.type = "true") {
					modify.find(".grade").text(data.grade);
				} else {
					alert(data.type)
				}
			}
		})
	}
3.6拦截器（过滤器）filter，监听器（触发器）listener
  项目所有页面文件均位于WEB-INF文件夹中，不可直接访问，配置servlet提供项目的唯一入口MainServlet。因此使用filter在拦截请求后，判断session中是否有user信息，从而选择放行或者跳转到登录界面。

    	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
		try {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse res = (HttpServletResponse) response;

			if (req.getSession().getAttribute("username") != null) {
				chain.doFilter(request, response);
			} else {
				res.sendRedirect("user?type=loginShow");
			}
		} catch (IOException | ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

  拦截器配置

  <filter>
    <filter-name>LoginFilter</filter-name>
    <filter-class>filter.LoginFilter</filter-class>
  </filter>
  <filter-mapping>
    <filter-name>LoginFilter</filter-name>
    <url-pattern>/employee</url-pattern>
    <url-pattern>/employee2</url-pattern>
    <url-pattern>/project</url-pattern>
    <url-pattern>/department</url-pattern>
    <url-pattern>/score</url-pattern>
    <url-pattern>/score2</url-pattern>
    <url-pattern>/index</url-pattern>
  </filter-mapping>
  监听器监听实现HttpSessionListener接口在session被创建和销毁的时候触发，同样实现ServletContextListener接口可以监听application对象的创建和销毁。   当监听到有session被创建时，网站的访问量总数+1，当前在线人数+1，同时得到此用户的登录位次。访问总量放入application，在线人数和登录位次放入此session对象，同时调用websocket的方法群发消息，所有在线用户都会收到新的在线人数。

    /**
	 * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
	 */
	public void sessionCreated(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		Integer num = 0;
		
		ServletContext application = arg0.getSession().getServletContext();
		if (application.getAttribute("num") != null) {
			num = (Integer) application.getAttribute("num");
		}
		num++;
		numNow++;
		WebSocket.sendMessage(String.valueOf(numNow));
		application.setAttribute("num", num);
		arg0.getSession().setAttribute("num", num);
		System.out.println("session create");
	}

  当session过期销毁，除了群发消息，在线人数-1之外不需要作其他操作。

    /**
	 * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
	 */
	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		numNow--;
		WebSocket.sendMessage(String.valueOf(numNow));

		System.out.println("session destory");
	}
3.7 登录
	private void doLogin(HttpServletRequest request, HttpServletResponse response) {
		try {
			String code = (String) request.getSession().getAttribute("randcode");
			
			Map<String, String> map = new HashMap<>();
			String username = request.getParameter("username");
			String pwd = request.getParameter("pwd");
			String randcode = request.getParameter("randcode");
			User user = new User();
			user.setUsername(username);
			user.setPassword(pwd);
			
			if (code.equalsIgnoreCase(randcode)) {

				map = userDao.search(user);

				if (map.get("type").equals("true")) {
					HttpSession session = request.getSession();
					session.setAttribute("username", username);
				}
			}else {
				map.put("type", "false");
				map.put("msg", "验证码不正确！");
			}
			JSONObject jsonObject = JSONObject.fromObject(map);
			PrintWriter out = response.getWriter();
			out.println(jsonObject);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
3.8 验证码
  RandomCode使用AWT生成一张包含四位字符的图片，通过getValdateCode方法返回一个ValidateCode对象，将图片通过ServletOutputStream发送到前台，四位验证码则放入session。

	private void randomCode(HttpServletRequest request, HttpServletResponse response) {
		try {
	        //RandomCode生成验证码
			RandomCode rc = new RandomCode();

			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
            
            //ValidateCode存放验证码图片和四位字符
			ValidateCode vc = rc.getValdateCode();
			request.getSession().setAttribute("randcode", vc.getCode());
			ServletOutputStream sos = response.getOutputStream();
			ImageIO.write(vc.getImage(), "JPEG", sos);
			sos.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
  登录界面点击验证码，则重新发次请求，拿到新的验证码图片。

	var i = 1;
	$("#randcode img").click(function() {
		$(this).attr("src", "user?type=randcode&i=" + (i++));
	})
		
3.9 加密
  避免用户密码直接明文显示，对其加密。加密是通过加盐方式连接注册时的时间进行MD5加密。   登录时先拿到存在数据表中的时间（同样被加密），拼接用户输入的密码后进行MD5加密再与数据库中的密码进行比对。

    User u = new User();
	u.setDate(rs.getString("date"));
	if (MD5.MD5(user.getPassword() + u.getDate()).equals(rs.getString("password"))) {
		map.put("type", "true");
	} else {
		map.put("type", "false");
		map.put("msg", "用户名或密码错误！");
	}
  注册时先保存特定格式的当前时间，在存入数据库之前加密，再与注册时用户输入的密码拼接加密，最后存入数据库。

    //拿到时间
    User user = new User();
    user.setUsername(username);
    user.setPassword(pwd);
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    user.setDate(sdf.format(date));
    //将用户名密码，时间存入数据库
    String sql = "insert into user(username,password,date) values(?,?,?)";
	ps = conn.prepareStatement(sql,1);
	ps.setString(1, user.getUsername());
	ps.setString(2, MD5.MD5(user.getPassword() + MD5.MD5(user.getDate())));
	ps.setString(3, MD5.MD5(user.getDate()));
	id = ps.executeUpdate();
3.10 WebSocket
  使用websocket通信，动态显示当前在线人数。实现原理，当有新的session建立时，通过websocket群发消息，将表示当前在线人数的消息发送到前台，前台收到消息，jq将消息中的数据显示在页面上。

    //建立或销毁session后监听器调用群发消息
    WebSocket.sendMessage(String.valueOf(numNow));
    //前台页面的websocket建立
    var websocket = null;

	//判断当前浏览器是否支持WebSocket
	if ('WebSocket' in window) {
		websocket = new WebSocket(
				"ws://192.168.0.154:8080/Enterprise2/websocket");
	} else {
		alert('没有建立websocket连接')
	}

	//连接发生错误的回调方法
	websocket.onerror = function() {
		console.log("错误");
	};

	//连接成功建立的回调方法
	websocket.onopen = function(event) {
		console.log("建立连接");
	}

	//接收到消息的回调方法
	websocket.onmessage = function(event) {
		var data = event.data;
		$("#onLine").html(data);
		console.log("收到消息  " + data);
	}

	//连接关闭的回调方法
	websocket.onclose = function() {
		console.log("close");
	}

	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口。
	window.onbeforeunload = function() {
		websocket.close();
	}

	//关闭连接
	function closeWebSocket() {
		websocket.close();
	}
    //群发消息
    public static void sendMessage(String message) {
		for (WebSocket w : set) {
			try {
				w.session.getBasicRemote().sendText(message);
			} catch (Exception e) {
				continue;
			}
		}
	}
3.11
  PageInfo类中存放分页信息，页面下方显示几个页面按钮，起始页，结束页，当前页。在数据库查询时用到的size（每页显示数），index（查询起始位置）。   通过构造函数传入的当前页数，总条目数，每页显示数量，显示按钮数计算起始页，结束页，查询起始位置。

    public PageInfo(int page, int rows, int numInPage, int numOfPage) {
		// TODO Auto-generated constructor stub
		this.pageCount = rows % numInPage == 0 ? (rows / numInPage): (rows / numInPage) + 1;
		this.limit = numInPage;
		this.pageNow = page;

		this.beginPage = this.pageNow - numOfPage / 2;
		if(this.beginPage <= 1) {
			this.beginPage = 1;
		}
		this.endPage = this.beginPage + numOfPage - 1;
		if(this.endPage >= pageCount) {
			this.endPage = pageCount;
			this.beginPage = pageCount >= numOfPage ? this.endPage - numOfPage + 1 : 1;
		}
		this.index = this.limit * (pageNow - 1);
	}
  转发页面时将pageInfo放入request对象一并转发到前台，根据其中的信息再进行显示。

    <div id="page">
		<ul class="pagination">
			<c:if test="${requestScope.pageInfo.pageNow eq 1}">
				<li class="disabled"><a class="page-prev">&laquo;</a></li>
			</c:if>
			<c:if test="${requestScope.pageInfo.pageNow ne 1 }">
				<li><a class="page-prev">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${requestScope.pageInfo.beginPage }"
				end="${requestScope.pageInfo.endPage }" step="1" varStatus="v">
				<c:if test="${requestScope.pageInfo.pageNow eq v.index}">
					<li class="active"><a class="page-btn" data-page="${v.index}">
							<c:out value="${v.index} " />
					</a></li>
				</c:if>
				<c:if test="${requestScope.pageInfo.pageNow ne v.index}">
					<li><a class="page-btn" data-page="${v.index}"> <c:out
								value="${v.index} " /></a></li>
				</c:if>
			</c:forEach>
			<c:if
				test="${requestScope.pageInfo.pageNow eq requestScope.pageInfo.pageCount}">
				<li class="disabled"><a class="page-next disabled" href="#">&raquo;</a></li>
			</c:if>
			<c:if
				test="${requestScope.pageInfo.pageNow ne requestScope.pageInfo.pageCount}">
				<li><a class="page-next" href="#">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
3.12 图片上传，显示，放大镜
  表单上传

    <form action="employee2?type=add" class="form-horizontal" role="form"	method="post">
    
    	//....		
    </form>
  ajax上传

    //点击上传按钮，触发事件
    $("#upload").click(function() {
		var formData = new FormData();
		for(var i = 0; i < $("[name=img]")[0].files.length; i++){
			formData.append("img", $("[name=img]")[0].files[i]);
		}
		$.ajax({
			url : "employee2?type=upload",
			type : "post",
			data : formData,
			cache : false,
			processData : false,
			contentType : false,
			dataType : "text",
			success : function(data) {
				var p = '<img src="/img/'+ data +'"/>'
				var i = '<input type="hidden" name="imgName" value="'+ data +'" />'
				$("#imgs").append(p);
				$("#imgs").append(i);
			}
			
		})
	})

  图片显示，将图片保存在单独的文件夹位置，通过配置服务器的方式进行访问。

//服务器下的server.xml
<Context docBase="D:\upload" path="/img" reloadable="true"/>
  放大镜，先预设一个隐藏的固定大小的dom(div)，当鼠标移动到图片上时，获取此图片然后放在预设的dom中，并随着鼠标移动，当鼠标移出图片时，dom隐藏。

//鼠标移入
$("img").mouseover(function(ee) {
		$(this).css({"border":"2px solid #665``6","z-index":"2"})
		var p = $(this).prop("src");
		$("#big").find("img").prop("src",p)
		$("#big").css({
				"display" : "block",
				"left" : ee.pageX - 350 + "px",
				"top" : ee.pageY - 250 + "px",
			})
		$(document).mousemove(function(e) {
			$("#big").css({
				"left" : e.pageX - 320 + "px",
				"top" : e.pageY - 250 + "px",
			})
		})
	})

    //鼠标移出
	$("img").mouseleave(function(e) {
		$("#big").css("display","none")		
		$(this).css("border","0px solid #666")
	})
也可以使用hover
