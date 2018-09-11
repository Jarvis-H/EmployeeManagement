package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Department;
import dao.DepartmentDao;
import util.Constant;
import util.Pagination;

public class DepartmentServlet extends HttpServlet {
	private static final String path = "WEB-INF/department";

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String type = request.getParameter("type");
		if (type == null || "search".equals(type)) {
			search(request, response);
		} else if ("showAddDep".equals(type)) {
			showAddDep(request, response);
		} else if ("addDep".equals(type)) {
			add(request, response);
		} else if ("showUpdateDep".equals(type)) {
			showUpdateDep(request, response);
		} else if ("updateDep".equals(type)) {
			updateDep(request, response);
		} else if ("deleteDep".equals(type)) {
			deleteDep(request, response);
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		try {
			DepartmentDao depDao = new DepartmentDao();
			Department condition = new Department();
			String name = request.getParameter("name");

			condition.setName(name);

			int curPage = 1;

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			int num = depDao.searchNumber(condition); // 总员工数

			Pagination p = new Pagination(curPage, num, Constant.Emp_NUM_IN_PAGE, Constant.Emp_NUM_OF_PAGE);

			List<Department> list = new ArrayList<>();
			list = depDao.search(condition, p.getBegin(), Constant.Emp_NUM_IN_PAGE);

			request.setAttribute("p", p);
			request.setAttribute("c", condition);

			request.setAttribute("list", list);
			request.getRequestDispatcher(path + "/deps.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {

			Department dep = new Department();
			String name = request.getParameter("name");
			dep.setName(name);

			DepartmentDao depDao = new DepartmentDao();
			depDao.add(dep);
			response.sendRedirect("dep");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void updateDep(HttpServletRequest request, HttpServletResponse response) {
		try {
			Department dep = new Department();

			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			dep.setId(id);
			dep.setName(name);

			DepartmentDao depDao = new DepartmentDao();
			depDao.update(dep);

			response.sendRedirect("dep");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void deleteDep(HttpServletRequest request, HttpServletResponse response) {
		try {

			int id = Integer.parseInt(request.getParameter("id"));

			DepartmentDao depDao = new DepartmentDao();
			boolean flag = depDao.delete(id);
			if (flag) {
				response.sendRedirect("dep");
			}

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void showAddDep(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.getRequestDispatcher(path + "/addDep.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void showUpdateDep(HttpServletRequest request, HttpServletResponse response) {

		try {
			int id = Integer.parseInt(request.getParameter("id"));
			DepartmentDao depDao = new DepartmentDao();
			Department dep = depDao.search(id);

			request.setAttribute("dep", dep);
			request.getRequestDispatcher(path + "/updateDep.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
