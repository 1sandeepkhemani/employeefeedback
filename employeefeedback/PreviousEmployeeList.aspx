<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="PreviousEmployeeList.aspx.cs" Inherits="employeefeedback.PreviousEmployeeList" %>

  <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
      <div class=" bg-light ">
        <div class="mt-5 p-1 pt-3">
    <div class="row align-items-center">
        <div class="col-12 col-md-8">
            <h3 class="text-uppercase">Previous Employee List</h3>
        </div>
        <div class="col-12 col-md-4 d-flex justify-content-md-end align-items-center">
            
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
                 <HeaderStyle CssClass="table-primary text-center"/>
                 <ItemStyle CssClass="text-center" />
             </asp:TemplateField>

        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" >
          <ControlStyle Font-Bold="True" ForeColor="Black" />
          <FooterStyle ForeColor="Black" />
          <HeaderStyle CssClass="table-primary" />
          </asp:BoundField>

        <asp:HyperLinkField DataTextField="Name" DataNavigateUrlFields="EmployeeID"  DataNavigateUrlFormatString="EmployeeDetail.aspx?empId={0}" HeaderText="Employee Name" ControlStyle-CssClass="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" >
<ControlStyle CssClass="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover text-capitalize" Font-Bold="False" Font-Italic="False" ForeColor="Black"></ControlStyle>
          <HeaderStyle CssClass="table-primary" />
          </asp:HyperLinkField>

          <asp:BoundField DataField="Mobile" HeaderText="Mobile No">
                <HeaderStyle CssClass="table-primary" />
              </asp:BoundField>

        <asp:BoundField DataField="RoleName" HeaderText="Role" >
          <HeaderStyle CssClass="table-primary" />
          </asp:BoundField>
       
        

      </Columns>
    </asp:GridView>
                 </div>
                 </div>
                </div>
      </asp:Content>
   

