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
    public partial class EmployeeEdit : Page
    {
        int employeeId;

        protected void Page_Load(object sender, EventArgs e)
        {
           FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {
                string empIdQuery = Request.QueryString["empId"];

                // Check if empId query string is missing or invalid
                if (string.IsNullOrEmpty(empIdQuery) || !int.TryParse(empIdQuery, out int empId) || empId <= 0)
                {
                    Response.Write("<script>alert('Invalid or missing Employee ID!');</script>");
                    return;
                }

                employeeId = empId;
                LoadEmployeeData(employeeId);
               
            }
        }

       

        private void LoadEmployeeData(int empId)
        {
            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT Name, Mobile, UserName, Address, Role, Photo FROM Employee WHERE EmployeeID = @EmployeeID";
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
                        txtUsername.ReadOnly = true;  // Prevent editing
                        txtAddress.Text = reader["Address"].ToString();
                        int roleId = Convert.ToInt32(reader["Role"]);

                        
                        LoadRoles(roleId);


                        // Store current photo path in hidden field
                        hfPhotoPath.Value = reader["Photo"].ToString();
                    }
                    else
                    {
                        // Debugging: Log the error when employee is not found
                        Response.Write("<script>alert('Employee with EmployeeID " + empId + " not found!');</script>");
                    }
                    con.Close();
                }
            }
        }

        private void LoadRoles(int selectedRoleId)
        {
            try
            {
               
                string rolesJson = File.ReadAllText(Server.MapPath("roles.json"));
                var roles = JsonConvert.DeserializeObject<List<Role>>(rolesJson);

             
                ddlRole.Items.Clear();
                foreach (var role in roles)
                {
                    ddlRole.Items.Add(new ListItem(role.RoleName, role.RoleId.ToString()));
                }

                
                ListItem selectedItem = ddlRole.Items.FindByValue(selectedRoleId.ToString());
                if (selectedItem != null)
                {
                    ddlRole.SelectedValue = selectedItem.Value;
                }
                else
                {
                    ddlRole.SelectedIndex = 0; 
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error reading roles file: " + ex.Message + "');</script>");
            }
        }

        private string SavePhoto(HttpPostedFile file)
        {
            // Check if the file size is greater than 100 KB (102400 bytes)
            if (file.ContentLength > 102400)
            {
                // If the file size exceeds 100 KB, show a message in the label
                lblMessage.Text = "Photo size should be less than 100KB.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return null; // Return null if the file is not saved
            }

            // Get the file extension and generate a unique filename
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = "Photo_" + Guid.NewGuid().ToString() + fileExt;
            string filePath = Server.MapPath("~/Images/Employees/") + fileName;

            // Save the file to the specified path
            file.SaveAs(filePath);

            // Return the relative file path
            return "Images/Employees/" + fileName;
        }


        protected void btnUpdate_Click1(object sender, EventArgs e)
        {

            string empIdQuery = Request.QueryString["empId"];

            if (string.IsNullOrEmpty(empIdQuery) || !int.TryParse(empIdQuery, out int empId) || empId <= 0)
            {
                Response.Write("<script>alert('Invalid or missing Employee ID!');</script>");
                return;
            }


            try
            {
                string firstName = txtFirstName.Text.Trim();
                string lastName = txtLastName.Text.Trim();
                string name = firstName + " " + lastName;
                string mobile = txtMobile.Text.Trim();
                string username = txtUsername.Text.Trim(); // Not editable but still needed
                string role = ddlRole.SelectedValue;
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
                    // First, check if EmployeeID exists
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

                    // Now update the record
                    string query = "UPDATE Employee SET Name=@Name, Mobile=@Mobile, Address=@Address, Role=@Role, " +
                                   "Photo=@Photo, UpdateBy=@UpdateBy, UpdateAt=GETDATE() WHERE EmployeeID=@EmployeeID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Mobile", mobile);
                        cmd.Parameters.AddWithValue("@Address", address);
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@Photo", photoFileName);
                        cmd.Parameters.AddWithValue("@UpdateBy", updatedBy);
                        cmd.Parameters.AddWithValue("@EmployeeID", empId);

                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Employee updated successfully!'); window.location='EmployeeList.aspx';</script>");
                        }
                        else
                        {
                            // Debugging: Log the case where no rows are affected
                            Response.Write("<script>alert('No changes were made!');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}
