<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%
    String idParam = request.getParameter("id");
    if(idParam != null && !idParam.isEmpty()){
        int id = Integer.parseInt(idParam);
        String name="", email="", dept="";
        double salary=0;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp?useSSL=false&serverTimezone=UTC","root","root");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM employee WHERE id=?");
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                name = rs.getString("emp_name");
                email = rs.getString("email");
                dept = rs.getString("department");
                salary = rs.getDouble("salary");
            }
            con.close();
        }catch(Exception e){ out.println("<div class='alert alert-danger'>Error: "+e+"</div>"); }
%>
<div class="container mt-4">
  <h3>Edit Employee</h3>
  <form action="editEmployee.jsp?id=<%= id %>" method="post" class="needs-validation" novalidate>
    <input type="hidden" name="id" value="<%= id %>">
    <div class="mb-3">
      <label class="form-label">Name</label>
      <input type="text" class="form-control" name="emp_name" value="<%= name %>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" class="form-control" name="email" value="<%= email %>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Department</label>
      <input type="text" class="form-control" name="department" value="<%= dept %>">
    </div>
    <div class="mb-3">
      <label class="form-label">Salary</label>
      <input type="number" step="0.01" class="form-control" name="salary" value="<%= salary %>" required>
    </div>
    <button type="submit" class="btn btn-primary">Update</button>
  </form>
</div>
<%
    if("POST".equalsIgnoreCase(request.getMethod())){
        String newName = request.getParameter("emp_name");
        String newEmail = request.getParameter("email");
        String newDept = request.getParameter("department");
        String newSalary = request.getParameter("salary");
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp?useSSL=false&serverTimezone=UTC","root","root");
            PreparedStatement ps = con.prepareStatement("UPDATE employee SET emp_name=?, email=?, department=?, salary=? WHERE id=?");
            ps.setString(1,newName);
            ps.setString(2,newEmail);
            ps.setString(3,newDept);
            ps.setBigDecimal(4,new java.math.BigDecimal(newSalary));
            ps.setInt(5,id);
            ps.executeUpdate();
            out.println("<div class='alert alert-success mt-3'>Employee Updated Successfully!</div>");
            con.close();
        }catch(Exception e){ out.println("<div class='alert alert-danger'>Error: "+e+"</div>"); }
    }
    } else {
        out.println("<div class='alert alert-danger'>No employee ID provided!</div>");
    }
%>
<%@ include file="footer.jsp" %>
