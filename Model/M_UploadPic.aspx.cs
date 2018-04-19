using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_UploadPic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mUploadIP = "ftp://50.62.160.239/httpdocs/Dokkan/Image/";
        string mUserName = "Ricky";
        string mPassword = "abc101238";
        
        //先檢查是否有東西
        if (Request.Files.AllKeys.Any())
        {
            //取得圖片名稱
            string aPicName = Request["PicName"].ToString();
            //取得圖片的資料夾
            string aPicPath = Request["PicPath"].ToString();
            //取得檔案
            var aPicFile = Request.Files["Pic"];
            //檢查是否有檔案
            if (aPicFile != null && aPicFile.ContentLength != 0)
            {
                StreamReader aSr = new StreamReader(aPicFile.InputStream);
                var aData = default(byte[]);

                using (MemoryStream aMS = new MemoryStream())
                {
                    aSr.BaseStream.CopyTo(aMS);
                    aData = aMS.ToArray();
                }

                aSr.Dispose();
                //開始使用FTP上傳
                using (WebClient aWC = new WebClient())
                {
                    try
                    {
                        aWC.Credentials = new NetworkCredential(mUserName, mPassword);
                        aWC.UploadData(mUploadIP + aPicPath + "/" + aPicName + ".jpg",aData);
                        Response.Write("0");
                    }
                    catch
                    {
                        //上傳圖片失敗
                        Response.Write("2");
                    }
                }
            }
            else
            {
                //沒有檔案
                Response.Write("1");
            }
        }
    }
}