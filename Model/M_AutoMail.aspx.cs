using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;

public partial class Model_M_AutoMail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            MailMessage message = new MailMessage();
            message.From = new MailAddress("mobiledaddy@mobiledaddy.net");

            message.To.Add(new MailAddress("ak47ricky24@gmail.com"));

            message.Subject = "標題";
            message.Body = "嗨起來";
            message.IsBodyHtml = true;


            SmtpClient SmtpServer = new SmtpClient();
            SmtpServer.Credentials = new System.Net.NetworkCredential("mobiledaddy@mobiledaddy.net", "Aa54380438!");
            SmtpServer.Port = 587;
            SmtpServer.Host = "smtp.office365.com";
            SmtpServer.EnableSsl = true;
            SmtpServer.Send(message);

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
}