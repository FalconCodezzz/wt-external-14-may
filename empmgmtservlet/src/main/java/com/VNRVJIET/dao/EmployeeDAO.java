package com.VNRVJIET.dao;

import java.sql.*;
import java.util.*;
import com.VNRVJIET.model.Employee;

public class EmployeeDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/emp?useSSL=false&serverTimezone=UTC";
    private String jdbcUsername = "root";
    private String jdbcPassword = "root";

    private static final String INSERT_SQL = "INSERT INTO employee (emp_name,email,department,salary) VALUES (?,?,?,?)";
    private static final String SELECT_ALL = "SELECT * FROM employee";
    private static final String SELECT_BY_ID = "SELECT * FROM employee WHERE id=?";
    private static final String DELETE_SQL = "DELETE FROM employee WHERE id=?";
    private static final String UPDATE_SQL = "UPDATE employee SET emp_name=?, email=?, department=?, salary=? WHERE id=?";

    protected Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void insertEmployee(Employee emp) throws Exception {
        try(Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(INSERT_SQL)) {
            ps.setString(1, emp.getName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getDepartment());
            ps.setDouble(4, emp.getSalary());
            ps.executeUpdate();
        }
    }

    public List<Employee> selectAllEmployees() throws Exception {
        List<Employee> list = new ArrayList<>();
        try(Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(SELECT_ALL)) {
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Employee e = new Employee();
                e.setId(rs.getInt("id"));
                e.setName(rs.getString("emp_name"));
                e.setEmail(rs.getString("email"));
                e.setDepartment(rs.getString("department"));
                e.setSalary(rs.getDouble("salary"));
                list.add(e);
            }
        }
        return list;
    }

    public Employee selectEmployee(int id) throws Exception {
        Employee e = null;
        try(Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                e = new Employee();
                e.setId(rs.getInt("id"));
                e.setName(rs.getString("emp_name"));
                e.setEmail(rs.getString("email"));
                e.setDepartment(rs.getString("department"));
                e.setSalary(rs.getDouble("salary"));
            }
        }
        return e;
    }

    public boolean updateEmployee(Employee emp) throws Exception {
        try(Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(UPDATE_SQL)) {
            ps.setString(1, emp.getName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getDepartment());
            ps.setDouble(4, emp.getSalary());
            ps.setInt(5, emp.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteEmployee(int id) throws Exception {
        try(Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(DELETE_SQL)) {
            ps.setInt(1,id);
            return ps.executeUpdate() > 0;
        }
    }
}
