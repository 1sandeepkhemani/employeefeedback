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
                    // Validate Employee ID against the database
                    if (IsEmployeeIdValid(empId))
                    {
                        ViewState["EmployeeID"] = empId; // Store Employee ID
                    }
                    else
                    {
                        Response.Redirect("ErrorPage.aspx");
                    }
                }
                else
                {
                    Response.Redirect("ErrorPage.aspx");
                }
            }
        }

        private bool IsEmployeeIdValid(int empId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM Employee WHERE EmployeeID = @EmployeeID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", empId);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0; // Return true if employee ID exists in the database
                }
            }
        }

        protected void ValidateRating(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !string.IsNullOrEmpty(hdnRating.Value) && int.TryParse(hdnRating.Value, out _);
        }

        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hdnRating.Value) || !int.TryParse(hdnRating.Value, out _))
            {
                // Show alert if rating is not selected
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a rating before submitting.');", true);
                return;
            }


            if (Page.IsValid)
            {
                int empId = Convert.ToInt32(ViewState["EmployeeID"]);
                string customerName = txtCustomerName.Text.Trim();
                string customerMobile = txtCustomerMobile.Text.Trim();
                int rating = int.Parse(hdnRating.Value);
                string comments = txtComments.Text.Trim();

                // Capture UTC time when the feedback is submitted
                DateTime utcTime = DateTime.UtcNow; // Current UTC time

                // Convert the UTC time to IST
                TimeZoneInfo istTimeZone = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
                DateTime istTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, istTimeZone);

                // Format IST time to string (if required by the database format)
                string istTimeFormatted = istTime.ToString("yyyy-MM-dd HH:mm:ss");

                // Database connection and insertion
                string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Feedback (EmployeeID, CustomerName, CustomerMobile, Rating, Comments, FeedbackDate) " +
                                   "VALUES (@EmployeeID, @CustomerName, @CustomerMobile, @Rating, @Comments, @FeedbackDate)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", empId);
                        cmd.Parameters.AddWithValue("@CustomerName", customerName);
                        cmd.Parameters.AddWithValue("@CustomerMobile", customerMobile);
                        cmd.Parameters.AddWithValue("@Rating", rating);
                        cmd.Parameters.AddWithValue("@Comments", comments);
                        cmd.Parameters.AddWithValue("@FeedbackDate", istTimeFormatted); // Store IST time in formatted string

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
