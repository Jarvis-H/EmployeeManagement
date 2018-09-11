package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import bean.Department;
import bean.Employee;
import bean.Project;
import bean.Score;
import util.Grade;

public class ScoreDao {

	public List<Score> search(int begin, int size) {
		List<Score> list = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?characterEncoding=utf-8", "root",
					"123");
			stat = conn.createStatement();
			String sql = " SELECT e.id as e_id, e.name AS e_name, d.id AS d_id,d.name AS d_name ,  p.id AS p_id,p.name AS p_name,s.id AS s_id,IFNULL(value,'') AS value ,grade "
					+ "FROM employee AS e  " + "LEFT JOIN department AS d  ON e.d_id=d.id  "
					+ "LEFT JOIN r_dep_pro AS r  ON r.d_id=d.id  " + "LEFT JOIN project AS p  ON r.p_id=p.id  "
					+ "LEFT JOIN score AS s  ON s.e_id=e.id AND p.id=s.p_id  limit " + begin + " ," + size;
			rs = stat.executeQuery(sql);

			while (rs.next()) {
				Score sc = new Score();
				sc.setId(rs.getInt("s_id"));

				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));

				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));

				Project pro = new Project();
				pro.setId(rs.getInt("p_id"));
				pro.setName(rs.getString("p_name"));

				emp.setDep(dep);
				sc.setEmp(emp);
				sc.setPro(pro);
				sc.setValue(rs.getInt("value"));
				Grade g = Grade.getGrade(rs.getString("grade"));

				sc.setGrade(g);

				list.add(sc);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public int searchNumber() {
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		int num = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?characterEncoding=utf-8", "root",
					"123");
			stat = conn.createStatement();
			String sql = " SELECT count(*) FROM employee AS e  LEFT JOIN department AS d  ON e.d_id=d.id LEFT JOIN r_dep_pro AS r  ON r.d_id=d.id  LEFT JOIN project AS p  ON r.p_id=p.id  	LEFT JOIN score AS s  ON s.e_id=e.id AND p.id=s.p_id  ";
			rs = stat.executeQuery(sql);

			if (rs.next()) {
				num = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return num;
	}

	public int searchNumber(Score condition) {
		Connection conn = null;
		Statement stat = null;
		int num = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?characterEncoding=utf-8", "root",
					"123");
			stat = conn.createStatement();

			String where = " where 1=1 ";
			if (condition.getEmp().getId() != -1) {
				where += " and e.id='" + condition.getEmp().getId() + "'";
			}
			if (!condition.getEmp().getName().equals("")) {
				where += " and e.name='" + condition.getEmp().getName() + "'";
			}
			if (condition.getEmp().getDep().getId() != -1) {
				where += " and d.id='" + condition.getEmp().getDep().getId() + "'";
			}

			if (condition.getPro().getId() != -1) {
				where += " and p.id='" + condition.getPro().getId() + "'";
			}
			if (condition.getValue() != -1) {
				where += " and value= " + condition.getValue();
			}

			String sql = "  SELECT count(*) FROM employee AS e  LEFT JOIN department AS d  ON e.d_id=d.id LEFT JOIN r_dep_pro AS r  ON r.d_id=d.id  LEFT JOIN project AS p  ON r.p_id=p.id  	LEFT JOIN score AS s  ON s.e_id=e.id AND p.id=s.p_id   "
					+ where;

			ResultSet rs = stat.executeQuery(sql);
			if (rs.next()) {
				num = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}

		return num;
	}

	public List<Score> searchByCondition(Score condition) {
		List<Score> list = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?characterEncoding=utf-8", "root",
					"123");
			stat = conn.createStatement();
			String where = " where 1=1 ";
			if (!condition.getEmp().getName().equals("")) {
				where += " and e.name='" + condition.getEmp().getName() + "'";
			}
			if (!condition.getEmp().getDep().getName().equals("")) {
				where += " and d.id='" + condition.getEmp().getDep().getId() + "'";
			}
			if (!condition.getPro().getName().equals("")) {
				where += " and p.id='" + condition.getPro().getId() + "'";
			}
			if (condition.getValue() != -1) {
				where += " and value= " + condition.getValue();
			}
			String sql = " SELECT e.id as e_id, e.name AS e_name, d.id AS d_id,d.name AS d_name ,  p.id AS p_id,p.name AS p_name,s.id AS s_id,IFNULL(value,'') AS value ,grade "
					+ "FROM employee AS e  " + "LEFT JOIN department AS d  ON e.d_id=d.id  "
					+ "LEFT JOIN r_dep_pro AS r  ON r.d_id=d.id  " + "LEFT JOIN project AS p  ON r.p_id=p.id  "
					+ "LEFT JOIN score AS s  ON s.e_id=e.id AND p.id=s.p_id  " + where;
			rs = stat.executeQuery(sql);

			while (rs.next()) {

				Score sc = new Score();
				sc.setId(rs.getInt("s_id"));

				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));

				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));

				Project pro = new Project();
				pro.setId(rs.getInt("p_id"));
				pro.setName(rs.getString("p_name"));

				emp.setDep(dep);
				sc.setEmp(emp);
				sc.setPro(pro);
				sc.setValue(rs.getInt("value"));

				Grade g = Grade.getGrade(rs.getString("grade"));

				sc.setGrade(g);

				list.add(sc);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public List<Score> search(Score condition, int begin, int size) {
		List<Score> list = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?characterEncoding=utf-8", "root",
					"123");
			stat = conn.createStatement();
			String where = " where 1=1 ";
			if (condition.getEmp().getId() != -1) {
				where += " and e.id='" + condition.getEmp().getId() + "'";
			}
			if (!condition.getEmp().getName().equals("")) {
				where += " and e.name='" + condition.getEmp().getName() + "'";
			}
			if (condition.getEmp().getDep().getId() != -1) {
				where += " and d.id='" + condition.getEmp().getDep().getId() + "'";
			}

			if (condition.getPro().getId() != -1) {
				where += " and p.id='" + condition.getPro().getId() + "'";
			}
			if (condition.getValue() != -1) {
				where += " and value= " + condition.getValue();
			}

			String sql = "SELECT e.id as e_id, e.name AS e_name, d.id AS d_id,d.name AS d_name ,  p.id AS p_id,p.name AS p_name,s.id AS s_id,IFNULL(value,'') AS value ,grade "
					+ "FROM employee AS e  LEFT JOIN department AS d  ON e.d_id=d.id  "
					+ "LEFT JOIN r_dep_pro AS r  ON r.d_id=d.id  LEFT JOIN project AS p  ON r.p_id=p.id "
					+ "LEFT JOIN score AS s  ON s.e_id=e.id AND p.id=s.p_id  " + where + " limit " + begin + " ,"
					+ size;

			rs = stat.executeQuery(sql);

			while (rs.next()) {
				Score sc = new Score();
				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));
				Department dep = new Department();
				dep.setName(rs.getString("d_name"));
				dep.setId(rs.getInt("d_id"));
				emp.setDep(dep);

				sc.setEmp(emp);

				Project pro = new Project();
				pro.setName(rs.getString("p_name"));
				pro.setId(rs.getInt("p_id"));
				sc.setPro(pro);
				sc.setValue(rs.getInt("value"));

				Grade g = Grade.getGrade(rs.getString("grade"));

				sc.setGrade(g);
				list.add(sc);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public boolean updateBatch(List<Score> list) {
		boolean flag = false;
		Connection conn = null;
		PreparedStatement pstat = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?characterEncoding=utf-8", "root",
					"123");
			for (int i = 0; i < list.size(); i++) {
				Score sc = list.get(i);
				String sql = "update score set value=? where id=?";
				pstat = conn.prepareStatement(sql);
				pstat.setInt(1, sc.getValue());
				pstat.setInt(2, sc.getId());
				int rs = pstat.executeUpdate();

				if (rs > 0) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

}
