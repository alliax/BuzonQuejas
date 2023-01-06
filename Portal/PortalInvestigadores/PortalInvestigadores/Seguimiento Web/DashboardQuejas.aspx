<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DashboardQuejas.aspx.cs" Inherits="Seguimiento_Web.DashboardQuejas" %>

<%----------------------------------------------------------------------Content----------------------------------------------------------------%>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<form>
<link href="css/especiales.css" rel="stylesheet" />
<script src="scripts/events.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"></script>

<script>
var idioma = '<%= Session["idioma"] %>'; 
var usr = '<%= Session["idUsuario"] %>';
var idBQ = '<%= Session["idBQ"] %>';

$(document).ready(function () {

    var origin = window.location.origin;   // Returns base URL (https://example.com)

    var idRol = 0;
    $.ajax({
        type: "GET",
        async:false,
        url: "DashboardQuejas.aspx/BQ_Rol_Usr",
        data: $.param({ iUsr: usr}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var Json = createJson(r);
            idRol = Json[0].IdRol
            sessionStorage.setItem("usrRol", Json[0].IdRol);
        }
    });


    configPage(idioma,idRol);
});

function configPage(idIdioma,idRol) {
    var Json = [];

    if (idRol == 1) { //Operador
        $.ajax({
            type: "GET",
            url: "DashboardQuejas.aspx/BQ_Etiquetas",
            data: $.param({ iId: 3, iIdioma: idIdioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) { $("#lbl1").html(Json[i].Texto); }
                    if (Json[i].Id == 2) {
                        $("#lbl2").html(Json[i].Texto); $('#img1').attr('src', 'img/msg.png');
                        var msgData = dashboardData("Mensajes-C", idBQ, usr);
                        $("#num1").html(msgData.length.toString());
                    }
                    if (Json[i].Id == 3) {
                        $("#lbl3").html(Json[i].Texto); $('#img2').attr('src', 'img/Vobo.svg');
                        var msgData = dashboardData("Mensajes-Vobo", idBQ, usr);
                        $("#num2").html(msgData.length.toString());
                    }
                    if (Json[i].Id == 7) {
                        $("#lbl4").html(Json[i].Texto); $('#img3').attr('src', 'img/Vobo.svg');
                        var msgData = dashboardData("Quejas-Vobo", idBQ, usr);
                        $("#num3").html(msgData.length.toString());
                    }
                    if (Json[i].Id == 8) {
                        $("#lbl5").html(Json[i].Texto); $('#img4').attr('src', 'img/Vobo.svg');
                        var msgData = dashboardData("Quejas-CC", idBQ, usr);
                        $("#num4").html(msgData.length.toString());
                    }
                }
            },
            error: function (r) {
                alert("Error System");
            }
        });

        $("#btn1").click(
            function () {
                $("#lbl6").html(Json[1].Texto);
                var msgData = dashboardData("Mensajes-C", idBQ, usr);

                $('#tbl').html("");
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>Id Mensaje</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Message Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $('#tbl').append('<tr>' + '<td>' + msgData[i].IdMensaje + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td>' + msgData[i].FechaRecep + '</td>' + '<td><button type="button" onclick="changeUrl(1,' + msgData[i].IdMensaje +')" class="btn btn-primary">Detalle</button></td>' + '</tr>');
                }
            }
        );
        $("#btn2").click(
            function () {
                $("#lbl6").html(Json[2].Texto);
                var msgData = dashboardData("Mensajes-Vobo", idBQ, usr);

                $('#tbl').html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>Id Mensaje</th><th>Titulo</th><th>Empresa</th><th>Sitio</th><th>Fecha Creacion</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Message Id</th><th>Title</th><th>Company</th><th>Site</th><th>Create Date</th></tr>")
                }
                for (i = 0; i <= msgData.length - 1; i++) {
                    $('#tbl').append('<tr>' + '<td>' + msgData[i].IdMensaje + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td>' + msgData[i].FechaRecep + '</td>' + '<td><button type="button" onclick="changeUrl(1,' + msgData[i].IdMensaje + ')" class="btn btn-primary">Detalle</button></td>' + '</tr>');
                }
            }
        );
        $("#btn3").click(
            function () {
                $("#lbl6").html(Json[6].Texto);
                var msgData = dashboardData("Quejas-Vobo", idBQ, usr);

                $('#tbl').html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $('#tbl').append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );
        $("#btn4").click(
            function () {
                $("#lbl6").html(Json[7].Texto);
                var msgData = dashboardData("Quejas-CC", idBQ, usr);

                $('#tbl').html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $('#tbl').append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(2,'+ msgData[i].IdQueja +')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );

    }//Operador

    if (idRol == 3) { //Investigador
        $.ajax({
            type: "GET",
            url: "DashboardQuejas.aspx/BQ_Etiquetas",
            data: $.param({ iId: 3, iIdioma: idIdioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) {
                        $("#lbl1").html(Json[i].Texto);
                    }
                    if (Json[i].Id == 4) {
                        $("#lbl2").html(Json[i].Texto); $('#img1').attr('src', 'img/Asignadas.svg');
                        var msgData = dashboardData("Quejas-Asi", idBQ, usr);
                        $("#num1").html(msgData.length.toString());
                    }
                    if (Json[i].Id == 5) {
                        $("#lbl3").html(Json[i].Texto); $('#img2').attr('src', 'img/Delegadas.svg');
                        var msgData = dashboardData("", idBQ, usr);
                        $("#num2").html(msgData.length.toString());
                    }
                    if (Json[i].Id == 9) {
                        $("#lbl4").html(Json[i].Texto); $('#img3').attr('src', 'img/Vobo.svg');
                        var msgData = dashboardData("Quejas-Vobo", idBQ, usr);
                        $("#num3").html(msgData.length.toString());
                    }
                    if (Json[i].Id == 6) {
                        $("#lbl5").html(Json[i].Texto); $('#img4').attr('src', 'img/Revision.svg');
                        var msgData = dashboardData("Quejas-Rev", idBQ, usr);
                        $("#num4").html(msgData.length.toString());
                    }
                }
            },
            error: function (r) {
                alert("Error System");
            }
        });

        $("#btn1").click(
            function () {
                $("#lbl6").html(Json[3].Texto)
                var msgData = dashboardData("Quejas-Asi", idBQ, usr);

                $('#tbl').html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $('#tbl').append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );
        $("#btn2").click(
            function () {
                $("#lbl6").html(Json[4].Texto)
                var msgData = dashboardData("", idBQ, usr);

                $("#tbl").html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Sitio</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $("#tbl").append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );
        $("#btn3").click(
            function () {
                $("#lbl6").html(Json[8].Texto)
                var msgData = dashboardData("Quejas-Vobo", idBQ, usr);

                $("#tbl").html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $("#tbl").append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );
        $("#btn4").click(
            function () {
                $("#lbl6").html(Json[5].Texto)
                var msgData = dashboardData("Quejas-Rev", idBQ, usr);

                $("#tbl").html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Fecha Asignacion</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Assigned Date</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $("#tbl").append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].FechaAsignacion + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );

    }//Investigador

    if (idRol == 2 ) { //Vobo 
        $.ajax({
            type: "GET",
            url: "DashboardQuejas.aspx/BQ_Etiquetas",
            data: $.param({ iId: 3, iIdioma: idIdioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) { $("#lbl1").html(Json[i].Texto); }
                    if (Json[i].Id == 9) {
                        $("#lbl2").html(Json[i].Texto); $('#img1').attr('src', 'img/Vobo.svg');
                        var msgData = dashboardData("Mensajes-Vobo", idBQ, usr);
                        $("#num1").html(msgData.length.toString());
                    }
                }
                $("#btn2").hide();
                $("#btn3").hide();
                $("#btn4").hide();
            },
            error: function (r) {
                alert("Error System");
            }
        });

        $("#btn1").click(
            function () {
                $("#lbl6").html(Json[8].Texto)
                var msgData = dashboardData("Mensajes-Vobo", idBQ, usr);

                $("#tbl").html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>Id Mensaje</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Message Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length-1; i++) {
                    $("#tbl").append('<tr>' + '<td>' + msgData[i].IdMensaje + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(1,'+ msgData[i].IdMensaje +')" class="btn btn-primary">Detalle</button></td>' + '</tr>');
                }
            }
        );


    }//Vobo

    if (idRol == 4) { //Revisor
        $("#btn1").hide();
        $("#btn2").hide();
        $("#btn3").hide();
        

        $.ajax({
            type: "GET",
            url: "DashboardQuejas.aspx/BQ_Etiquetas",
            data: $.param({ iId: 3, iIdioma: idIdioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) {
                        $("#lbl1").html(Json[i].Texto);
                    }
                    if (Json[i].Id == 6) {
                        $("#lbl5").html(Json[i].Texto); $('#img4').attr('src', 'img/Revision.svg');
                        var msgData = dashboardData("Quejas-Rev", idBQ, usr);
                        $("#num4").html(msgData.length.toString());
                    }
                }
            },
            error: function (r) {
                alert("Error System");
            }
        });

        $("#btn4").click(
            function () {
                $("#lbl6").html(Json[5].Texto)
                var msgData = dashboardData("Quejas-Rev", idBQ, usr);

                $("#tbl").html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Fecha Asignacion</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Assigned Date</th></tr>")
                }
                for (i = 0; i <= msgData.length - 1; i++) {
                    $("#tbl").append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].FechaAsignacion + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td></tr>');
                }
            }
        );

    }//Revisor



    if ( idRol == 5 || idRol == 6) { //Cierre - Comite
        $.ajax({
            type: "GET",
            url: "DashboardQuejas.aspx/BQ_Etiquetas",
            data: $.param({ iId: 3, iIdioma: idIdioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) { $("#lbl1").html(Json[i].Texto); }
                    if (Json[i].Id == 9) {
                        $("#lbl2").html(Json[i].Texto); $('#img1').attr('src', 'img/Vobo.svg');
                        var msgData = dashboardData("Workflow", idBQ, usr);
                        $("#num1").html(msgData.length.toString());
                    }
                }
                $("#btn2").hide();
                $("#btn3").hide();
                $("#btn4").hide();
            },
            error: function (r) {
                alert("Error System");
            }
        });

        $("#btn1").click(
            function () {
                $("#lbl6").html(Json[8].Texto)
                var msgData = dashboardData("Workflow", idBQ, usr);

                $("#tbl").html("")
                if (idioma == 1) {
                    $("#tbl").append("<tr><th>IdQueja</th><th>Titulo</th><th>Empresa</th><th>Sitio</th></tr>")
                }
                else {
                    $("#tbl").append("<tr><th>Complain Id</th><th>Title</th><th>Company</th><th>Site</th></tr>")
                }
                for (i = 0; i <= msgData.length - 1; i++) {
                    $("#tbl").append('<tr>' + '<td>' + msgData[i].IdQueja + '</td>' + '<td>' + msgData[i].Titulo + '</td>' + '<td>' + msgData[i].Empresa + '</td>' + '<td>' + msgData[i].Sitio + '</td>' + '<td><button type="button" onclick="changeUrl(2,' + msgData[i].IdQueja + ')" class="btn btn-primary">Detalle</button></td>' + '</tr>');
                }
            }
        );


    }//Cierre - Comite

}//End Function

