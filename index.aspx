<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="View_index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <title>首頁</title>
</head>
<body>
    <script>
        $(document).ready(function () {  
            var aUrl = "View/V_index.aspx";
            location.replace(aUrl);
            window.opener.location.reload();
            window.close();
        });
    </script>
</body>
</html>

