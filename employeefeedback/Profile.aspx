<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="Profile.aspx.cs" Inherits="employeefeedback.Profile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-light">
        <div class="mt-5 p-1 pt-3">
            <div class="col d-flex justify-content-center">
                <div class="card w-75 m-4">
                    <div class="card-body p-2">
                        <div class="card-text">
                            <div class="row">
                                <div class="col-lg-3 col-sm-12">
                                    <table class="table table-bordered">
                                        <tr>
                                            <td>
                                                <img id="imgPhoto" runat="server" class="img-thumbnail rounded-circle d-block mx-auto" style="width: 190px; height: 190px; object-fit: fill;" />
                                            </td>
                                        </tr>
                                        <tr class="text-center">
                                            <td>
                                                <div class="col">
                                                    <a class="text-muted" href="#" id="openQrPopup" data-bs-toggle="modal" data-bs-target="#qrModal" data-bs-placement="bottom" title="Open QR">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-qr-code" viewBox="0 0 16 16">
                                                            <path d="M2 2h2v2H2z"/>
                                                            <path d="M6 0v6H0V0zM5 1H1v4h4zM4 12H2v2h2z"/>
                                                            <path d="M6 10v6H0v-6zm-5 1v4h4v-4zm11-9h2v2h-2z"/>
                                                            <path d="M10 0v6h6V0zm5 1v4h-4V1zM8 1V0h1v2H8v2H7V1zm0 5V4h1v2zM6 8V7h1V6h1v2h1V7h5v1h-4v1H7V8zm0 0v1H2V8H1v1H0V7h3v1zm10 1h-1V7h1zm-1 0h-1v2h2v-1h-1zm-4 0h2v1h-1v1h-1zm2 3v-1h-1v1h-1v1H9v1h3v-2zm0 0h3v1h-2v1h-1zm-4-1v1h1v-2H7v1z"/>
                                                            <path d="M7 12h1v3h4v1H7zm9 2v2h-3v-1h2v-1z"/>
                                                        </svg>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-9 col-sm-12">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th>Employee ID</th>
                                            <td><asp:Label ID="lblEmployeeID" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Name</th>
                                            <td><asp:Label ID="lblName" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Mobile</th>
                                            <td><asp:Label ID="lblMobile" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Address</th>
                                            <td><asp:Label ID="lblAddress" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Role</th>
                                            <td><asp:Label ID="lblPosition" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr class="text-center">
                                            <td colspan="2">
                                                <a id="EditProfile" runat="server" class="btn btn-primary btn-sm me-3" href="EditProfile.aspx">Edit Profile</a>
                                                <a id="ChangePassword" runat="server" class="btn btn-primary btn-sm" href="ChangePassword.aspx">Change Password</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- QR Code Modal -->
    <div class="modal fade" id="qrModal" tabindex="-1" aria-labelledby="qrModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="qrModalLabel">QR Code</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <img id="qrImage" class="img-fluid" alt="QR Code" runat="server" />
                </div>
                <div class="modal-footer">
                    <a id="downloadQr" class="btn btn-primary" download="QRCode.png" runat="server">Download</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var qrModal = document.getElementById("qrModal");
            qrModal.addEventListener("show.bs.modal", function () {
                var qrLink = document.getElementById("qrLinkOpen").href; // Get the QR code URL from the hidden link
                var qrImage = document.getElementById("qrImage");
                qrImage.src = qrLink;
                
                var downloadQr = document.getElementById("downloadQr");
                downloadQr.href = qrLink; // Set download link
            });
        });
    </script>
</asp:Content>