function createJson(strJson) {
        var strJson = JSON.stringify(strJson);
        var iJsonLenght = strJson.length
        strJson = strJson.substr(5, iJsonLenght);
        strJson = strJson.slice(0, -1)
        var Json = JSON.parse(strJson);
        Json = JSON.parse(Json);

        return Json;
}//End Function
function dashboardData(Opt, idBQ,idUsr) {
    var Json = [];
    $.ajax({
        type: "GET",
        async: false,
        url: "DashboardQuejas.aspx/BQ_Dashboard",
        data: $.param({ sOpt: "'" + Opt + "'", iIdBQ: idBQ, iIdUsr: idUsr }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {

          var result = createJson(r);
          Json = result;
        },
        error: function (r) {
            alert("Error System");
        }
    });
    return Json;
 }//End Function
    function changeUrl(Opt,Id) {
        if (Opt == 1) {
            var url = window.location.origin + '/AltaMensaje.aspx?idMensaje='+Id;
            window.location.replace(url);
            sessionStorage.setItem("idMensaje", Id);

        }
        if (Opt == 2) {
            var url = window.location.origin + "/DetalleQuejas.aspx?idQueja="+Id;
            window.location.replace(url);
            sessionStorage.setItem("sIdQueja", Id);
        }
}//End Function
</script>
        
        <div class="container">
            <%--Indicadores Principales--%>
            <div class="row" style="margin-top:15px;">
               
                
                    <div id="btn1" class="col-3"  >
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">

                                <img id="img1" class="dashboard-img" src="img/msg.png" height="980" width:"980" />
                                <div id="num1"  class="numbers">0</div>
                                <p class="card-text indPrin" id="lbl2"></p> 
                            </div>
                        </div>
                    </div>
                
        
                    <div id="btn2" class="col-3">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">
                                <img id="img2"  class="dashboard-img" src="img/Vobo.svg" />
                                <div id="num2"  class="numbers">0</div>
                                <p class="card-text indPrin" id="lbl3"></p>
                            </div>
                        </div>
                    </div>

                  
                    <div id="btn3" class="col-3">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">
                                <img id="img3" class="dashboard-img" src="img/Vobo.svg" />
                                <div id="num3"  class="numbers">0</div>
                                <p class="card-text indPrin" id="lbl4" ></p>
                            </div>
                        </div>
                    </div>

                    <div id="btn4" class="col-3">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">

                                <img id="img4" class="dashboard-img" src="img/Vobo.svg" />
                                <div id="num4"  class="numbers">0</div>
                                <p class="card-text indPrin" id="lbl5"></p>
                            </div>
                        </div>
                    </div>           
            </div>
        
            <%---Grids---%>
            <div  class="row" id="divAsignadas" style="margin-top:21px;">
                <div id="lbl6"  class="table-header">
                   Grid Information
                </div>
                <table id="tbl" class="strip table table-hover table-dashboard">
                </table>
            </div>


         </div>
    </form>
</asp:Content>
