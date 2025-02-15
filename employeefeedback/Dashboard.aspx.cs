
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
            if (Session["Admin"] == null)
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
                    SELECT e.EmployeeID, e.Name, e.Position,
                           ISNULL(f.TotalFeedback, 0) AS TotalFeedback,
                           ISNULL(f.AverageRating, 0) AS AverageRating
                    FROM Employees e
                    LEFT JOIN 
                    (
                        SELECT EmployeeID, COUNT(*) AS TotalFeedback, AVG(CAST(Rating AS FLOAT)) AS AverageRating
                        FROM Feedback
                        GROUP BY EmployeeID
                    ) f ON e.EmployeeID = f.EmployeeID
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
            Session.Abandon();
            Session.Clear();
            Response.Redirect("Default.aspx");
        }

      

    }
}