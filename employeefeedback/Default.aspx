<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="employeefeedback.Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login - Employee Feedback System</title>

 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body class="d-flex align-items-center justify-content-center vh-100 ">

    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-center">
                <div>
                    
                   
                    <div class="text-center mb-4">
                        <img src="Images/logoefspic.jpg" alt="Company Logo" class="img-fluid mb-2" style="max-width: 120px;">
                        <h3 class="fw-bold">Employee Feedback System</h3>
                    </div>

                   
                    <div class="card p-4 shadow-lg rounded">
                        <h4 class="text-center mb-3">Login</h4>
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="d-block text-center mb-2"></asp:Label>

                        <div class="mb-3">
                            <label for="<%= txtUsername.ClientID %>" class="form-label">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Enter your username"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="<%= txtPassword.ClientID %>" class="form-label">Password</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter your password"></asp:TextBox>
                                <button type="button" class="btn btn-outline-secondary" id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-block w-100" OnClick="btnLogin_Click"/>
                    </div>

                    
                </div>
            </div>
        </div>
    </form>

    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>

    <!-- Password Toggle Script -->
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