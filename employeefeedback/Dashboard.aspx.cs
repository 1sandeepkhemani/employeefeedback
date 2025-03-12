using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            FunctionFile.PageLoad(Response, Session);
            
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
                            SELECT e.EmployeeID, e.Name, e.Role, e.Active, e.CreatedAt, e.UpdateAt,
                                   ISNULL(f.TotalFeedback, 0) AS TotalFeedback,
                                   ISNULL(f.AverageRating, 0) AS AverageRating,
                                   CASE 
                                        WHEN e.Active = 1 THEN 
                                            CASE 
                                                WHEN DATEDIFF(DAY, e.CreatedAt, GETDATE()) = 0 THEN 'Today' 
                                                WHEN DATEDIFF(DAY, e.CreatedAt, GETDATE()) = 1 THEN 'Yesterday' 
                                                ELSE CAST(DATEDIFF(DAY, e.CreatedAt, GETDATE()) AS VARCHAR) + ' Days' 
                                            END
                                        ELSE       
                                                CAST(DATEDIFF(DAY, e.CreatedAt, e.UpdateAt) AS VARCHAR) + ' Days'
                                   END AS Duration
                            FROM Employee e
                            LEFT JOIN 
                            (
                                SELECT EmployeeID, COUNT(*) AS TotalFeedback, ROUND(AVG(CAST(Rating AS FLOAT)), 2) AS AverageRating
                                FROM Feedback
                                GROUP BY EmployeeID
                            ) f ON e.EmployeeID = f.EmployeeID
                            WHERE e.Role = 2
                            ORDER BY e.EmployeeID";



                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);

                    // Modify data to show "Current Employee" or "Previous Employee" based on Active column
                    dt.Columns.Add("Status", typeof(string));
                    dt.Columns.Add("RoleName", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        row["Status"] = (Convert.ToInt32(row["Active"]) == 1) ? "Current" : "Previous";
                        int roleId = Convert.ToInt32(row["Role"]);
                        row["RoleName"] = FunctionFile.GetRoleNameById(roleId); // Convert RoleID to RoleName

                    }

                    // Bind the data to GridView
                    gvDashboard.DataSource = dt;
                    gvDashboard.DataBind();
                }
            }
        }

        protected void gvDashboard_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // When data is being bound to the GridView row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Set the value of the 'Duration' column to the Text of the corresponding GridView cell
                e.Row.Cells[5].Text = DataBinder.Eval(e.Row.DataItem, "Duration").ToString();
            }
        }

      
    }
}
