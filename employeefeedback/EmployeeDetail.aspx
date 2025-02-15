<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeDetail.aspx.cs" Inherits="employeefeedback.EmployeeDetail" %>

<!DOCTYPE html>
<html lang="en">
<head>
   
    <title>Employee Details</title>
    
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>

  

    
</head>
<body>

    <div class="container p-1">

    <form runat="server">
       
 <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">
        
         <a href="dashboard.aspx" class="navbar-brand d-flex align-items-center ms-3" data-bs-toggle="tooltip" data-bs-placement="right" title="Employee Feedback System">
              <img src="Images\logoefs.jpg" alt="Logo" class="img-fluid rounded-circle me-2" style="width: 85px; height: 65px;">
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
                             <asp:LinkButton ID="lbLogout" runat="server" CssClass="dropdown-item" OnClick="lbLogout_Click">
                                 Logout
                             </asp:LinkButton>
                         </li>
                     </ul>
                 </li>
             </ul>
         </div>
     </div>
 </nav>



             <div class=" bg-light">
                <div class="mt-5 p-1 pt-3">
        

                 <div class="col d-flex justify-content-center"> 

                    <div class="card  w-50 m-4" >
                        <asp:Image ID="imgQRCode" runat="server" CssClass="rounded mx-auto d-block w-50" />
                
 
                    <div class="card-body  p-2">
                     <div class="card-text">
                        <div class="row">
                            <div class="col-lg-4 col-sm-12">
                                <img id="imgPhoto" runat="server" class="employee-photo img-fluid img-thumbnail h-75 w-100" />
                            </div>
                            <div class="col-lg-8  col-sm-12">
                                        <table class="table table-bordered">
                                        <tr><th> <a id="qrLink" runat="server" class="btn btn-primary btn-sm" target="_blank">Feedback Form</a></th><td>                          <div class="col text-center"  onclick="downloadQRCode()">
                                        <a class="text-muted" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-qr-code" viewBox="0 0 16 16" data-bs-toggle="tooltip" data-bs-placement="right" title="Download QR">
                                        <path d="M2 2h2v2H2z"/>
                                        <path d="M6 0v6H0V0zM5 1H1v4h4zM4 12H2v2h2z"/>
                                        <path d="M6 10v6H0v-6zm-5 1v4h4v-4zm11-9h2v2h-2z"/>
                                        <path d="M10 0v6h6V0zm5 1v4h-4V1zM8 1V0h1v2H8v2H7V1zm0 5V4h1v2zM6 8V7h1V6h1v2h1V7h5v1h-4v1H7V8zm0 0v1H2V8H1v1H0V7h3v1zm10 1h-1V7h1zm-1 0h-1v2h2v-1h-1zm-4 0h2v1h-1v1h-1zm2 3v-1h-1v1h-1v1H9v1h3v-2zm0 0h3v1h-2v1h-1zm-4-1v1h1v-2H7v1z"/>
                                        <path d="M7 12h1v3h4v1H7zm9 2v2h-3v-1h2v-1z"/>
                                        </svg></a>

                                </td></tr>
                                <tr><th>Employee ID</th><td><asp:Label ID="lblEmployeeID" runat="server"></asp:Label></td></tr>
                                <tr><th>Name</th><td><asp:Label ID="lblName" runat="server"></asp:Label></td></tr>
                                <tr><th>Mobile</th><td><asp:Label ID="lblMobile" runat="server"></asp:Label></td></tr>
                                <tr><th>Address</th><td><asp:Label ID="lblAddress" runat="server"></asp:Label></td></tr>
                                <tr><th>Position</th><td><asp:Label ID="lblPosition" runat="server"></asp:Label></td></tr>
                    
                                </table>
                        </div>
           
                    </div>
        
                    </div>
                  </div>
                </div>

                    </div>


                        </div>
                         </div>
    
    </form>

    
        <footer class="d-flex flex-wrap justify-content-between align-items-center p-3 my-4 border-top  bg-light">
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
    <script>
    $(document).ready(function () {
        $('[data-bs-toggle="tooltip"]').tooltip();
    });
    </script>

    <script>
        function downloadQRCode() {
            var qrImage = document.getElementById('<%= imgQRCode.ClientID %>').src;
            var link = document.createElement('a');
            link.href = qrImage;
            link.download = 'QRCode.png';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>
</body>
</html>
