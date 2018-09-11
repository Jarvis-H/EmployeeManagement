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
import bean.Employee;
import bean.Project;
import bean.Score;
import dao.DepartmentDao;
import dao.EmployeeDao;
import dao.ProjectDao;
import dao.ScoreDao;
import net.sf.json.JSONArray;
import util.Constant;
import util.Grade;
import util.Pagination;

public class ScoreServlet extends HttpServlet {
	private static final String path = "WEB-INF/score";
	DepartmentDao depDao = new DepartmentDao();
	ProjectDao proDao = new ProjectDao();
	List<Department> depList = new ArrayList<>();
	List<Project> proList = new ArrayList<>();

	public void doGet(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String type = request.getParameter("type");
		if (type == null) {
			show(request, response);
		} else if ("search".equals(type)) {
			search(request, response);
		} else if ("updateBatch".equals(type)) {
			updateBatch(request, response);
		}
	}

	public void show(HttpServletRequest request, HttpServletResponse response) {

		try {

			ScoreDao scDao = new ScoreDao();

			int curPage = 1;

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}

			int num = scDao.searchNumber(); // 总员工数

			Pagination p = new Pagination(curPage, num, Constant.Emp_NUM_IN_PAGE, Constant.Emp_NUM_OF_PAGE);

			List<Score> list = new ArrayList<>();
			depList = depDao.search();
			proList = proDao.search();
			list = scDao.search(p.getBegin(), Constant.Emp_NUM_IN_PAGE);

			request.setAttribute("p", p);
			request.setAttribute("list", list);
			request.setAttribute("depList", depList);
			request.setAttribute("proList", proList);
			
			request.getRequestDispatcher(path + "/scs.jsp").forward(request, response);

		} catch (ServletException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		try {
			ScoreDao scDao = new ScoreDao();
			Score condition = new Score();

			int id = -1;
			if (request.getParameter("id") != null && !"".equals(request.getParameter("id"))) {
				id = Integer.parseInt(request.getParameter("id"));
			}
			String name = request.getParameter("name");

			int dId = -1;
			if (request.getParameter("dId") != null && !"".equals(request.getParameter("dId"))) {
				dId = Integer.parseInt(request.getParameter("dId"));
			}
			int pId = -1;
			if (request.getParameter("pId") != null && !"".equals(request.getParameter("pId"))) {
				pId = Integer.parseInt(request.getParameter("pId"));
			}
			int value = -1;
			if (request.getParameter("value") != null && !"".equals(request.getParameter("value"))) {
				value = Integer.parseInt(request.getParameter("value"));
			}
			Employee emp = new Employee();
			emp.setId(id);
			emp.setName(name);
			Department dep = new Department();
			dep.setId(dId);
			emp.setDep(dep);
			condition.setEmp(emp);
			Project pro = new Project();
			pro.setId(pId);
			condition.setPro(pro);
			condition.setValue(value);
			int curPage = 1;

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			int num = scDao.searchNumber(condition); // 搜索后数量

			Pagination p = new Pagination(curPage, num, Constant.Emp_NUM_IN_PAGE, Constant.Emp_NUM_OF_PAGE);

			List<Score> list = new ArrayList<>();
			list = scDao.search(condition, p.getBegin(), Constant.Emp_NUM_IN_PAGE);

			depList = depDao.search();
			proList = proDao.search();

			request.setAttribute("p", p);
			request.setAttribute("c", condition);
			request.setAttribute("list", list);
			request.setAttribute("depList", depList);
			request.setAttribute("proList", proList);
			
			request.getRequestDispatcher(path + "/scs.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void updateBatch(HttpServletRequest request, HttpServletResponse response) {

		try {
			String scs = request.getParameter("scs");
			JSONArray jsonArray = JSONArray.fromObject(scs);
			List<Score> list = (List<Score>) jsonArray.toCollection(jsonArray, Score.class);

			ScoreDao scDao = new ScoreDao();
			boolean flag = scDao.updateBatch(list);

			response.sendRedirect("sc");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
