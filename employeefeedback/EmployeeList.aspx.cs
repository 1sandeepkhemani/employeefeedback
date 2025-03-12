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
    public partial class EmployeeList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {
                LoadEmployees();
            }
        }

        private void LoadEmployees()
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT EmployeeID, Name, Role, Mobile  FROM Employee WHERE Role = 2 AND Active = 1 ORDER BY EmployeeID ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);
                    dt.Columns.Add("RoleName", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        int roleId = Convert.ToInt32(row["Role"]);
                        row["RoleName"] = FunctionFile.GetRoleNameById(roleId);
                    }
                    gvEmployees.DataSource = dt;
                    gvEmployees.DataBind();
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int employeeID = Convert.ToInt32(btn.CommandArgument);

            
            string updatedBy = Session["UserName"]?.ToString() ?? "Unknown";

          
            SoftDeleteEmployee(employeeID, updatedBy);

            
            LoadEmployees();
        }

       

        private void SoftDeleteEmployee(int employeeID, String updateBy)
        {
            string connString = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = @"UPDATE Employee SET Active = 0, UpdateBy = @UpdateBy, UpdateAt = GETDATE() WHERE EmployeeID = @EmployeeID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    cmd.Parameters.AddWithValue("@UpdateBy", updateBy);
                
                    cmd.ExecuteNonQuery();
                }
            }
        }


    }
}