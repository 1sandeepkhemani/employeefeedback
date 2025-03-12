using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class ChangePassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure user is logged in
            FunctionFile.PageLoad(Response, Session);
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string employeeid = Session["EmployeeID"]?.ToString();
            if (string.IsNullOrEmpty(employeeid))
            {
                FunctionFile.Logout(Response, Session, Request); // Logout if session is invalid
                return;
            }

            string currentPassword = txtCurrentPassword.Text;
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (newPassword != confirmPassword)
            {
                ShowAlert("New password and confirm password do not match!");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Get the stored hashed password
                string query = "SELECT Password FROM Employee WHERE EmployeeID = @EmployeeID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeid);
                string storedHashedPassword = cmd.ExecuteScalar()?.ToString();

                if (storedHashedPassword == null)
                {
                    ShowAlert("User not found!");
                    return;
                }

                // Verify current password
                if (storedHashedPassword != FunctionFile.HashPassword(currentPassword))
                {
                    ShowAlert("Current password is incorrect!");
                    return;
                }

                // Update with new hashed password
                string updateQuery = "UPDATE Employee SET Password = @NewPassword WHERE EmployeeID = @EmployeeID";
                SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                updateCmd.Parameters.AddWithValue("@NewPassword", FunctionFile.HashPassword(newPassword));
                updateCmd.Parameters.AddWithValue("@EmployeeID", employeeid);

                int rowsAffected = updateCmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    // Ensure session is cleared before redirecting
                    Session.Abandon();
                    Session.Clear();
                    Response.Cookies.Clear();

                    // Use a delay to allow the browser to process the alert before redirecting
                    ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                        "alert('Password changed successfully!'); window.location='Default.aspx';", true);
                }
                else
                {
                    ShowAlert("Error updating password. Try again!");
                }
            }
        }


        private void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{message}');", true);
        }
    }
}
