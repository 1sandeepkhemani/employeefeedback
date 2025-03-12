<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="EmployeeEdit.aspx.cs" Inherits="employeefeedback.EmployeeEdit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-light">
        <div class="mt-5 p-1 pt-3">
            <div class="row">
                <div class="col">
                    <h3 class="text-uppercase p-1">Update Employee</h3>
                </div>
            </div>
        </div>

        <div class="p-1">
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
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" pattern="\d{10}" title="Enter 10-digit mobile number" Placeholder="Mobile No" required></asp:TextBox>
                    <span id="mobileError" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username" ReadOnly="true"></asp:TextBox>
                    <span id="usernameError" class="text-danger"></span>
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
                    <asp:FileUpload ID="fulPhoto" runat="server" CssClass="form-control" />
                    <asp:HiddenField ID="hfPhotoPath" runat="server" />
                    <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
                    <span id="photoError" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Address"></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClientClick="return validateForm();" OnClick="btnUpdate_Click1" />
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            let isValid = true;

            // Retrieve form values using ASP.NET ClientIDs
            let fname = document.getElementById("<%= txtFirstName.ClientID %>").value.trim();
            let lname = document.getElementById("<%= txtLastName.ClientID %>").value.trim();
            let mobile = document.getElementById("<%= txtMobile.ClientID %>").value.trim();
            let role = document.getElementById("<%= ddlRole.ClientID %>").value.trim();

            // Clear previous error messages and reset borders
            document.querySelectorAll(".text-danger").forEach(e => e.innerText = "");
            document.querySelectorAll(".form-control").forEach(e => e.style.border = "1px solid #ced4da");

            // Validation logic
            if (!fname) {
                setError("<%= txtFirstName.ClientID %>", "firstNameError", "Please enter First Name.");
                isValid = false;
            }

            if (!lname) {
                setError("<%= txtLastName.ClientID %>", "lastNameError", "Please enter Last Name.");
                isValid = false;
            }

            if (!mobile.match(/^\d{10}$/)) {
                setError("<%= txtMobile.ClientID %>", "mobileError", "Enter a valid 10-digit Mobile Number.");
                isValid = false;
            }


            if (!role) {
                setError("<%= ddlRole.ClientID %>", "roleError", "Please select a Role.");
                isValid = false;
            }

            return isValid;
        }

        function setError(inputId, errorId, message) {
            let inputElement = document.getElementById(inputId);
            document.getElementById(errorId).innerText = message;
            inputElement.style.border = "2px solid red";
        }

        // Auto-remove red border when user starts typing
        document.addEventListener("DOMContentLoaded", function () {
            var inputs = document.querySelectorAll(".form-control");
            inputs.forEach(function (input) {
                input.addEventListener("input", function () {
                    this.style.border = "1px solid #ced4da";
                    var errorElementId = this.id + "Error";
                    document.getElementById(errorElementId).innerText = "";
                });
            });
        });
    </script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</asp:Content>
