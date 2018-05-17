using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Backstage_Model_M_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aAccount = Request["Account"].ToString();
            string aPassword = Request["Password"].ToString();


            Response.Write("1");
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    
}