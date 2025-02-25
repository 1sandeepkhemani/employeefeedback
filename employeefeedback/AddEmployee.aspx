<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="employeefeedback.AddEmployee" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>Add Employee</title>
   <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">


 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>

   
</head>
<body>

    <div class="container p-1">
    <form runat="server" id="employeeForm" onsubmit="return validateForm();">  

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
       
        <a href="dashboard.aspx" class="navbar-brand d-flex align-items-center ms-3" data-bs-toggle="tooltip" data-bs-placement="right" title="Employee Feedback System">
             <img src="Images\logoefspic.jpg" alt="Logo" class="img-fluid rounded-circle me-2" style="width: 85px; height: 65px;">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
               <li class="nav-item px-3">
                    <a class="nav-link text-dark " href="Dashboard.aspx">Home</a>
                </li>

                <li class="nav-item ">
                    <a class="nav-link text-dark " href="About.aspx">About</a>
                </li>

                <li class="nav-item px-3">
                    <a class="nav-link text-dark" href="EmployeeList.aspx">Employees</a>
                </li>


                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center text-dark fw-bold" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="black" class="bi bi-person-circle me-1" viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                        </svg>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                     
                        <li>
                           <a class="dropdown-item" href="Logout.aspx">Logout</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


        <div class=" bg-light">
             <div class="mt-5 p-1 pt-3">
    
            <div class="row">
         <div class="col">
              <h3 class="text-uppercase p-1">Add Employee</h3>
         </div>

         
        </div>  
            </div>
            <div class="p1">
                <div class="container mt-3">
                <div class="mb-3">
                      <label class="form-label">Employee Name</label>
                        <div class="row">
                        <div class="col-md-6">
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Placeholder="First Name" required></asp:TextBox>
                            <span id="firstNameError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"  Placeholder="Last Name" required></asp:TextBox>
                            <span id="lastNameError" class="text-danger"></span>
                        </div>
                    </div>
                </div>

              
                <div class="mb-3">
                    <label class="form-label">Mobile No.</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"  pattern="\d{10}" title="Enter 10-digit mobile number" Placeholder="Mobile No" required></asp:TextBox>
                    <span id="mobileError" class="text-danger"></span>
                </div>

            <div class="mb-3">
                <label class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username" required ></asp:TextBox>
                <span id="usernameError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password" required></asp:TextBox>
                    <button type="button" class="btn btn-outline-secondary" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <span id="passwordError" class="text-danger"></span>
            </div>


            <div class="mb-3">
            <label class="form-label" for="ddlRole">Role</label>
            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control" required>
                <asp:ListItem Text="Select Role" Value="" />
     
            </asp:DropDownList>
            <span id="roleError" class="text-danger"></span>
            </div>

            <div class="mb-3">
                <label class="form-label">Upload Image</label>
                <asp:FileUpload ID="fulPhoto" runat="server" CssClass="form-control" Placeholder="Upload Image"/>
                <span id="photoError" class="text-danger"></span>
                
            </div>

           <div class="mb-3">
                <label class="form-label">Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Address"></asp:TextBox>
                <span id="addressError" class="text-danger"></span>
            </div>

            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add Employee" OnClick="btnSubmit_Click"  OnClientClick="return validateForm();" />

        </div>
        </div>

            </div>
    

    </form>


        
        <footer class="d-flex flex-wrap justify-content-between align-items-center p-3 my-4 border-top bg-light">
    <div class="col-md-4 d-flex align-items-center">
      
      <span class="text-muted">© 2025</span>
    </div>

    <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
      <li class="ms-3"><a class="text-muted" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16">
  <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334q.002-.211-.006-.422A6.7 6.7 0 0 0 16 3.542a6.7 6.7 0 0 1-1.889.518 3.3 3.3 0 0 0 1.447-1.817 6.5 6.5 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.32 9.32 0 0 1-6.767-3.429 3.29 3.29 0 0 0 1.018 4.382A3.3 3.3 0 0 1 .64 6.575v.045a3.29 3.29 0 0 0 2.632 3.218 3.2 3.2 0 0 1-.865.115 3 3 0 0 1-.614-.057 3.28 3.28 0 0 0 3.067 2.277A6.6 6.6 0 0 1 .78 13.58a6 6 0 0 1-.78-.045A9.34 9.34 0 0 0 5.026 15"/>
