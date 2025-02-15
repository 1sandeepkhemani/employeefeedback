using QRCoder;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
                Response.Redirect("Default.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Validate all required fields in the backend as well
            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtPosition.Text) ||
                string.IsNullOrWhiteSpace(txtMobile.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text) ||
                !fuPhoto.HasFile)
            {
                lblMessage.Text = "All fields are required!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Validate mobile number
            if (txtMobile.Text.Length != 10 || !long.TryParse(txtMobile.Text, out _))
            {
                lblMessage.Text = "Invalid mobile number!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string name = txtName.Text.Trim();
            string position = txtPosition.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string address = txtAddress.Text.Trim();
            string photoPath = "";
            string qrCodePath = "";

            // Save uploaded photo
            string ext = Path.GetExtension(fuPhoto.FileName);
            string photoFileName = Guid.NewGuid().ToString() + ext;
            photoPath = "~/Images/Employees/" + photoFileName;
            fuPhoto.SaveAs(Server.MapPath(photoPath));

            // Insert the employee record
            int employeeId = 0;
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Employees (Name, Photo, Position, Mobile, Address) OUTPUT INSERTED.EmployeeID VALUES (@Name, @Photo, @Position, @Mobile, @Address)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Photo", photoPath);
                    cmd.Parameters.AddWithValue("@Position", position);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Address", address);
                    conn.Open();
                    employeeId = (int)cmd.ExecuteScalar();
                }
            }

            // Generate QR Code
            string feedbackUrl = Request.Url.GetLeftPart(UriPartial.Authority) + ResolveUrl("~/FeedbackForm.aspx?empId=" + employeeId);
            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(feedbackUrl, QRCodeGenerator.ECCLevel.Q);
                using (QRCode qrCode = new QRCode(qrCodeData))
                {
                    using (Bitmap qrCodeImage = qrCode.GetGraphic(20))
                    {
                        string qrFileName = Guid.NewGuid().ToString() + ".png";
                        qrCodePath = "~/Images/QRCodes/" + qrFileName;
                        qrCodeImage.Save(Server.MapPath(qrCodePath), ImageFormat.Png);
                    }
                }
            }

            // Update the employee record with QR code
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string updateQuery = "UPDATE Employees SET QRCode = @QRCode WHERE EmployeeID = @EmployeeID";
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@QRCode", qrCodePath);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Employee added successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            ClearFields();
        }

        private void ClearFields()
        {
            txtName.Text = "";
            txtPosition.Text = "";
            txtMobile.Text = "";
            txtAddress.Text = "";
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
           
            Session.Abandon();
            Session.Clear();
            Session.RemoveAll();
            Response.Redirect("Default.aspx");

            
        }
    }
}
