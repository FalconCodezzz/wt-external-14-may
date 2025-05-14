package com.VNRVJIET.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.*;
import com.VNRVJIET.dao.EmployeeDAO;
import com.VNRVJIET.model.Employee;

@WebServlet("/")
public class EmployeeServlet extends HttpServlet {
    private EmployeeDAO dao;

    public void init() { dao = new EmployeeDAO(); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        try {
            switch(action){
                case "/new": showNewForm(request,response); break;
                case "/insert": insertEmployee(request,response); break;
                case "/delete": deleteEmployee(request,response); break;
                case "/edit": showEditForm(request,response); break;
                case "/update": updateEmployee(request,response); break;
                default: listEmployees(request,response); break;
            }
        } catch(Exception e){ throw new ServletException(e); }
    }

    private void listEmployees(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Employee> list = dao.selectAllEmployees();
        request.setAttribute("listEmployees", list);
        RequestDispatcher rd = request.getRequestDispatcher("employee-list.jsp");
        rd.forward(request,response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("employee-form.jsp");
        rd.forward(request,response);
    }

    private void insertEmployee(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Employee e = new Employee();
        e.setName(request.getParameter("name"));
        e.setEmail(request.getParameter("email"));
        e.setDepartment(request.getParameter("department"));
        e.setSalary(Double.parseDouble(request.getParameter("salary")));
        dao.insertEmployee(e);
        response.sendRedirect("list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee existing = dao.selectEmployee(id);
        RequestDispatcher rd = request.getRequestDispatcher("employee-form.jsp");
        request.setAttribute("employee", existing);
        rd.forward(request,response);
    }

    private void updateEmployee(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Employee e = new Employee();
        e.setId(Integer.parseInt(request.getParameter("id")));
        e.setName(request.getParameter("name"));
        e.setEmail(request.getParameter("email"));
        e.setDepartment(request.getParameter("department"));
        e.setSalary(Double.parseDouble(request.getParameter("salary")));
        dao.updateEmployee(e);
        response.sendRedirect("list");
    }

    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deleteEmployee(id);
        response.sendRedirect("list");
    }
}
