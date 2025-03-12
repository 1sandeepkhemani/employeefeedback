<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="AddEmployee.aspx.cs" Inherits="employeefeedback.AddEmployee" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="bg-light">
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
                    <label class="form-label">Full Name</label>
                    <div class="row">
                        <div class="col-md-6">
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Placeholder="First Name" required></asp:TextBox>
                            <span id="firstNameError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Placeholder="Last Name" required></asp:TextBox>
                            <span id="lastNameError" class="text-danger"></span>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mobile No</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" Pattern="\d{10}" title="Enter 10-digit mobile number" Placeholder="Mobile No" required></asp:TextBox>
                    <span id="mobileError" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username" required></asp:TextBox>
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
                    <asp:FileUpload ID="fulPhoto" runat="server" CssClass="form-control"/>
                    <span id="photoError" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Address"></asp:TextBox>
                </div>

                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return validateForm();" />
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
   
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <script>
        function validateForm() {
            let isValid = true;

            // Retrieve form values
            let fname = document.getElementById("<%= txtFirstName.ClientID %>").value.trim();
            let lname = document.getElementById("<%= txtLastName.ClientID %>").value.trim();
            let mobile = document.getElementById("<%= txtMobile.ClientID %>").value.trim();
            let username = document.getElementById("<%= txtUsername.ClientID %>").value.trim();
            let password = document.getElementById("<%= txtPassword.ClientID %>").value.trim();
            let role = document.getElementById("<%= ddlRole.ClientID %>").value.trim();
            let fileInput = document.getElementById("<%= fulPhoto.ClientID %>");
            
            // Clear previous error messages
            document.querySelectorAll(".text-danger").forEach(e => e.innerText = "");

            // Validation logic
            if (!fname) { setError("<%= txtFirstName.ClientID %>", "firstNameError", "Please enter First Name."); isValid = false; }
            if (!lname) { setError("<%= txtLastName.ClientID %>", "lastNameError", "Please enter Last Name."); isValid = false; }
            if (!mobile.match(/^\d{10}$/)) { setError("<%= txtMobile.ClientID %>", "mobileError", "Enter a valid 10-digit Mobile Number."); isValid = false; }
            if (!username) { setError("<%= txtUsername.ClientID %>", "usernameError", "Please enter a Username."); isValid = false; }
            if (!password || password.length < 6) { setError("<%= txtPassword.ClientID %>", "passwordError", "Password must be at least 6 characters."); isValid = false; }
            if (!role) { setError("<%= ddlRole.ClientID %>", "roleError", "Please select a Role."); isValid = false; }

            // Photo validation (max size 100KB)
            if (fileInput.files.length > 0) {
                let fileSize = fileInput.files[0].size;
                if (fileSize > 100 * 1024) {
                    document.getElementById("photoError").innerText = "Photo size should be less than 100KB.";
                    isValid = false;
                }
            }

            return isValid;
        }

        function setError(inputId, errorId, message) {
            document.getElementById(errorId).innerText = message;
            document.getElementById(inputId).style.border = "2px solid red";
        }

        document.addEventListener("DOMContentLoaded", function () {
            var inputs = document.querySelectorAll(".form-control"); // Select all input fields
            inputs.forEach(function (input) {
                input.addEventListener("input", function () {
                    this.style.border = "1px solid #ced4da"; // Reset border when user types
                    var errorElementId = this.id + "Error";
                    document.getElementById(errorElementId).innerText = ""; // Clear error message
                });
            });
        });

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

</asp:Content>
