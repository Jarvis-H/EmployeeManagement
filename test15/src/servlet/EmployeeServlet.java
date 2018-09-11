package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Department;
import bean.Employee;
import dao.DepartmentDao;
import dao.EmployeeDao;
import net.sf.json.JSONArray;
import util.Constant;
import util.Pagination;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.jasper.tagplugins.jstl.core.Out;

public class EmployeeServlet extends HttpServlet {
	private static final String path = "WEB-INF/employee";

	public void doGet(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String type = request.getParameter("type");
		if (type == null) {
			show(request, response);
		} else if ("showAdd".equals(type)) {
			showAdd(request, response);
		} else if ("showAdd2".equals(type)) {
			showAdd2(request, response);
		} else if ("add".equals(type)) {
			add(request, response);
		} else if ("add2".equals(type)) {
			add2(request, response);
		} else if ("showUpdate".equals(type)) {
			showUpdate(request, response);
		} else if ("update".equals(type)) {
			update(request, response);
		} else if ("delete".equals(type)) {
			delete(request, response);
		} else if ("deleteBatch".equals(type)) {
			deleteBatch(request, response);
		} else if ("showUpdateBatch1".equals(type)) {
			showUpdateBatch1(request, response);
		} else if ("updateBatch1".equals(type)) {
			updateBatch1(request, response);
		} else if ("showUpdateBatch2".equals(type)) {
			showUpdateBatch2(request, response);
		} else if ("updateBatch2".equals(type)) {
			updateBatch2(request, response);
		} else if ("updateBatch3".equals(type)) {
			updateBatch3(request, response);
		} else if ("search".equals(type)) {
			search(request, response);
		} else if ("upload".equals(type)) {
			upload(request, response);
		} else if ("deleteFile".equals(type)) {
			deleteFile(request, response);
		}
		
	}

