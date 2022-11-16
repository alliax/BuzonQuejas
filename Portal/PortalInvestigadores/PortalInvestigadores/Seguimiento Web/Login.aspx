<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Portal_Investigadores.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log in | Portal Responsables</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css' />
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"/>
    <link rel="shortcut icon" href="favicon.ico" />

    <link href="css/login.css" rel="stylesheet" />
</head>
<body>
    <form id="form" runat="server">

        <script>
            $(document).ready(function () {

                $.getJSON('http://ip-api.com/json?callback=?', function (data) {
                    $("#txtIp").val(data.query);
                });

            });

        </script>
        <div class="container">
            <input type="hidden" id="txtIp" runat="server" />
            <div id="contenido" runat="server" class="nvo-login">
                <center>
                    <div id="image">
                        <%--<img src="img/ALFA_logo.svg.png" width="200" height="100" />--%>
                        <img src="img/buzon.png" style="width:100%;" />
                    </div>
                </center>
                <%--<br />--%>
                <div id="warning">
                    <asp:Label ID="waring" runat="server" style="color:red;"></asp:Label>
                </div>
                <div class="input">
                    <br />
                    <div class="inner-addon left-addon">
                        <i class="glyphicon glyphicon-user"></i>
                        <asp:TextBox ID="user" runat="server" CssClass="form-control" ></asp:TextBox>
                    </div>
                    <br />
                    <div class="inner-addon left-addon">
                        <i class="glyphicon glyphicon-lock"></i>
                        <asp:TextBox ID="pass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>                        
                    </div>
                     <br />
                     <%--<div class="multileng">--%>
                    <div class="inner-addon left-addon">
                        <%--<asp:Label ID="Label1" runat="server" CssClass="lbl-multLeng">Selecciona un idioma: </asp:Label>--%>
                         <i class="glyphicon" style="margin-bottom: 5px;"><img src="img/language.png" width="20" height="20" /></i>
                        <asp:DropDownList runat="server"  CssClass="form-control" ID="ddlIdioma"><%-- CssClass="btn-multLen"--%>
                            <asp:ListItem Text="Español" Value="1" />
                            <asp:ListItem Text="English" Value="2" />
                        </asp:DropDownList>
                    </div>
                 
                    <center>
                        <asp:Button ID="btnAceptar" OnClick="submit" runat="server" Text="Acceder/Login" CssClass="btn btn-default" />
                    </center>
                    <br/>
                    <div class="inner-addon left-addon">
                        <a href="RecuperarContrasena.aspx">Recuperar Contraseña/Recover password</a>
                    </div>                   

                    <%--<div class="multileng">
                        <asp:Label ID="lblLen" runat="server" CssClass="lbl-multLeng">Selecciona un idioma: </asp:Label>
                        <asp:DropDownList runat="server" CssClass="btn-multLen">
                            <asp:ListItem Text="Español" Value="1" />
                            <asp:ListItem Text="English" Value="2" />
                        </asp:DropDownList>
                    </div>--%>
                   
                </div>
            </div>
        </div>
    </form>
</body>
</html>
