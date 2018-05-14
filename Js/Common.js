// 建立cookie
function createCookie(name, value, days, path) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}
//讀取
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
//刪除
function eraseCookie(name) {
    createCookie(name, "", -1);
}

function checkHaveCookieData(iAccount)
{
    var aCookie = document.cookie.split(';');

    for (var i = 0; i < aCookie.length;i++)
    {
        //if (aCookie[i].indexOf(iAccount) != -1 )
        //    return true;
        if (aCookie[i] == iAccount)
            return true;
    }
    return false;
}

function checkHaveDetailData(iAccount,iProductID)
{
    var aContent = readCookie(iAccount);

    var aContentAry = aContent.split(',');

    for (var i = 0; i < aContentAry.length; i++)
    {
        var aTmpAry = aContentAry[i].split('|');
        if (aTmpAry[0] == iProductID)
            return true;
    }

    return false;
}

function getNewProductCountData(iAccount,iProductID,iAddCount)
{
    var aReStr = "";

    var aContent = readCookie(iAccount);

    var aContentAry = aContent.split(',');

    for (var i = 0; i < aContentAry.length; i++)
    {
        var aTmpAry = aContentAry[i].split('|');

        if (aTmpAry[0] == "")
            break;

        if (aTmpAry[0] == iProductID)
        {
            var aCount = parseInt(aTmpAry[1]) + parseInt(iAddCount);
            if (aReStr != "")
                aReStr += "," + aTmpAry[0] + "|" + aCount;
            else
                aReStr += aTmpAry[0] + "|" + aCount;
        }
        else
        {
            if (aReStr != "")
                aReStr += "," + aTmpAry[0] + "|" + aTmpAry[1];
            else
                aReStr += aTmpAry[0] + "|" + aTmpAry[1];
        }      
    }

    return aReStr;
}

function DelProductItem(iAccount, iProductID)
{
    var aCookieStr = "";

    var aContent = readCookie(iAccount);

    var aContentAry = aContent.split(',');

    for (var i = 0; i < aContentAry.length; i++) {
        var aTmpAry = aContentAry[i].split('|');

        if (aTmpAry[0] == "")
            break;

        if (aTmpAry[0] != iProductID) {
            if (aCookieStr != "")
                aCookieStr += "," + aTmpAry[0] + "|" + aTmpAry[1];
            else
                aCookieStr += aTmpAry[0] + "|" + aTmpAry[1];
        }
    }

    eraseCookie(iAccount);

    if (aCookieStr != "")
        createCookie(iAccount, aCookieStr, 1);

    return aCookieStr;
}