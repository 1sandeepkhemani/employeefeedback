using QRCoder;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class Profile: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            FunctionFile.PageLoad(Response, Session);

            if (!IsPostBack)
            {

                int empId = Convert.ToInt32(Session["EmployeeID"]);
                LoadEmployeeDetails(empId);

            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            FunctionFile.Home(Response, Session);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

            FunctionFile.About(Response);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

           FunctionFile.CurrentEmployee(Response, Session);
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {

          FunctionFile.PreviousEmployee(Response, Session);
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

                                imgPhoto.Src = reader["Photo"].ToString();
                                qrLinkOpen.HRef = reader["QrCode"].ToString();
                                
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


    }
}