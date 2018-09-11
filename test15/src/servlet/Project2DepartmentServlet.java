package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Department;
import bean.Employee;
import bean.Project;
import dao.DepartmentDao;
import dao.EmployeeDao;
import dao.Project2DepartmentDao;
import dao.ProjectDao;
import util.Constant;
import util.Pagination;

public class Project2DepartmentServlet extends HttpServlet {
	private static final String path = "WEB-INF/project2department";

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String type = request.getParameter("type");
		if (type == null || "search".equals(type)) {
			search(request, response);
		} else if ("addPro".equals(type)) {
			add(request, response);
		} else if ("addPro2".equals(type)) {
			add2(request, response);
		} else if ("addPros".equals(type)) {
			adds(request, response);
		} else if ("deletePro2Dep".equals(type)) {
			deletePro2Dep(request, response);
		} else if ("deletePro2Dep2".equals(type)) {
			deletePro2Dep2(request, response);
		} else if ("deletePro2Dep2s".equals(type)) {
			deletePro2Dep2s(request, response);
		} else if ("showManagePro".equals(type)) {
			showManagePro(request, response);
		} else if ("m2".equals(type)) {
			search2(request, response);
		} else if ("m3".equals(type)) {
			search3(request, response);
		} else if ("m4".equals(type)) {
			search4(request, response);
		} else if ("m5".equals(type)) {
			search5(request, response);
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		try {
			ProjectDao proDao = new ProjectDao();
			Project condition = new Project();
			String name = request.getParameter("name");

			condition.setName(name);

			int curPage = 1;

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			int num = proDao.searchNumber(condition); // 总员工数

			Pagination p = new Pagination(curPage, num, Constant.Emp_NUM_IN_PAGE, Constant.Emp_NUM_OF_PAGE);

			List<Project> list = new ArrayList<>();
			list = proDao.search(condition, p.getBegin(), Constant.Emp_NUM_IN_PAGE);

			request.setAttribute("p", p);
			request.setAttribute("c", condition);

			request.setAttribute("list", list);
			request.getRequestDispatcher(path + "/managePro.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {

			Project2DepartmentDao pro2dep = new Project2DepartmentDao();
			// String name = request.getParameter("name");
			int depId = -1;
			if (request.getParameter("depId") != null) {
				depId = Integer.parseInt(request.getParameter("depId"));
			}

			int proId = -1;
			if (request.getParameter("proId") != null && !"".equals(request.getParameter("proId"))) {
				proId = Integer.parseInt(request.getParameter("proId"));
				pro2dep.add(depId, proId);
			}

			response.sendRedirect("pro2dep?type=showManagePro&id=" + depId);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void add2(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			PrintWriter out = response.getWriter();
			Project2DepartmentDao pro2dep = new Project2DepartmentDao();
			// String name = request.getParameter("name");
			int depId = -1;
			if (request.getParameter("depId") != null) {
				depId = Integer.parseInt(request.getParameter("depId"));
			}

			int proId = -1;
			if (request.getParameter("proId") != null && !"".equals(request.getParameter("proId"))) {
				proId = Integer.parseInt(request.getParameter("proId"));
				flag = pro2dep.add(depId, proId);
			}
			out.print(flag);

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void adds(HttpServletRequest request, HttpServletResponse response) {

		try {
			boolean flag = false;
			PrintWriter out = response.getWriter();
			String proIds = request.getParameter("proIds");
			String depId = request.getParameter("depId");

			Project2DepartmentDao p2dDao = new Project2DepartmentDao();
			flag = p2dDao.adds(proIds, depId);

			out.print(flag);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void deletePro2Dep(HttpServletRequest request, HttpServletResponse response) {
		try {

			Project2DepartmentDao proDao = new Project2DepartmentDao();
			int depId = -1;
			if (request.getParameter("depId") != null) {
				depId = Integer.parseInt(request.getParameter("depId"));
			}

			int proId = -1;
			if (request.getParameter("proId") != null) {
				proId = Integer.parseInt(request.getParameter("proId"));
			}
			proDao.delete(depId, proId);
			response.sendRedirect("pro2dep?type=showManagePro&id=" + depId);

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void deletePro2Dep2(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			Project2DepartmentDao proDao = new Project2DepartmentDao();
			int depId = -1;
			if (request.getParameter("depId") != null) {
				depId = Integer.parseInt(request.getParameter("depId"));
			}

			int proId = -1;
			if (request.getParameter("proId") != null) {
				proId = Integer.parseInt(request.getParameter("proId"));
			}
			boolean flag = proDao.delete(depId, proId);
			out.print(flag);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void deletePro2Dep2s(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			PrintWriter out = response.getWriter();
			Project2DepartmentDao p2dDao = new Project2DepartmentDao();
			String proIds = request.getParameter("proIds");
			String depId = request.getParameter("depId");
			flag = p2dDao.deletes(proIds, depId);
			out.print(flag);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	private void showManagePro(HttpServletRequest request, HttpServletResponse response) {

		try {
			List<Project> pro2deplist = new ArrayList<>();
			List<Project> proNotdeplist = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			Project2DepartmentDao pro2depDao = new Project2DepartmentDao();
			pro2deplist = pro2depDao.searchByDepartment(id);
			proNotdeplist = pro2depDao.searchByNotDepartment(id);
			DepartmentDao depDao = new DepartmentDao();
			Department dep = depDao.search(id);
			String headName = dep.getName();

			request.setAttribute("headName", headName);
			request.setAttribute("pro2deplist", pro2deplist);
			request.setAttribute("proNotdeplist", proNotdeplist);
			request.setAttribute("depId", id);
			request.getRequestDispatcher("WEB-INF/project2department/managePro.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void search2(HttpServletRequest request, HttpServletResponse response) {

		try {
			List<Project> pro2deplist = new ArrayList<>();
			List<Project> proNotdeplist = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			Project2DepartmentDao pro2depDao = new Project2DepartmentDao();
			pro2deplist = pro2depDao.searchByDepartment(id);
			proNotdeplist = pro2depDao.searchByNotDepartment(id);
			DepartmentDao depDao = new DepartmentDao();
			Department dep = depDao.search(id);
			String headName = dep.getName();

			request.setAttribute("headName", headName);
			request.setAttribute("pro2deplist", pro2deplist);
			request.setAttribute("proNotdeplist", proNotdeplist);
			request.setAttribute("depId", id);
			request.getRequestDispatcher("WEB-INF/project2department/managePro2.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void search3(HttpServletRequest request, HttpServletResponse response) {

		try {
			List<Project> pro2deplist = new ArrayList<>();
			List<Project> proNotdeplist = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			Project2DepartmentDao pro2depDao = new Project2DepartmentDao();
			pro2deplist = pro2depDao.searchByDepartment(id);
			proNotdeplist = pro2depDao.searchByNotDepartment(id);
			DepartmentDao depDao = new DepartmentDao();
			Department dep = depDao.search(id);
			String headName = dep.getName();

			request.setAttribute("headName", headName);
			request.setAttribute("pro2deplist", pro2deplist);
			request.setAttribute("proNotdeplist", proNotdeplist);
			request.setAttribute("depId", id);
			request.getRequestDispatcher("WEB-INF/project2department/managePro3.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void search4(HttpServletRequest request, HttpServletResponse response) {

		try {
			List<Project> pro2deplist = new ArrayList<>();
			List<Project> proNotdeplist = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			Project2DepartmentDao pro2depDao = new Project2DepartmentDao();
			pro2deplist = pro2depDao.searchByDepartment(id);
			proNotdeplist = pro2depDao.searchByNotDepartment(id);
			DepartmentDao depDao = new DepartmentDao();
			Department dep = depDao.search(id);
			String headName = dep.getName();

			request.setAttribute("headName", headName);
			request.setAttribute("pro2deplist", pro2deplist);
			request.setAttribute("proNotdeplist", proNotdeplist);
			request.setAttribute("depId", id);
			request.getRequestDispatcher("WEB-INF/project2department/managePro4.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void search5(HttpServletRequest request, HttpServletResponse response) {

		try {

			List<Project> pro2deplist = new ArrayList<>();
			List<Project> proNotdeplist = new ArrayList<>();

			int id = Integer.parseInt(request.getParameter("id"));

			Project2DepartmentDao pro2depDao = new Project2DepartmentDao();
			pro2deplist = pro2depDao.searchByDepartment(id);
			proNotdeplist = pro2depDao.searchByNotDepartment(id);
			DepartmentDao depDao = new DepartmentDao();
			Department dep = depDao.search(id);
			String headName = dep.getName();

			request.setAttribute("headName", headName);
			request.setAttribute("pro2deplist", pro2deplist);
			request.setAttribute("proNotdeplist", proNotdeplist);
			request.setAttribute("depId", id);
			request.getRequestDispatcher("WEB-INF/project2department/managePro5.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
