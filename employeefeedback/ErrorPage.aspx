<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="employeefeedback.ErrorPage" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>Employee Feedback System</title>
   <link rel="icon" type="image/png" href="Images/fulllogoefs.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="d-flex justify-content-center align-items-center vh-100 text-center">
    <form runat="server">
        <div>
        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="Red" class="bi bi-exclamation-triangle-fill" viewBox="0 0 16 16">
          <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5m.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
        </svg>
        <h2 class="fw-bold">404 - PAGE NOT FOUND</h2>
        <p class="text-muted">The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary px-4 py-2" Text="Go to Home" OnClick="Button1_Click" />
    </div>

        </form>

</body>
</html>



