using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected int employeeId;

        protected void Page_Load(object sender, EventArgs e)
        {
            FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                employeeId = Convert.ToInt32(Session["EmployeeID"]);
                LoadEmployeeData(employeeId);
            }
        }

        private void LoadEmployeeData(int empId)
        {
            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT Name, Mobile, UserName, Address, Photo FROM Employee WHERE EmployeeID = @EmployeeID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", empId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string[] nameParts = reader["Name"].ToString().Split(' ');
                        txtFirstName.Text = nameParts[0];
                        txtLastName.Text = nameParts.Length > 1 ? nameParts[1] : "";
                        txtMobile.Text = reader["Mobile"].ToString();
                        txtUsername.Text = reader["UserName"].ToString();
                        txtUsername.ReadOnly = true; // Prevent editing
                        txtAddress.Text = reader["Address"].ToString();

                       
                       
                        hfPhotoPath.Value = reader["Photo"].ToString();
                    }
                    else
                    {
                        Response.Write("<script>alert('Employee not found!');</script>");
                    }
                    con.Close();
                }
            }
        }

       

        private string SavePhoto(HttpPostedFile file)
        {
           
            if (file.ContentLength > 102400)
            {
                lblMessage.Text = "Photo size should be less than 100KB.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return null;
            }

           
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png" };
            string fileExt = Path.GetExtension(file.FileName).ToLower();

            if (Array.IndexOf(allowedExtensions, fileExt) == -1)
            {
                lblMessage.Text = "Only JPG, JPEG, and PNG formats are allowed.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return null;
            }

         
            string fileName = "Photo_" + Guid.NewGuid().ToString() + fileExt;
            string filePath = Server.MapPath("~/Images/Employees/") + fileName;

           
            file.SaveAs(filePath);

          
            return "Images/Employees/" + fileName;
        }

        protected void btnUpdate_Click1(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            int empId = Convert.ToInt32(Session["EmployeeID"]);
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string name = firstName + " " + lastName;
            string mobile = txtMobile.Text.Trim();
            string username = txtUsername.Text.Trim(); 
            
            string address = txtAddress.Text.Trim();
            string updatedBy = Session["UserName"].ToString();

            string photoFileName;

            if (fulPhoto.HasFile)
            {
                photoFileName = SavePhoto(fulPhoto.PostedFile);
            }

            else
            {
                photoFileName = hfPhotoPath.Value;
            }

            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {

                string checkQuery = "SELECT COUNT(*) FROM Employee WHERE EmployeeID = @EmployeeID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@EmployeeID", empId);
                con.Open();
                int count = (int)checkCmd.ExecuteScalar();
                con.Close();

                if (count == 0)
                {
                    // Debugging: Log the employee not found error
                    Response.Write("<script>alert('Employee with EmployeeID " + empId + " not found!');</script>");
                    return;
                }

                string query = "UPDATE Employee SET Name=@Name, Mobile=@Mobile, Address=@Address," +
                               "Photo=@Photo, UpdateBy=@UpdateBy, UpdateAt=GETDATE() WHERE EmployeeID=@EmployeeID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Address", address);
                    
                    cmd.Parameters.AddWithValue("@Photo", photoFileName);
                    cmd.Parameters.AddWithValue("@UpdateBy", updatedBy);
                    cmd.Parameters.AddWithValue("@EmployeeID", empId);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rowsAffected > 0)
                    {
                        Response.Write("<script>alert('Profile updated successfully!'); window.location='Profile.aspx';</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('No changes were made!');</script>");
                    }
                }
            }
        }
    }
}
