<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="EmployeeFeedbackDetails.aspx.cs" Inherits="employeefeedback.EmployeeFeedbackDetails" %>

 <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
       
        
             <div class=" bg-light">
                          <div class="mt-5 p-1 pt-3">
    <div class="row align-items-center">
        <div class="col-12 col-md-8">
            <h3 class="text-uppercase">Feedback For Employee- <asp:Label ID="lblEmployeeName" CssClass="text-capitalize" runat="server"></asp:Label></h3>
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
        <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered border-primary table-striped" OnSelectedIndexChanged="gvFeedback_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField HeaderText="Sl No">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <HeaderStyle CssClass="table-primary text-center" />
                    <ItemStyle CssClass="text-center" Width="50px" />
                </asp:TemplateField>

                <asp:BoundField DataField="CustomerName" HeaderText="Customer Name">
                    <ControlStyle Font-Bold="False" ForeColor="Black" CssClass="text-capitalize" />
                    <HeaderStyle CssClass="table-primary" />
                    <ItemStyle CssClass="text-capitalize" Width="15%" />
                </asp:BoundField>

                <asp:BoundField DataField="CustomerMobile" HeaderText="Mobile No">
                    <ControlStyle Font-Bold="False" ForeColor="Black" CssClass="text-capitalize" />
                    <HeaderStyle CssClass="table-primary" />
                    <ItemStyle Width="15%" />
                </asp:BoundField>

                  <asp:TemplateField HeaderText="Rating">
                   <HeaderStyle CssClass="table-primary" Width="15%" />
                      <ItemTemplate>      
                          <div class="star-rating">
                              <span class="stars" data-rating='<%# Eval("Rating") %>'></span>
                              [<%# Eval("Rating") %>]
                          </div>
                      </ItemTemplate>
                      </asp:TemplateField>

                <asp:BoundField DataField="Comments" HeaderText="Comments">
                    <HeaderStyle CssClass="table-primary" />
                    <ItemStyle Width="30%" />
                </asp:BoundField>

                <asp:BoundField DataField="FeedbackDate" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy hh:mm tt}">
                    <HeaderStyle CssClass="table-primary" />
                    <ItemStyle Width="20%" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>

          </div>
 
</div>
        

     <script>
         document.addEventListener("DOMContentLoaded", function () {
             document.querySelectorAll(".stars").forEach(container => {
                 let rating = parseFloat(container.getAttribute("data-rating")) || 0;
                 let starsHTML = "";

                 let starColor = "gray";


                 if (rating <= 2) {
                     starColor = "red";
                 }
                 else if (rating <= 3) {
                     starColor = "#FFA500";
                 }
                 else if (rating <= 4) {
                     starColor = "gold";
                 }
                 else {
                     starColor = "green";
                 }



                 for (let i = 1; i <= 5; i++) {
                     if (i <= Math.floor(rating)) {
                         starsHTML += `<span class="fa fa-star" style="font-size: 20px; color : ${starColor}"></span>`; // Full Star
                     }
                     else if (i - rating < 1) {
                         starsHTML += `<span class="fa fa-star-half-alt" style="font-size: 20px; color : ${starColor}"></span>`; // Half Star
                     }
                     else {
                         starsHTML += `<span class="fa fa-star text-muted" style="font-size: 20px; color : ${starColor}"></span>`; // Empty Star (gray)
                     }
                 }
                 container.innerHTML = starsHTML;
             });
         });
     </script>

</asp:Content>
