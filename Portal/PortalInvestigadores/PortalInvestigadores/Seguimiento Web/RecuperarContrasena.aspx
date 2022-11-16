<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarContrasena.aspx.cs" Inherits="Portal_Investigadores.RecuperarContrasena" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recuperar Contraseña | Portal Responsables</title>
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
        <div class="container">
            
            <div id="contenido" class="nvo-login">
                <center>
                    <div id="image">
                        <%--<img src="img/ALFA_logo.svg.png" width="200" height="100" />--%>
                        <img src="img/buzon.png" style="width:100%;" />
                    </div>
                </center>
                <br />
                
                <div class="input">
                    
                    <label>Ingresa tu email para recuperar tu contraseña/Type in your email to recover password</label>
                    <br />
                    <br />
                    <div class="inner-addon left-addon">
                        <label>Email</label>
                        <asp:TextBox ID="email" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div id="warning" style="margin-top:5px;">
                        <asp:Label ID="waring" runat="server" style="color:red;"></asp:Label>
                    </div>
                    
                    <br />
              
                     <%--<div class="multileng">--%>
                    
                    <center>
                        <asp:Button ID="btnAceptar" OnClick="submit" runat="server" Text="Recuperar/Recover" CssClass="btn btn-default" />
                    </center>


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
