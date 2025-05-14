<%@ page import="java.util.*,com.VNRVJIET.model.Employee" %>
<%@ include file="header.jsp" %>
<div class="container mt-4">
  <h3 class="fw-bold">Employee List</h3>
  <a href="new" class="btn btn-warning mb-3">Add Employee</a>
  <table class="table table-hover table-bordered">
    <thead class="table-warning">
      <tr><th>ID</th><th>Name</th><th>Email</th><th>Department</th><th>Salary</th><th>Actions</th></tr>
    </thead>
    <tbody>
      <%
        List<Employee> list = (List<Employee>)request.getAttribute("listEmployees");
        if(list != null && !list.isEmpty()){
          for(Employee e : list){
      %>
      <tr>
        <td><%= e.getId() %></td>
        <td><%= e.getName() %></td>
        <td><%= e.getEmail() %></td>
        <td><%= e.getDepartment() %></td>
        <td><%= e.getSalary() %></td>
        <td>
          <a href="edit?id=<%= e.getId() %>" class="btn btn-outline-warning btn-sm">Edit</a>
          <a href="delete?id=<%= e.getId() %>" class="btn btn-outline-danger btn-sm">Delete</a>
        </td>
      </tr>
      <% } } else { %>
      <tr><td colspan="6" class="text-center text-muted">No employees found.</td></tr>
      <% } %>
    </tbody>
  </table>
</div>
<%@ include file="footer.jsp" %>
