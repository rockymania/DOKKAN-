using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_Test : System.Web.UI.Page
{
    private string mExString;
    private int mExNumber = 0;

    public string ExString { get { return mExString; } set { SetUseString(value); } }
    public int ExNumber { get { return mExNumber; } set { SetExNumber(value); } }

    private void SetUseString(string iString)//這邊以 i 為主。
    {
        mExString = iString;
    }

    private int SetExNumber(int iNumber)
    {
        int aTempNumber = 0;//區域變數 以 a 為主
        if (mExNumber >= iNumber)
            aTempNumber = mExNumber + iNumber;
        else
            aTempNumber = iNumber;

        return aTempNumber;

    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }



}