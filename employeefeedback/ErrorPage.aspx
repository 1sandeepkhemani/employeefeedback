<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="employeefeedback.ErrorPage" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>404 - Page Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="d-flex justify-content-center align-items-center vh-100 text-center">
    <form runat="server">
        <div>
        <h1 class="display-1 fw-bold">
            <span class="text-primary" style="background: url('https://img.freepik.com/free-vector/realistic-galaxy-background_23-2148991322.jpg'); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Oops!</span>
        </h1>
        <h2 class="fw-bold">404 - PAGE NOT FOUND</h2>
        <p class="text-muted">The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary px-4 py-2" Text="Go to Home" OnClick="Button1_Click" />
    </div>

        </form>

</body>
</html>



