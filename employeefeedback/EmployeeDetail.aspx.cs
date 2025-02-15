using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class EmployeeDetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Default.aspx");
            }

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
                    string query = "SELECT EmployeeID, Name, Mobile, Address, Position, Photo, QRCode FROM Employees WHERE EmployeeID = @EmployeeID";
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
                                lblPosition.Text = reader["Position"].ToString();
                                imgPhoto.Src = reader["Photo"].ToString();
                                imgQRCode.ImageUrl = reader["QRCode"].ToString();
                                qrLink.HRef = $"https://{Request.Url.Host}:{Request.Url.Port}/FeedbackForm.aspx?empId={empId}";
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

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
