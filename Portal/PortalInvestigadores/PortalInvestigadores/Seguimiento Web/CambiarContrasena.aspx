<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambiarContrasena.aspx.cs" Inherits="Portal_Investigadores.CambiarContrasena" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cambiar Contraseña | Portal Responsables</title>
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
                               
                <div class="input">
                    
                    <%--<label>Ingresa tu email para recuperar tu contraseña</label>--%>
                    <%--<br />--%>
                    <br />
                    <div class="inner-addon left-addon">
                        <label>Contraseña anterior/Previous password</label>
                        <asp:TextBox ID="contrasenaAnterior" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>
                     <br />
                    <div class="inner-addon left-addon">
                        <label>Nueva contraseña/New Password</label>
                        <asp:TextBox ID="nuevaContrasena" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                     
                    </div>
                     <br />
                    <div class="inner-addon left-addon">
                        <label>Confirmar nueva contraseña/Confirm New Password</label>
                        <asp:TextBox ID="ConfContrasena" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>

                    </div>

                    <div id="warning" style="margin-top:5px;">
                        <asp:Label ID="waring" runat="server" style="color:red;"></asp:Label>
                    </div>
                    
                    <br />
                    
                    <center>
                        <button type="button" style="background-color: darkgray;" class="btn btn-secondary" onclick="location.href='Login.aspx';" >Regresar/Back</button>
                        <asp:Button ID="btnCambiar" OnClick="submit" runat="server" Text="Cambiar/Change Password" CssClass="btn btn-default" />
                    </center>
                   
                </div>
            </div>
        </div>
    </form>
</body>
</html>
