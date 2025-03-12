<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="ChangePassword.aspx.cs" Inherits="employeefeedback.ChangePassword" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-light">
        <div class="mt-5 p-1 pt-3">
            <div class="row">
                <div class="col">
                    <h3 class="text-uppercase p-1">Change Password</h3>
                </div>
            </div>
        </div>

        <div class="p1">
            <div class="container mt-3">
                
                <div class="mb-3">
                    <label for="txtCurrentPassword">Current Password:</label>
                  
                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                     
                    <span id="currentPasswordError" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label for="txtNewPassword">New Password:</label>
                   
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    
                    <span id="newPasswordError" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label for="txtConfirmPassword">Confirm New Password:</label>
                   
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    
                    <span id="confirmPasswordError" class="text-danger"></span>
                </div>

                <asp:Button ID="btnChangePassword" runat="server" CssClass="btn btn-primary" Text="Change Password" OnClientClick="return validateForm();" OnClick="btnChangePassword_Click" />
            </div>
        </div>
    </div>

  <script>
      function validateForm() {
          var currentPassword = document.getElementById('<%= txtCurrentPassword.ClientID %>');
        var newPassword = document.getElementById('<%= txtNewPassword.ClientID %>');
        var confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>');

          var isValid = true;

          // Clear previous errors and reset border color
          resetError(currentPassword, "currentPasswordError");
          resetError(newPassword, "newPasswordError");
          resetError(confirmPassword, "confirmPasswordError");

          // Validate Current Password
          if (currentPassword.value.trim() === "") {
              setError(currentPassword, "currentPasswordError", "Current password is required.");
              isValid = false;
          }

          // Validate New Password
          if (newPassword.value.trim() === "") {
              setError(newPassword, "newPasswordError", "New password is required.");
              isValid = false;
          } else if (newPassword.value.trim().length < 6) {
              setError(newPassword, "newPasswordError", "Password must be at least 6 characters long.");
              isValid = false;
          }

          // Validate Confirm Password
          if (confirmPassword.value.trim() === "") {
              setError(confirmPassword, "confirmPasswordError", "Please confirm your new password.");
              isValid = false;
          } else if (newPassword.value.trim() !== confirmPassword.value.trim()) {
              setError(confirmPassword, "confirmPasswordError", "Passwords do not match.");
              isValid = false;
          }

          return isValid;
      }

      // Function to set error message and apply red border
      function setError(inputElement, errorElementId, message) {
          inputElement.style.border = "2px solid red"; // Apply red border
          document.getElementById(errorElementId).innerText = message; // Show error message
      }

      // Function to reset error messages and border
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
