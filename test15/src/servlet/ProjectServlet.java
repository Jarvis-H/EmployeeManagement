package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Project;
import dao.ProjectDao;
import util.Constant;
import util.Pagination;

public class ProjectServlet extends HttpServlet {
	private static final String path="WEB-INF/project";
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String type = request.getParameter("type");
		if (type == null||"search".equals(type)) {
			search(request, response);
		}  else if ("showAddPro".equals(type)) {
			showAddPro(request, response);
		} else if ("addPro".equals(type)) {
			add(request, response);
		} else if ("showUpdatePro".equals(type)) {
			showUpdatePro(request, response);
		} else if ("updatePro".equals(type)) {
			updatePro(request, response);
		} else if ("deletePro".equals(type)) {
			deletePro(request, response);
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
			list = proDao.search(condition,p.getBegin(), Constant.Emp_NUM_IN_PAGE);
			
			request.setAttribute("p", p);
			request.setAttribute("c", condition);

			request.setAttribute("list", list);
			request.getRequestDispatcher(path + "/pros.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {

			Project pro = new Project();
			String name = request.getParameter("name");
			pro.setName(name);

			ProjectDao proDao = new ProjectDao();
			proDao.add(pro);
			response.sendRedirect("pro");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void updatePro(HttpServletRequest request, HttpServletResponse response) {
		try {
			Project pro = new Project();
			
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			pro.setId(id);
			pro.setName(name);

			ProjectDao proDao = new ProjectDao();
			proDao.update(pro);

			response.sendRedirect("pro");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void deletePro(HttpServletRequest request, HttpServletResponse response) {
		try {

			int id = Integer.parseInt(request.getParameter("id"));

			ProjectDao proDao = new ProjectDao();
			boolean flag = proDao.delete(id);
			if (flag) {
				response.sendRedirect("pro");
			}

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void showAddPro(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.getRequestDispatcher(path + "/addPro.jsp").forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void showUpdatePro(HttpServletRequest request, HttpServletResponse response) {

		try {
			int id = Integer.parseInt(request.getParameter("id"));
			ProjectDao proDao = new ProjectDao();
			Project pro = proDao.search(id);

			request.setAttribute("pro", pro);
			request.getRequestDispatcher(path + "/updatePro.jsp").forward(request, response);
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
