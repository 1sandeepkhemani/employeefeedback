<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="EditProfile.aspx.cs" Inherits="employeefeedback.EditProfile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   <div class=" bg-light">
     <div class="mt-5 p-1 pt-3">
    
    <div class="row">
 <div class="col">
      <h3 class="text-uppercase p-1">Update Employee</h3>
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
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"  Placeholder="Last Name" required></asp:TextBox>
                    <span id="lastNameError" class="text-danger"></span>
                </div>
            </div>
        </div>

      
        <div class="mb-3">
            <label class="form-label">Mobile No</label>
            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"  pattern="\d{10}" title="Enter 10-digit mobile number" Placeholder="Mobile No" required></asp:TextBox>
            <span id="mobileError" class="text-danger"></span>
        </div>

    <div class="mb-3">
        <label class="form-label">Username</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username" ReadOnly="true" required ></asp:TextBox>
        <span id="usernameError" class="text-danger"></span>
    </div>

   


    

    <div class="mb-3">
        <label class="form-label">Upload Image</label>
        <asp:FileUpload ID="fulPhoto" runat="server" CssClass="form-control" Placeholder="Upload Image"/>
        <asp:HiddenField ID="hfPhotoPath" runat="server" />
        <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
    </div>

   <div class="mb-3">
        <label class="form-label">Address</label>
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Address"></asp:TextBox>
        <span id="addressError" class="text-danger"></span>
    </div>

    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click1" OnClientClick="return validateForm();"/>

</div>
</div>

    </div>

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

    function resetError(inputElement, errorElementId) {
        inputElement.style.border = "1px solid #ced4da"; // Reset border to default
        document.getElementById(errorElementId).innerText = ""; // Clear error message
    }

    // Auto-remove red border when user starts typing
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
    </script>


</asp:Content>
