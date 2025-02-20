<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedbackForm.aspx.cs" Inherits="employeefeedback.FeedbackForm" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Employee Feedback</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <link rel="stylesheet" href="feedbackfromstyle.css" />

    <script>
        function selectRating(value) {
            document.getElementById('<%= hdnRating.ClientID %>').value = value;

            // Remove selection from all circles
            let circles = document.querySelectorAll(".rating-circle");
            circles.forEach(circle => circle.classList.remove("selected"));

            // Highlight selected circle
            document.getElementById("circle-" + value).classList.add("selected");
        }


    </script>

</head>
<body>
    <form runat="server">
        <div class="container">
            <!-- Logo at the Top -->
            <div class="logo-container" title="Employee Feedback System">
                <img src="Images/logoefspic.jpg" alt="Company Logo" width="85px" height="65px">
            </div>

            <h3 class="text-center mt-3">Feedback Form</h3>

            <div class="row justify-content-center">
                <div class="col-md-6">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" CssClass="d-block text-center mb-3"></asp:Label>

                    <!-- Customer Name -->
                    <div class="form-group">
                       
                        <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" Placeholder="Full Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerName" runat="server" ControlToValidate="txtCustomerName"
                            ErrorMessage="Please enter full name." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Customer Mobile -->
                    <div class="form-group">
                       
                        <asp:TextBox ID="txtCustomerMobile" runat="server" CssClass="form-control" Placeholder="Mobile No."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerMobile" runat="server" ControlToValidate="txtCustomerMobile"
                            ErrorMessage="Please enter Mobile no." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtCustomerMobile"
                            ValidationExpression="^\d{10}$" ErrorMessage="Please enter valid Mobile no." CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <!-- Rating System (5 Circles) -->
                    <div class="form-group text-center ">
                        <label for="rating">How likely are you to recommend our services?</label>
                        <div class="rating-container">
                            <span id="circle-1" class="rating-circle m-1" onclick="selectRating(1)">1</span>
                            <span id="circle-2" class="rating-circle m-1" onclick="selectRating(2)">2</span>
                            <span id="circle-3" class="rating-circle m-1" onclick="selectRating(3)">3</span>
                            <span id="circle-4" class="rating-circle m-1" onclick="selectRating(4)">4</span>
                            <span id="circle-5" class="rating-circle m-1" onclick="selectRating(5)">5</span>
                        </div>


                         
    
                            <div class="row">
                                <div class="col-6 ">
                                    <label for="rating">1-Extremly Unlikely</label>
                                </div>

                                <div class="col-6 position-relative"> 
                                    <label for="rating">5-Extremly Likely</label>
                                
                                </div>
                            </div>  
                        

                        <!-- Hidden field to store rating -->
                        <asp:HiddenField ID="hdnRating" runat="server" />
                    </div>

                    <!-- Comments -->
                    <div class="form-group">
                        
                          <asp:TextBox ID="txtComments" runat="server" CssClass="form-control fixedsize" TextMode="MultiLine" Rows="4" Placeholder="Please write the feedback"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvComments" runat="server" ControlToValidate="txtComments"
                            ErrorMessage="Please enter your comments." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                   

                    </div>

                    <!-- Submit Button -->
                    <div class="text-center">
                        <asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" OnClick="btnSubmitFeedback_Click" />
                    </div>
                </div>
            </div>
        
    </form>
</body>
</html>