</svg></a></li>
      <li class="ms-3"><a class="text-muted" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-instagram" viewBox="0 0 16 16">
  <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.9 3.9 0 0 0-1.417.923A3.9 3.9 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.9 3.9 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.9 3.9 0 0 0-.923-1.417A3.9 3.9 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599s.453.546.598.92c.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.5 2.5 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.5 2.5 0 0 1-.92-.598 2.5 2.5 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233s.008-2.388.046-3.231c.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92s.546-.453.92-.598c.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92m-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217m0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334"/>
</svg></a></li>
      <li class="ms-3"><a class="text-muted" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
  <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951"/>
</svg></a></li>
    </ul>
  </footer>

    </div>

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

     <script type="text/javascript">
         $(document).ready(function () {
             $('[data-bs-toggle="tooltip"]').tooltip();
         });
     </script>

<script>
    function validateForm() {
        let isValid = true;

        // Retrieve form values
        let fname = document.getElementById("txtFirstName").value.trim();
        let lname = document.getElementById("txtLastName").value.trim();
        let mobile = document.getElementById("txtMobile").value.trim();
        let address = document.getElementById("txtAddress").value.trim();
        let photo = document.getElementById("fulPhoto").value;
        let username = document.getElementById("txtUsername").value.trim();
        let password = document.getElementById("txtPassword").value.trim();
        let role = document.getElementById("ddlRole").value.trim();

        // Clear previous error messages and reset borders
        document.querySelectorAll(".error-message").forEach(e => e.innerText = "");
        document.querySelectorAll(".form-control").forEach(e => e.style.border = "1px solid #ced4da");

        // Validation logic
        if (!fname) {
            setError("txtFirstName", "firstNameError", "Please enter First Name.");
            isValid = false;
        }

        if (!lname) {
            setError("txtLastName", "lastNameError", "Please enter Last Name.");
            isValid = false;
        }

        if (!mobile.match(/^\d{10}$/)) {
            setError("txtMobile", "mobileError", "Enter a valid 10-digit Mobile Number.");
            isValid = false;
        }

        if (!address) {
            setError("txtAddress", "addressError", "Please enter the Address.");
            isValid = false;
        }

        if (!photo) {
            setError("fulPhoto", "photoError", "Please upload a Photo.");
            isValid = false;
        }

        if (!username) {
            setError("txtUsername", "usernameError", "Please enter a Username.");
            isValid = false;
        }

        if (!password || password.length < 6) {
            setError("txtPassword", "passwordError", "Password must be at least 6 characters.");
            isValid = false;
        }

        if (!role) {
            setError("ddlRole", "roleError", "Please select a Role.");
            isValid = false;
        }

        return isValid;
    }

    // Function to set error message and apply red border
    function setError(inputId, errorId, message) {
        let inputElement = document.getElementById(inputId);
        document.getElementById(errorId).innerText = message;
        inputElement.style.border = "2px solid red";
    }
</script>



    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>

     <script>
         $(document).ready(function () {
             $("#togglePassword").click(function () {
                 var input = $("#<%= txtPassword.ClientID %>");
             var icon = $(this).find("i");
             if (input.attr("type") === "password") {
                 input.attr("type", "text");
                 icon.removeClass("fa-eye").addClass("fa-eye-slash");
             } else {
                 input.attr("type", "password");
                 icon.removeClass("fa-eye-slash").addClass("fa-eye");
             }
         });
     });
 </script>

     
   
</body>
</html>
