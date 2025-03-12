using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

namespace employeefeedback
{
    public partial class Default : Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserName"] != null && Session["Role"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }

            lblMessage.Text = "";
        }




        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Username and Password are required!";
                return;
            }

            string hashedPassword = FunctionFile.HashPassword(password);
            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string query = "SELECT EmployeeID, UserName, Password, Role, Active FROM Employee WHERE UserName = @UserName";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserName", username);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    string storedPasswordHash = reader["Password"].ToString();
                    int roleId = Convert.ToInt32(reader["Role"]);
                    int active = Convert.ToInt32(reader["Active"]);
                    int empId = Convert.ToInt32(reader["EmployeeID"]);

                    if (active == 0)
                    {
                        lblMessage.Text = "Your account is deactivated.";
                        return;
                    }

                    if (storedPasswordHash == hashedPassword)
                    {
                        // Map RoleID to RoleName using FunctionFile.GetRoleNameById
                        string roleName = FunctionFile.GetRoleNameById(roleId);

                        Session["UserName"] = username;
                        Session["Role"] = roleName;
                        Session["EmployeeID"] = empId;

                        if (roleName == "Admin")
                        {
                            Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("EmployeeDashboard.aspx?EmployeeID=" + empId);
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Invalid username or password.";
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password.";
                }
            }
        }


        private void refresh()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            lblMessage.Text = "";
        }
    }
}
