using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class FeedbackForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int empId;
                if (int.TryParse(Request.QueryString["empId"], out empId))
                {
                    ViewState["EmployeeID"] = empId; // Store Employee ID
                }
                else
                {
                    lblMessage.Text = "Invalid Employee ID.";
                }
            }
        }

        protected void ValidateRating(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !string.IsNullOrEmpty(hdnRating.Value) && int.TryParse(hdnRating.Value, out _);
        }

        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Ensure all validation checks pass
            {
                int empId = Convert.ToInt32(ViewState["EmployeeID"]);
                string customerName = txtCustomerName.Text.Trim();
                string customerMobile = txtCustomerMobile.Text.Trim();
                int rating = int.Parse(hdnRating.Value);
                string comments = txtComments.Text.Trim();

                string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Feedback (EmployeeID, CustomerName, CustomerMobile, Rating, Comments, FeedbackDate) VALUES (@EmployeeID, @CustomerName, @CustomerMobile, @Rating, @Comments, @FeedbackDate)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", empId);
                        cmd.Parameters.AddWithValue("@CustomerName", customerName);
                        cmd.Parameters.AddWithValue("@CustomerMobile", customerMobile);
                        cmd.Parameters.AddWithValue("@Rating", rating);
                        cmd.Parameters.AddWithValue("@Comments", comments);
                        cmd.Parameters.AddWithValue("@FeedbackDate", DateTime.Now);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Thank you for your feedback!";
                Response.Redirect("ThankYou.aspx");
            }
        }
    }
}
