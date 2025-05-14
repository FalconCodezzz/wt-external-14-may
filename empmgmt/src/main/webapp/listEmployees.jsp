<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<main class="container mt-4">
  <h3 class="fw-bold text-dark mb-4">Employee List</h3>

  <!-- Search bar -->
  <form action="listEmployees.jsp" method="get" class="d-flex mb-3">
    <input type="text" name="search" class="form-control me-2"
           placeholder="Search employees by name or email"
           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    <button type="submit" class="btn btn-warning">Search</button>
  </form>

  <div class="card shadow-lg border-0">
    <div class="card-body bg-white">
      <table class="table table-hover table-bordered align-middle">
        <thead class="table-warning">
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Department</th>
            <th>Salary</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <%
            String search = request.getParameter("search");
            String sql = "SELECT * FROM employee";
            if(search != null && !search.isEmpty()){
                sql += " WHERE emp_name LIKE ? OR email LIKE ?";
            }

            try{
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con = DriverManager.getConnection(
                  "jdbc:mysql://localhost:3306/emp?useSSL=false&serverTimezone=UTC",
                  "root","root"
              );
              PreparedStatement ps = con.prepareStatement(sql);

              if(search != null && !search.isEmpty()){
                  ps.setString(1, "%" + search + "%");
                  ps.setString(2, "%" + search + "%");
              }

              ResultSet rs = ps.executeQuery();
              boolean hasResults = false;
              while(rs.next()){
                hasResults = true;
          %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("emp_name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("department") %></td>
            <td><%= rs.getBigDecimal("salary") %></td>
            <td>
              <a href="editEmployee.jsp?id=<%= rs.getInt("id") %>" class="btn btn-outline-warning btn-sm">Edit</a>
              <a href="deleteEmployee.jsp?id=<%= rs.getInt("id") %>" class="btn btn-outline-danger btn-sm">Delete</a>
            </td>
          </tr>
          <% }
             if(!hasResults){
          %>
          <tr>
            <td colspan="6" class="text-center text-muted">No employees found.</td>
          </tr>
          <% }
             con.close();
            }catch(Exception e){
              out.println("<tr><td colspan='6' class='text-danger'>Error: "+e+"</td></tr>");
            }
          %>
        </tbody>
      </table>
    </div>
  </div>
</main>
<%@ include file="footer.jsp" %>
