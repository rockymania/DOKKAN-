
$(document).ready(function ()
{
    var aAccount = readCookie('Account');

    var aNickName = readCookie('NickName');

    if (readCookie('Account') != null)
    {
        $("#header").prepend("<p id=\"LoginList\">" + "歡迎 " + aNickName + " 您登入,若要離開請點選<a style=\"color:blue\"; href=\"javascript:byebye()\">登出</a></p></br></br>");
    }
    else
    {
        $("#header").prepend("<p id=\"LoginList\">" + "<a href=\"V_Login.aspx\">登入</a>或 <a href=\"V_SignUp.aspx\">註冊</a></p></br></br>");
    }
})

function createCookie(name, value, days, path) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

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
function byebye()
{
    createCookie('Account', "", -1);
    createCookie('NickName', "", -1);
    location.href = "V_index.aspx";
}
