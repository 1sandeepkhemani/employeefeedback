<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="EmployeeList.aspx.cs" Inherits="employeefeedback.EmployeeList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

      <div class=" bg-light ">
  <div class="mt-5 p-1 pt-3">
    <div class="row align-items-center">
        <div class="col-12 col-md-8">
            <h3 class="text-uppercase">Current Employee List</h3>
        </div>
        <div class="col-12 col-md-4 d-flex justify-content-md-end align-items-center">
            <a class="btn btn-outline-primary btn-sm me-3" data-bs-toggle="tooltip" data-bs-placement="left" title="Add Employee" href="AddEmployee.aspx">Add</a>
            <div class="input-group">
                <input class="form-control form-control-sm" type="search" placeholder="Search" aria-label="Search" style="min-width: 200px;">
                <button class="btn btn-outline-primary btn-sm" type="submit">Search</button>
            </div>
        </div>
    </div>
</div>


             <div class="p-1">
   
    <div class="table-responsive">
        <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered border-primary table-striped">
            <Columns>
                <asp:TemplateField HeaderText="SL No">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <HeaderStyle CssClass="table-primary text-center" />
                    <ItemStyle CssClass="text-center" />
                </asp:TemplateField>

                <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID">
                    <HeaderStyle CssClass="table-primary" />
                    <ItemStyle Font-Bold="False" />
                </asp:BoundField>

                <asp:HyperLinkField DataTextField="Name" DataNavigateUrlFields="EmployeeID" DataNavigateUrlFormatString="EmployeeDetail.aspx?empId={0}" HeaderText="Employee Name">
                    <ControlStyle CssClass="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover text-capitalize" Font-Bold="False" Font-Italic="False" ForeColor="Black" />
                    <HeaderStyle CssClass="table-primary" />
                </asp:HyperLinkField>

                <asp:BoundField DataField="Mobile" HeaderText="Mobile No">
                    <HeaderStyle CssClass="table-primary" />
                </asp:BoundField>

                <asp:BoundField DataField="RoleName" HeaderText="Role">
                    <HeaderStyle CssClass="table-primary" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <div class="d-flex justify-content-center align-items-center">
                            <a href='<%# Eval("EmployeeID", "EmployeeEdit.aspx?empId={0}") %>' class="btn btn-sm me-2 d-inline-flex align-items-center justify-content-center" data-bs-toggle="tooltip" title="Edit Employee">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                                </svg>
                            </a>

                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm d-inline-flex align-items-center justify-content-center" CommandArgument='<%# Eval("EmployeeID") %>' OnClientClick="return confirmDelete(this);" data-bs-toggle="tooltip" title="Delete Employee" OnClick ="btnDelete_Click">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                    <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                    <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                </svg>
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle CssClass="table-primary text-center" />
                    <ItemStyle CssClass="text-center" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    </div>
</div>
   
    <script>
        function confirmDelete(btn) {
            var employeeId = btn.getAttribute("CommandArgument");
            // Show confirmation dialog
            if (confirm("Are you sure you want to delete this employee?")) {
                // If user clicks "Yes", trigger the delete action on the server
                __doPostBack(btnDelete_Click, employeeId);
            } else {
                // If user clicks "No", prevent postback (no deletion)
                return false;
            }
        }

    </script>

</asp:Content>

