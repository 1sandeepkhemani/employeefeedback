using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QRCoder;

namespace employeefeedback
{
    public partial class AddEmployee : Page
    {
        int employeeId;

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetValidUntilExpires(false);

            if (Session["UserName"] == null && Session["Role"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                LoadRoles();
            }
        }

        private void LoadRoles()
        {
            string[] roles = File.ReadAllLines(Server.MapPath("roles.txt"));
            foreach (var role in roles)
            {
                ddlRole.Items.Add(new ListItem(role, role));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (fulPhoto.HasFile)
            {
                try
                {
                    // Get input values
                    string firstName = txtFirstName.Text.Trim(); // Get First Name
                    string lastName = txtLastName.Text.Trim();   // Get Last Name
                    string name = firstName + " " + lastName;    // Combine First Name and Last Name

                    string mobile = txtMobile.Text.Trim();
                    string username = txtUsername.Text.Trim();
                    string password = txtPassword.Text.Trim();
                    string role = ddlRole.SelectedValue;
                    string address = txtAddress.Text.Trim();

                    // Hash the password
                    string hashedPassword = HashPassword(password);

                    // Get the logged-in Admin Name
                    string adminName = Session["UserName" +
                        ""].ToString();

                    // Save the Employee Photo
                    string photoFileName = SavePhoto(fulPhoto.PostedFile);

                    // Save Employee Data to Database
                    string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(connString))
                    {
                        string query = "INSERT INTO Employee (Name, Photo, Mobile, Address, Role, UserName, Password, CreatedBy, CreatedAt, Active) OUTPUT INSERTED.EmployeeID VALUES (@Name, @Photo, @Mobile, @Address, @Role, @UserName, @Password, @CreatedBy, GETDATE(), 1);";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@Mobile", mobile);
                            cmd.Parameters.AddWithValue("@Username", username);
                            cmd.Parameters.AddWithValue("@Password", hashedPassword);
                            cmd.Parameters.AddWithValue("@Role", role);
                            cmd.Parameters.AddWithValue("@Address", address);
                            cmd.Parameters.AddWithValue("@Photo", photoFileName);
                            cmd.Parameters.AddWithValue("@CreatedBy", adminName);

                            con.Open();
                            // Insert the employee and get the EmployeeID
                            employeeId = (int)cmd.ExecuteScalar();
                        }
                    }

                    // Generate QR Code after getting the employeeId
                    string qrFilePath = GenerateQRCode(employeeId);

                    // Update the database with the QR code
                    using (SqlConnection con = new SqlConnection(connString))
                    {
                        string updateQuery = "UPDATE Employee SET QRCode = @QRCode WHERE EmployeeID = @EmployeeID";
                        using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@QRCode", qrFilePath);
                            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Refresh form and show success message
                    RefreshForm();
                    Response.Write($"<script>alert('Employee added successfully!\\nUsername: {username}\\nPassword: {password}');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please upload a photo');</script>");
            }
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

        // Save Employee Photo to /Uploads/Photos/
        private string SavePhoto(HttpPostedFile file)
        {
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = "Photo_" + Guid.NewGuid().ToString() + fileExt;
            string filePath = Server.MapPath("~/Images/Employees/") + fileName;

            file.SaveAs(filePath);
            return "Images/Employees/" + fileName; // Path to store in the database
        }

        // Generate QR Code with Feedback Form URL
        private string GenerateQRCode(int empId)
        {
            // Construct the Feedback Form URL with the Employee ID
            string feedbackUrl = Request.Url.GetLeftPart(UriPartial.Authority) + "/FeedbackForm.aspx?empId=" + empId;

            // Define QR Code file name and path
            string qrFileName = "QR_" + Guid.NewGuid().ToString() + ".png";
            string qrFilePath = Server.MapPath("~/Images/QRCodes/") + qrFileName;

            // Generate the QR Code
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

            return "Images/QRCodes/" + qrFileName; // Path for storing in the database
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Abandon();

            // Optionally clear authentication cookie (if using forms authentication)
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                var cookie = new HttpCookie(".ASPXAUTH");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
            Response.Redirect("Login.aspx");
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
