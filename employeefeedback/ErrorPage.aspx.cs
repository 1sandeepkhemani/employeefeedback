using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace employeefeedback
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           FunctionFile.PageLoad(Response, Session);

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           FunctionFile.Home(Response, Session);
        }
    }
}