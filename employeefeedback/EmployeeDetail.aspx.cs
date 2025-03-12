using Org.BouncyCastle.Asn1.Ocsp;
using Org.BouncyCastle.Ocsp;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class EmployeeDetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["empId"], out int empId))
                {
                    LoadEmployeeDetails(empId);
                }
            }
        }

        private void LoadEmployeeDetails(int empId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT EmployeeID, Name, Mobile, Address, Role, Photo, QRCode FROM Employee WHERE EmployeeID = @EmployeeID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", empId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblEmployeeID.Text = reader["EmployeeID"].ToString();
                                lblName.Text = reader["Name"].ToString();
                                lblMobile.Text = reader["Mobile"].ToString();
                                lblAddress.Text = reader["Address"].ToString();

                                int roleId = Convert.ToInt32(reader["Role"]);
                                lblPosition.Text = FunctionFile.GetRoleNameById(roleId);

                                imgPhoto.Src = string.IsNullOrEmpty(reader["Photo"].ToString()) ? "default-user.png" : reader["Photo"].ToString();
                                string qrCodePath = reader["QRCode"].ToString();

                                if (!string.IsNullOrEmpty(qrCodePath))
                                {
                                    qrImage.Src = qrCodePath;
                                    downloadQr.HRef = qrCodePath; // Set download link
                                    qrLink.HRef = $"https://{Request.Url.Host}:{Request.Url.Port}/FeedbackForm.aspx?empId={empId}";
                                }
                            }
                            else
                            {
                                Response.Redirect("ErrorPage.aspx");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblName.Text = "Error loading details: " + ex.Message;
                }
            }
        }
    }
    }








