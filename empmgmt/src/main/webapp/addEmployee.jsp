<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<div class="container mt-4">
  <h3>Add Employee</h3>
  <form action="addEmployee.jsp" method="post" class="needs-validation" novalidate>
    <div class="mb-3">
      <label class="form-label">Name</label>
      <input type="text" class="form-control" name="emp_name" required>
      <div class="invalid-feedback">Name is required.</div>
    </div>
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" class="form-control" name="email" required>
      <div class="invalid-feedback">Valid email required.</div>
    </div>
    <div class="mb-3">
      <label class="form-label">Department</label>
      <input type="text" class="form-control" name="department">
    </div>
    <div class="mb-3">
      <label class="form-label">Salary</label>
      <input type="number" step="0.01" class="form-control" name="salary" required>
      <div class="invalid-feedback">Salary required.</div>
    </div>
    <button type="submit" class="btn btn-success">Add Employee</button>
  </form>
</div>
<script>
  (function () {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  })();
</script>
<%@ include file="footer.jsp" %>

<%
  // Minimal JSP insert logic
  if("POST".equalsIgnoreCase(request.getMethod())){
    String name = request.getParameter("emp_name");
    String email = request.getParameter("email");
    String dept = request.getParameter("department");
    String salary = request.getParameter("salary");

    try{
      Class.forName("com.mysql.cj.jdbc.Driver");
      java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/emp","root","root");
      java.sql.PreparedStatement ps = con.prepareStatement("INSERT INTO employee(emp_name,email,department,salary) VALUES(?,?,?,?)");
      ps.setString(1,name);
      ps.setString(2,email);
      ps.setString(3,dept);
      ps.setBigDecimal(4,new java.math.BigDecimal(salary));
      ps.executeUpdate();
      out.println("<div class='alert alert-success mt-3'>Employee Added Successfully!</div>");
      con.close();
    }catch(Exception e){ out.println("<div class='alert alert-danger'>Error: "+e+"</div>"); }
  }
%>
