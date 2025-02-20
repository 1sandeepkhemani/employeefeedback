<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="employeefeedback.AdminLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>Admin Login</title>
  <link href="../Styles/styles.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
</head>
<body>
    <form runat="server">
  <div class="container">
    <h2 class="mt-4">Admin Login</h2>
    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    <div class="form-group">
      <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
    </div>
    <div class="form-group">
      <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password"></asp:TextBox>
    </div>
    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="btnLogin_Click"/>
  </div>

    </form>
</body>
</html>
