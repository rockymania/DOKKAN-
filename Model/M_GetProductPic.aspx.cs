using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_GetProductPic : System.Web.UI.Page
{
    private string mCheckPath = "~";
    private string mCreateString = "<li><img src = \"{0}\"/></li>";

    protected void Page_Load(object sender, EventArgs e)
    {
        string aID = string.Empty;
        string aReStr = string.Empty;

        try
        {
            aID = Request["Kind"].ToString();

            //aID = "0";

            if (GetIsDebug() == false)
                mCheckPath = "~/Dokkan/";

            int iFileCount = GetPathFileCount(aID);


            for (int i = 0; i < iFileCount; i++)
            {
                aReStr += String.Format(mCreateString,"../Image/ProductDetail/" + aID + "/" + i.ToString() + ".jpg");
            }

            Response.Write(aReStr);
        }
        catch (Exception ex)
        {
            Response.Write(ex);

        }


    }
    //取得資料夾底下的檔案數量
    private int GetPathFileCount(string iID)
    {
        int aCount = 0;

        DirectoryInfo dirInfo = new DirectoryInfo(Server.MapPath(mCheckPath + "/Image/ProductDetail/" + iID));
        aCount = dirInfo.GetFiles("*.jpg").Length;

        return aCount;
    }

    private bool GetIsDebug()
    {
        bool isLocal = HttpContext.Current.Request.IsLocal;
        if (!isLocal)
        {
            //記錄資料1
            return false;
        }
        return true;
    }
}