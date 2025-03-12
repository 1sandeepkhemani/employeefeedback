<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="EmployeeDashboard.aspx.cs" Inherits="employeefeedback.EmployeeDashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
           <div class=" bg-light">
            <div class="mt-5 p-1 pt-3">
               
               <div class="row">
                    <div class="col-12 ">
                         <h3 class=" text-uppercase">Employee Dashboard</h3>
                    </div>

                   
             </div>  
           </div>
               <br />
            <div class="p-1">
    <div class="container">
        <div class="row justify-content-center text-center">
            <asp:Repeater ID="rptDashboard" runat="server">
                    <ItemTemplate>
                        <div class="row mb-3">
                            <div class="col-md-4 text-center">
                                <img src='<%# Eval("Photo") %>' class="img-thumbnail rounded-circle" style="width: 150px; height: 150px; object-fit:fill;" />
                                <h5 class="mt-2">
                                 <asp:HyperLink ID="hlName" runat="server" NavigateUrl='<%# "Profile.aspx" %>' CssClass="text-decoration-none text-capitalize">
                                <%# Eval("Name") %>
                                 </asp:HyperLink>
                                     </h5>
                                <p class="text-muted"><%# Eval("RoleName") %></p>
                            </div>

                            <div class="col-md-8">
                                <div class="row text-center">
                                   
                                    <div class="col-md-12">
                                        <div class="card border-success">
                                            <div class="card-body">
                                                <h5 class="card-title text-success">
                                                  <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "EmployeeFeedbackDetails.aspx?empId=" + Eval("EmployeeID") %>' CssClass="text-decoration-none text-capitalize card-title text-success" Text="Rating">   
                                                    </asp:HyperLink>
                                                </h5>
                                                <h3>
                                                    <span class="stars" data-rating='<%# Eval("AverageRating") %>'></span>
                                                    [<%# Eval("AverageRating", "{0:N2}") %>/<%# Eval("TotalFeedback") %>]</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                
        </div>

    </div>

                <canvas id="feedbackChart" class="mt-4"></canvas>

                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        function renderChart(labels, ratings) {
            var ctx = document.getElementById("feedbackChart").getContext("2d");
            var chart = new Chart(ctx, {
                type: 'line', // Can be bar, line, etc.
                data: {
                    labels: labels, // X-axis labels
                    datasets: [{
                        label: 'Ratings',
                        data: ratings, // Y-axis data
                        borderColor: 'rgba(95, 192, 192, 1)',
                        fill: false
                    }]
                },
                options: {
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Feedback Date'
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Rating'
                            }
                        }
                    }
                }
            });
        }

    </script>

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
                else if (rating < 3.5) {
                    starColor = "#FFA500";
                }
                else if (rating < 4.5) {
                    starColor = "gold";
                }
                else {
                    starColor = "green";
                }



                for (let i = 1; i <= 5; i++) {
                    if (i <= Math.floor(rating)) {
                        starsHTML += `<span class="fa fa-star" style="font-size: 25px; color : ${starColor}"></span>`; // Full Star
                    }
                    else if (i - rating < 1 && i - rating >= 0.5 || i - rating <= 0.5) {
                        starsHTML += `<span class="fa fa-star-half-alt" style="font-size: 25px; color : ${starColor}"></span>`; // Half Star
                    }
                    else {
                        starsHTML += `<span class="fa fa-star text-muted" style="font-size: 25px; color : ${starColor}"></span>`; // Empty Star (gray)
                    }
                }
                container.innerHTML = starsHTML;
            });
        });
    </script>
    
</asp:Content>
