<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/HeaderFooter.Master" CodeBehind="About.aspx.cs" Inherits="employeefeedback.About" %>


 

      <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server"> 
             <style>
       body {
           background-color: white
       }
      
       .section {
           margin-top: 30px;
           padding: 20px;
           background: #f8f9fa;
           
         
       }
    
   </style>
           <div class="mt-5 p-1 section">
    
            <div class="row">
                 <div class="col">
                     <h3 class=" text-uppercase text-center">about</h3>
                 </div> 
              </div>  
            </div>

        

            <div class="section">
                <h4>What is the Employee Feedback System?</h4>
                <p>The Employee Feedback System is a web-based platform that allows businesses to collect and manage customer feedback on employees. Customers can scan a QR code to submit their ratings and comments, while administrators can review and analyze feedback.</p>
            </div>

            <div class="section">
                <h4>How to Use?</h4>
                
                <h5>For Customers:</h5>
                <ul>
                    <li>Scan the QR code assigned to an employee.</li>
                    <li>Fill in your details (name, mobile number).</li>
                    <li>Select a rating and provide your comments.</li>
                    <li>Submit the feedback.</li>
                    <li>Receive a confirmation message.</li>
                </ul>

                <h5>For Admins:</h5>
                <ul>
                    <li>Log in to the admin panel.</li>
                    <li>View the dashboard to see employee performance.</li>
                    <li>Add new employees and generate QR codes.</li>
                    <li>Monitor feedback and analyze employee ratings.</li>
                </ul>
            </div>

            <div class="section">
                <h4>Key Features</h4>
                <ul>
                    <li>Customer feedback submission via QR codes.</li>
                    <li>Admin panel for managing employees and viewing feedback.</li>
                    <li>Real-time feedback tracking and analytics.</li>
                    <li>Secure authentication for admins.</li>
                </ul>
            </div>    
    </asp:Content>

