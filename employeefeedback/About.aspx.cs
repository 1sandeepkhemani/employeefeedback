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
            FunctionFile.PageLoad(Response, Session);   
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            FunctionFile.Home(Response, Session);
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
           FunctionFile.Logout(Response, Session, Request); 
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
    }

}