
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class Dashboard : System.Web.UI.Page
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
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT e.EmployeeID, e.Name, e.Role,
                           ISNULL(f.TotalFeedback, 0) AS TotalFeedback,
                           ISNULL(f.AverageRating, 0) AS AverageRating
                    FROM Employee e
                    LEFT JOIN 
                    (
                        SELECT EmployeeID, COUNT(*) AS TotalFeedback, AVG(CAST(Rating AS FLOAT)) AS AverageRating
                        FROM Feedback
                        GROUP BY EmployeeID
                    ) f ON e.EmployeeID = f.EmployeeID
                    WHERE e.Active = 1 AND e.Role = 'Employee'
                    ORDER BY e.EmployeeID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);
                    gvDashboard.DataSource = dt;
                    gvDashboard.DataBind();
                }
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
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