<%@ include file="header.jsp" %>
<main class="container-fluid p-0" style="background: url('https://image-static.collegedunia.com/public/college_data/images/campusimage/1567745048a1cad.png') no-repeat center center fixed; background-size: cover; min-height: 90vh;">
  <div class="d-flex justify-content-center align-items-center" style="min-height: 90vh; background-color: rgba(255,255,255,0.85);">
    <div class="text-center p-5 rounded shadow-lg bg-white">
      <h2 class="fw-bold text-dark">Welcome to VNRVJIET Employee Management</h2>
      <p class="mt-3 fs-5 text-muted">
        A responsive and professional system to manage employee records.
      </p>

      <!-- Search Feature -->
      <form action="listEmployees.jsp" method="get" class="d-flex justify-content-center mt-4">
        <input type="text" name="search" class="form-control w-50 me-2" placeholder=" Search employees by name or email">
        <button type="submit" class="btn btn-warning">Search</button>
      </form>

      <!-- Navigation Buttons -->
      <div class="mt-4">
        <a href="addEmployee.jsp" class="btn btn-warning btn-lg me-3">
           Add Employee
        </a>
        <a href="listEmployees.jsp" class="btn btn-outline-dark btn-lg">
           View Employees
        </a>
      </div>
    </div>
  </div>
</main>
<%@ include file="footer.jsp" %>

