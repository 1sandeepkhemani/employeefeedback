using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace employeefeedback
{
    public partial class EmployeeDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {
              
                    int empId = Convert.ToInt32(Session["EmployeeID"]);
                    LoadDashboard(empId);
                    LoadFeedbackChart(empId);
                
            }
        }

        private void LoadDashboard(int empId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT e.EmployeeID, e.Name, e.Photo, e.Role,
                           ISNULL(f.TotalFeedback, 0) AS TotalFeedback,
                           ISNULL(f.AverageRating, 0) AS AverageRating
                    FROM Employee e
                    LEFT JOIN 
                    (
                        SELECT EmployeeID, COUNT(*) AS TotalFeedback, AVG(CAST(Rating AS FLOAT)) AS AverageRating
                        FROM Feedback
                        GROUP BY EmployeeID
                    ) f ON e.EmployeeID = f.EmployeeID
                    WHERE e.Active = 1 AND e.Role = 2 AND e.EmployeeID = @EmployeeID
                    ORDER BY e.EmployeeID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", empId);

                    conn.Open();
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);

                    dt.Columns.Add("RoleName", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        
                        int roleId = Convert.ToInt32(row["Role"]);
                        row["RoleName"] = FunctionFile.GetRoleNameById(roleId); // Convert RoleID to RoleName

                    }
                    rptDashboard.DataSource = dt;
                    rptDashboard.DataBind();
                }
            }
        }

        

        private void LoadFeedbackChart(int empId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT FeedbackDate, Rating FROM Feedback WHERE EmployeeID = @EmployeeID", conn);
                cmd.Parameters.AddWithValue("@EmployeeID", empId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            if (dt.Rows.Count == 0)
            {
                // Handle case when there are no feedbacks
                ClientScript.RegisterStartupScript(this.GetType(), "NoFeedback", "alert('No feedback data available for this employee.');", true);
                return;
            }

            string[] labels = dt.AsEnumerable().Select(r => Convert.ToDateTime(r["FeedbackDate"]).ToShortDateString()).ToArray();
            string[] ratings = dt.AsEnumerable().Select(r => r["Rating"].ToString()).ToArray();

            // Debugging: Check if data is populated correctly
            Console.WriteLine("Labels: " + string.Join(",", labels));
            Console.WriteLine("Ratings: " + string.Join(",", ratings));

            string chartData = $"renderChart({JsonConvert.SerializeObject(labels)}, {JsonConvert.SerializeObject(ratings)});";
            ClientScript.RegisterStartupScript(this.GetType(), "chartScript", chartData, true);
        }

    }
}