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
    public partial class EmployeeFeedbackDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
                Response.Redirect("Default.aspx");

            if (!IsPostBack)
            {
                int empId = 0;
                if (Int32.TryParse(Request.QueryString["empId"], out empId))
                {
                    LoadEmployeeFeedback(empId);
                }
            }
        }

        private void LoadEmployeeFeedback(int empId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FeedbackDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Validate if Employee ID exists
                string empQuery = "SELECT Name FROM Employees WHERE EmployeeID = @EmployeeID";
                using (SqlCommand cmdEmp = new SqlCommand(empQuery, conn))
                {
                    cmdEmp.Parameters.AddWithValue("@EmployeeID", empId);
                    object result = cmdEmp.ExecuteScalar();

                    if (result == null) // Employee ID not found
                    {
                        Response.Redirect("ErrorPage.aspx");
                        return;
                    }

                    lblEmployeeName.Text = result.ToString(); // Set employee name
                }

                // Get feedback for the employee
                using (SqlCommand cmd = new SqlCommand("SELECT CustomerName, Rating, Comments, FeedbackDate FROM Feedback WHERE EmployeeID = @EmployeeID ORDER BY FeedbackDate DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", empId);
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);
                    gvFeedback.DataSource = dt;
                    gvFeedback.DataBind();
                }
            }
        }


        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("Default.aspx");
        }

        protected void gvFeedback_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}