<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%
    String idParam = request.getParameter("id");
    if(idParam != null && !idParam.isEmpty()){
        int id = Integer.parseInt(idParam);
        if("POST".equalsIgnoreCase(request.getMethod())){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp?useSSL=false&serverTimezone=UTC","root","root");
                PreparedStatement ps = con.prepareStatement("DELETE FROM employee WHERE id=?");
                ps.setInt(1,id);
                ps.executeUpdate();
                out.println("<div class='alert alert-success mt-3'>Employee Deleted Successfully!</div>");
                con.close();
            }catch(Exception e){ out.println("<div class='alert alert-danger'>Error: "+e+"</div>"); }
        } else {
%>
<div class="container mt-4">
  <h3>Delete Employee</h3>
  <p>Are you sure you want to delete employee with ID <%= id %>?</p>
  <form action="deleteEmployee.jsp?id=<%= id %>" method="post">
    <button type="submit" class="btn btn-danger">Yes, Delete</button>
    <a href="listEmployees.jsp" class="btn btn-secondary">Cancel</a>
  </form>
</div>
<%
        }
    } else {
        out.println("<div class='alert alert-danger'>No employee ID provided!</div>");
    }
%>
<%@ include file="footer.jsp" %>
