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

        // Hash Password using SHA-256
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
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

           
            string hashedPassword = HashPassword(password);

        
            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;


            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                  
                    string query = "SELECT EmployeeID, UserName, Password, Role, Active FROM Employee WHERE UserName = @UserName";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserName", username);

                    // Execute the query and read the result
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        string storedPasswordHash = reader["Password"].ToString();
                        string role = reader["Role"].ToString();
                        int active = Convert.ToInt32(reader["Active"]);
                        int empId = Convert.ToInt32(reader["EmployeeID"]);  // Get EmployeeID

                        // Check if the account is deactivated
                        if (active == 0)
                        {
                            lblMessage.Text = "Your account is deactivated.";
                            return;
                        }

                     
                        if (storedPasswordHash == hashedPassword)
                        {
                           
                            Session["UserName"] = username;
                            Session["Role"] = role;
                            Session["EmployeeID"] = empId; 

                           
                            if (role == "Admin")
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
                        // User not found
                        lblMessage.Text = "Invalid username or password.";
                    }
                }
                catch (Exception ex)
                {
                  
                    lblMessage.Text = "An error occurred while processing your request.";
                  
                }

            }

            refresh();
        }

        private void refresh()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            lblMessage.Text = "";
        }
    }
}
