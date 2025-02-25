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
                                lblPosition.Text = reader["Role"].ToString();
                                imgPhoto.Src = reader["Photo"].ToString();
                                imgQRCode.ImageUrl = reader["QRCode"].ToString();
                                qrLink.HRef = $"https://{Request.Url.Host}:{Request.Url.Port}/FeedbackForm.aspx?empId={empId}";
                            }
                            else
                            {
                                // Employee ID not found, redirect to error page
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
            Response.Redirect("Default.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            string role = Session["Role"].ToString();

            if (role == "Admin")
            {
                Response.Redirect("Dashboard.aspx");
            }

            else
            {
                Response.Redirect("EmployeeDashboard.aspx");
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

            string role = Session["Role"].ToString();

            if (role == "Admin")
            {
                Response.Redirect("About.aspx");
            }

            else
            {
                Response.Redirect("About.aspx");
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

            string role = Session["Role"].ToString();

            if (role == "Admin")
            {
                Response.Redirect("EmployeeList.aspx");
            }

            else
            {
                Response.Write($"<script>alert('Access Denied! Only administrators are allowed to perform this action.');</script>");
            }
        }

    }
}
