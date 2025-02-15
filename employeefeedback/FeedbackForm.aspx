<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedbackForm.aspx.cs" Inherits="employeefeedback.FeedbackForm" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Employee Feedback</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        /* Center Logo */
        .logo-container {
            text-align: center;
            margin-top: 20px;
        }

        .logo-container img {
            max-width: 180px; /* Adjust size as needed */
        }

        /* Rating Styles */
        .rating-container {
            text-align: center;
            margin: 20px 0;
        }

        .rating-circle {
            display: inline-block;
            width: 50px;
            height: 50px;
            line-height: 50px;
            border-radius: 50%;
            background: #ddd;
            text-align: center;
            font-weight: bold;
            font-size: 20px;
            cursor: pointer;
            margin: 8px;
            transition: background 0.3s, transform 0.2s;
        }

        .rating-circle.selected {
            background: #007bff;
            color: #fff;
            transform: scale(1.1);
        }
    </style>
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
                <img src="Images/logoefs.jpg" alt="Company Logo" width="100px" height="100px">
            </div>

            <h2 class="text-center mt-3">Feedback Form</h2>

            <div class="row justify-content-center">
                <div class="col-md-6">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" CssClass="d-block text-center mb-3"></asp:Label>

                    <!-- Customer Name -->
                    <div class="form-group">
                        <label for="txtCustomerName">Your Name</label>
                        <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" Placeholder="Enter your name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerName" runat="server" ControlToValidate="txtCustomerName"
                            ErrorMessage="Please enter your name." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Customer Mobile -->
                    <div class="form-group">
                        <label for="txtCustomerMobile">Your Mobile Number</label>
                        <asp:TextBox ID="txtCustomerMobile" runat="server" CssClass="form-control" Placeholder="Enter your mobile number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerMobile" runat="server" ControlToValidate="txtCustomerMobile"
                            ErrorMessage="Mobile number is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtCustomerMobile"
                            ValidationExpression="^\d{10}$" ErrorMessage="Enter a valid 10-digit mobile number" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <!-- Rating System (5 Circles) -->
                    <div class="form-group text-center">
                        <label for="rating">How Likely Are You To Recommend Our Services?</label>
                        <div class="rating-container">
                            <span id="circle-1" class="rating-circle" onclick="selectRating(1)">1</span>
                            <span id="circle-2" class="rating-circle" onclick="selectRating(2)">2</span>
                            <span id="circle-3" class="rating-circle" onclick="selectRating(3)">3</span>
                            <span id="circle-4" class="rating-circle" onclick="selectRating(4)">4</span>
                            <span id="circle-5" class="rating-circle" onclick="selectRating(5)">5</span>
                        </div>


                         <div class="pt-1">
    
                            <div class="row">
                                <div class="col-6 ">
                                    <label for="rating">0-Extremly Unlikely</label>
                                </div>

                                <div class="col-6 position-relative"> 
                                    <label for="rating">5-Extremly Likely</label>
                                
                                </div>
                            </div>  
                        </div>

                        <!-- Hidden field to store rating -->
                        <asp:HiddenField ID="hdnRating" runat="server" />
                    </div>

                    <!-- Comments -->
                    <div class="form-group">
                        
                        <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Write your feedback here"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvComments" runat="server" ControlToValidate="txtComments"
                            ErrorMessage="Please enter your comments." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Submit Button -->
                    <div class="text-center">
                        <asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit Feedback" CssClass="btn btn-primary btn-block" OnClick="btnSubmitFeedback_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
