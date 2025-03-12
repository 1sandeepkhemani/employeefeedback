using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using QRCoder;

namespace employeefeedback
{
    public partial class AddEmployee : Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {
                LoadRoles();
            }
        }

        private void LoadRoles()
        {
            // Path to the JSON file
            string jsonFilePath = Server.MapPath("roles.json");

            // Read the entire JSON content from the file
            var json = File.ReadAllText(jsonFilePath);

            // Deserialize the JSON content to a list of roles
            List<Role> roles = JsonConvert.DeserializeObject<List<Role>>(json);

           

            // Clear existing items from the DropDownList
            ddlRole.Items.Clear();

            // Add a default item (optional)
            ddlRole.Items.Add(new ListItem("Select Role", ""));

            // Add the roles to the DropDownList
            foreach (var role in roles)
            {
                ddlRole.Items.Add(new ListItem(role.RoleName, role.RoleId.ToString()));
            }
        

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Get input values
                string firstName = txtFirstName.Text.Trim();
                string lastName = txtLastName.Text.Trim();
                string name = firstName + " " + lastName;
                string mobile = txtMobile.Text.Trim();
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();
                string role = ddlRole.SelectedValue;
                string address = txtAddress.Text.Trim();

                // Hash the password
                string hashedPassword = FunctionFile.HashPassword(password);

                // Get the logged-in Admin Name
                string adminName = Session["UserName"].ToString();

                // Save the Employee Photo
                string photoFileName = SavePhoto(fulPhoto.PostedFile);

                // Get the next EmployeeID based on the current year
                string newEmployeeID = GenerateEmployeeID();

                // Save Employee Data to Database
                string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "INSERT INTO Employee (EmployeeID, Name, Photo, Mobile, Address, Role, UserName, Password, CreatedBy, CreatedAt, Active, UpdateBy, UpdateAt) " +
                                   "VALUES (@EmployeeID, @Name, @Photo, @Mobile, @Address, @Role, @UserName, @Password, @CreatedBy, GETDATE(), 1, @UpdateBy, GETDATE());";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", newEmployeeID);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Mobile", mobile);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@Address", address);
                        cmd.Parameters.AddWithValue("@Photo", photoFileName);
                        cmd.Parameters.AddWithValue("@CreatedBy", adminName);
                        cmd.Parameters.AddWithValue("@UpdateBy", adminName);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }


                string qrFilePath = GenerateQRCode(newEmployeeID);


                using (SqlConnection con = new SqlConnection(connString))
                {
                    string updateQuery = "UPDATE Employee SET QRCode = @QRCode WHERE EmployeeID = @EmployeeID";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@QRCode", qrFilePath);
                        cmd.Parameters.AddWithValue("@EmployeeID", newEmployeeID);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

               
                RefreshForm();
                Response.Write($"<script>alert('Employee added successfully!\\nEmployee ID: {newEmployeeID}\\nUsername: {username}');</script>");
                Response.Redirect("EmployeeList.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        private string GenerateEmployeeID()
        {
            string currentYear = DateTime.Now.Year.ToString(); 
            string newEmployeeID = "";

            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT TOP 1 EmployeeID FROM Employee WHERE EmployeeID LIKE @YearPrefix ORDER BY EmployeeID DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@YearPrefix", currentYear + "%");

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                       
                        string lastID = result.ToString();
                        int lastNumber = int.Parse(lastID.Substring(4)); 
                        newEmployeeID = currentYear + (lastNumber + 1).ToString("D3"); 
                    }
                    else
                    {
                       
                        newEmployeeID = currentYear + "001";
                    }
                }
            }
            return newEmployeeID;
        }

      
        // Save Employee Photo to /Images/Employees/ or use a default image
        private string SavePhoto(HttpPostedFile file)
        {
            string defaultImagePath = "Images/Employees/userimage3.png"; // Ensure this file exists

            if (file != null && file.ContentLength > 0)
            {
                string fileExt = Path.GetExtension(file.FileName);
                string fileName = "Photo_" + Guid.NewGuid().ToString() + fileExt;
                string filePath = Server.MapPath("~/Images/Employees/") + fileName;

                file.SaveAs(filePath);
                return "Images/Employees/" + fileName; // Path to store in the database
            }

            return defaultImagePath; // Return default image if no file uploaded
        }



        private string GenerateQRCode(string empId)
        {
            string feedbackUrl = Request.Url.GetLeftPart(UriPartial.Authority) + "/FeedbackForm.aspx?empId=" + empId;

            string folderPath = Server.MapPath("~/Images/QRCodes/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath); // Ensure directory exists
            }

            string qrFileName = "QR_" + Guid.NewGuid().ToString() + ".png";
            string qrFilePath = folderPath + qrFileName;

            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(feedbackUrl, QRCodeGenerator.ECCLevel.Q);
                using (QRCode qrCode = new QRCode(qrCodeData))
                {
                    using (System.Drawing.Bitmap qrBitmap = qrCode.GetGraphic(20))
                    {
                        qrBitmap.Save(qrFilePath, System.Drawing.Imaging.ImageFormat.Png);
                    }
                }
            }

            return "Images/QRCodes/" + qrFileName;
        }



        private void RefreshForm()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtMobile.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            ddlRole.SelectedIndex = 0;
            txtAddress.Text = "";
        }

        
    }
}