	public void show(HttpServletRequest request, HttpServletResponse response) {

		try {

			EmployeeDao empDao = new EmployeeDao();
			DepartmentDao depDao = new DepartmentDao();
			List<Department> depList = depDao.search();
			int curPage = 1;

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			int num = empDao.searchNumber(); // 总员工数

			Pagination p = new Pagination(curPage, num, Constant.Emp_NUM_IN_PAGE, Constant.Emp_NUM_OF_PAGE);
			List<Employee> list = new ArrayList<>();
			list = empDao.search(p.getBegin(), Constant.Emp_NUM_IN_PAGE);
			request.setAttribute("p", p);
			request.setAttribute("depList", depList);
			request.setAttribute("list", list);
			request.getRequestDispatcher(path + "/emps.jsp").forward(request, response);

		} catch (ServletException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		try {
			EmployeeDao empDao = new EmployeeDao();
			DepartmentDao depDao = new DepartmentDao();
			List<Department> depList = depDao.search();

			Employee condition = new Employee();
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");

			int age = -1;

			if (request.getParameter("age") != null && !"".equals(request.getParameter("age"))) {
				age = Integer.parseInt(request.getParameter("age"));
			}
			int d_id = -1;
			if (request.getParameter("depID") != null && !"".equals(request.getParameter("depID"))) {
				d_id = Integer.parseInt(request.getParameter("depID"));
			}
			condition.setName(name);
			condition.setSex(sex);
			condition.setAge(age);
			Department dep = new Department();
			dep.setId(d_id);
			condition.setDep(dep);

			int curPage = 1;

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			int num = empDao.searchNumber(condition); // 总员工数

			Pagination p = new Pagination(curPage, num, Constant.Emp_NUM_IN_PAGE, Constant.Emp_NUM_OF_PAGE);

			List<Employee> list = new ArrayList<>();
			list = empDao.search(condition, p.getBegin(), Constant.Emp_NUM_IN_PAGE);

			request.setAttribute("p", p);
			request.setAttribute("c", condition);
			request.setAttribute("depList", depList);
			request.setAttribute("list", list);
			request.getRequestDispatcher(path + "/emps.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {
			String pathTu = "F:/test/";
			FileItemFactory factory = new DiskFileItemFactory();// 为该请求创建一个DiskFileItemFactory对象，通过它来解析请求。执行解析后，所有的表单项目都保存在一个List中。
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);
			String name = "";
			String sex = "";
			int age = -1;
			int depID = -1;
			String pic = "";
			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				if (item.getFieldName().equals("myfile")) {
					UUID uuid = UUID.randomUUID();
					String houzhui = item.getName().substring(item.getName().lastIndexOf("."));
					File savedFile = new File(pathTu, uuid.toString() + houzhui);
					item.write(savedFile);
					pic = uuid.toString() + houzhui;
				} else if (item.getFieldName().equals("name")) {
					name = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
				} else if (item.getFieldName().equals("sex")) {
					sex = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
				} else if (item.getFieldName().equals("age")) {
					age = Integer.parseInt(item.getString());
				} else if (item.getFieldName().equals("depID")) {
					depID = Integer.parseInt(item.getString());
				}

			}

			Employee emp = new Employee();

			emp.setPic(pic);
			emp.setName(name);
			emp.setSex(sex);
			emp.setAge(age);
			Department dep = new Department();
			dep.setId(depID);
			emp.setDep(dep);

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.add(emp);
			response.sendRedirect("emp");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	public void add2(HttpServletRequest request, HttpServletResponse response) {
		try {
			
			Employee emp = new Employee();
			
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			int age = Integer.parseInt(request.getParameter("age"));
			Integer depID = null;
			if (!"".equals(request.getParameter("depID"))) {
				depID = Integer.parseInt(request.getParameter("depID"));
			}
			String pic = request.getParameter("photo");
			emp.setPic(pic);
			emp.setName(name);
			emp.setSex(sex);
			emp.setAge(age);
			Department dep = new Department();
			dep.setId(depID);
			emp.setDep(dep);

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.add(emp);
			response.sendRedirect("emp");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void deleteFile(HttpServletRequest request, HttpServletResponse response) {
		try {
	    boolean flag=false;
	    String path=request.getParameter("path");
	    String spath="F:/test/"+path;
	    File file = new File(spath);  
	    // 路径为文件且不为空则进行删除  
	    if (file.isFile() && file.exists()) {  
	        file.delete();  
	        flag = true;  
	    }  
	    PrintWriter out = response.getWriter();
		
		out.print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void upload(HttpServletRequest request, HttpServletResponse response) {
		try {
			String pathTu = "F:/test/";
			FileItemFactory factory = new DiskFileItemFactory();// 为该请求创建一个DiskFileItemFactory对象，通过它来解析请求。执行解析后，所有的表单项目都保存在一个List中。
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);

			String pic = "";
			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				if (item.getFieldName().equals("myfile")) {
					UUID uuid = UUID.randomUUID();
					String houzhui = item.getName().substring(item.getName().lastIndexOf("."));
					pic = uuid.toString() + houzhui;
					File savedFile = new File(pathTu, pic);
					item.write(savedFile);
					
				}
			}
			PrintWriter out = response.getWriter();
			out.print(pic);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		try {
			Employee emp = new Employee();
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			int age = Integer.parseInt(request.getParameter("age"));
			int d_id = Integer.parseInt(request.getParameter("depID"));

			emp.setId(id);
			emp.setName(name);
			emp.setSex(sex);
			emp.setAge(age);
			Department dep = new Department();
			dep.setId(d_id);
			emp.setDep(dep);
			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.update(emp);

			response.sendRedirect("emp");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void delete(HttpServletRequest request, HttpServletResponse response) {
		try {

			int id = Integer.parseInt(request.getParameter("id"));

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.delete(id);
			if (flag) {
				response.sendRedirect("emp");
			}

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void deleteBatch(HttpServletRequest request, HttpServletResponse response) {
		try {
			String ids = request.getParameter("ids");

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.deleteBatch(ids);

			response.sendRedirect("emp");

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void showAdd(HttpServletRequest request, HttpServletResponse response) {

		try {
			DepartmentDao depDao = new DepartmentDao();
			List<Department> depList = depDao.search();
			request.setAttribute("depList", depList);
			request.getRequestDispatcher(path + "/add.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}
	public void showAdd2(HttpServletRequest request, HttpServletResponse response) {

		try {
			DepartmentDao depDao = new DepartmentDao();
			List<Department> depList = depDao.search();
			request.setAttribute("depList", depList);
			request.getRequestDispatcher(path + "/add2.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}
	public void showUpdate(HttpServletRequest request, HttpServletResponse response) {

		try {
			DepartmentDao depDao = new DepartmentDao();
			List<Department> depList = depDao.search();
			request.setAttribute("depList", depList);
			int id = Integer.parseInt(request.getParameter("id"));
			EmployeeDao empDao = new EmployeeDao();
			Employee emp = empDao.search(id);

			request.setAttribute("emp", emp);
			request.getRequestDispatcher(path + "/update.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	public void showUpdateBatch1(HttpServletRequest request, HttpServletResponse response) {

		try {
			String ids = request.getParameter("ids");
			EmployeeDao empDao = new EmployeeDao();
			List<Employee> list = empDao.search(ids);

			request.setAttribute("emp", list.get(0));
			request.setAttribute("ids", ids);
			request.getRequestDispatcher(path + "/updateBatch1.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	public void updateBatch1(HttpServletRequest request, HttpServletResponse response) {
		try {
			Employee emp = new Employee();
			String ids = request.getParameter("ids");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			int age = Integer.parseInt(request.getParameter("age"));

			emp.setName(name);
			emp.setSex(sex);
			emp.setAge(age);

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.updateBatch1(ids, emp);

			response.sendRedirect("emp");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void showUpdateBatch2(HttpServletRequest request, HttpServletResponse response) {

		try {
			String ids = request.getParameter("ids");
			EmployeeDao empDao = new EmployeeDao();
			List<Employee> list = empDao.search(ids);

			request.setAttribute("list", list);
			request.setAttribute("ids", ids);
			request.getRequestDispatcher(path + "/updateBatch2.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	public void updateBatch2(HttpServletRequest request, HttpServletResponse response) {
		try {
			String emps = request.getParameter("emps");
			String[] array = emps.split(";");

			List<Employee> list = new ArrayList<>();
			for (int i = 0; i < array.length; i++) {
				String[] temp = array[i].split(",");
				Employee emp = new Employee();
				emp.setId(Integer.parseInt(temp[0]));
				emp.setName(temp[1]);
				emp.setSex(temp[2]);
				emp.setAge(Integer.parseInt(temp[3]));
				list.add(emp);
			}

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.updateBatch2(list);

			response.sendRedirect("emp");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void updateBatch3(HttpServletRequest request, HttpServletResponse response) {

		try {
			String emps = request.getParameter("emps");
			JSONArray jsonArray = JSONArray.fromObject(emps);
			List<Employee> list = (List<Employee>) jsonArray.toCollection(jsonArray, Employee.class);

			EmployeeDao empDao = new EmployeeDao();
			boolean flag = empDao.updateBatch2(list);

			response.sendRedirect("emp");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
