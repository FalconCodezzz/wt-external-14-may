<%@ page import="com.VNRVJIET.model.Employee" %>
<%@ include file="header.jsp" %>
<%
  Employee emp = (Employee)request.getAttribute("employee");
  boolean isEdit = (emp != null);
%>
<div class="container mt-4">
  <h3 class="fw-bold"><%= isEdit ? "Edit Employee" : "Add Employee" %></h3>
  <form action="<%= isEdit ? "update" : "insert" %>" method="post" class="needs-validation" novalidate>
    <% if(isEdit){ %>
      <input type="hidden" name="id" value="<%= emp.getId() %>">
    <% } %>
    <div class="mb-3">
      <label class="form-label">Name</label>
      <input type="text" class="form-control" name="name" value="<%= isEdit ? emp.getName() : "" %>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" class="form-control" name="email" value="<%= isEdit ? emp.getEmail() : "" %>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Department</label>
      <input type="text" class="form-control" name="department" value="<%= isEdit ? emp.getDepartment() : "" %>">
    </div>
    <div class="mb-3">
      <label class="form-label">Salary</label>
      <input type="number" step="0.01" class="form-control" name="salary" value="<%= isEdit ? emp.getSalary() : "" %>" required>
    </div>
    <button type="submit" class="btn btn-warning"><%= isEdit ? "Update" : "Save" %></button>
    <a href="list" class="btn btn-secondary">Cancel</a>
  </form>
</div>
<%@ include file="footer.jsp" %>
