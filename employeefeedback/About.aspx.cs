using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class About : System.Web.UI.Page
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