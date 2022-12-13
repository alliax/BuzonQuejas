<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AltaMensaje.aspx.cs" Inherits="Portal_Investigadores.AltaMensaje" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
           

        <%--Referencias para Data Tables--%>
        <%--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css"/>--%>
        
        <%--<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css"/>--%>
        <%--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"/>--%>

        <%--<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.foundation.min.css"/>--%>

        <%--<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css"/>--%>
        <%--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.semanticui.min.css"/>--%>

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
        

        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"></script>
    <style>
        #contenido_asociadasGV_filter{
            float: none;
            font-size: 12px;
            padding-right: 10px;
        }
        #contenido_asociadasGV_paginate, #contenido_asociadasGV_length{
            display:none;
        }
    </style>
<script type="text/javascript">

    $(document).ready(function () {

        $('#contenido_asociadasGV').DataTable({
            info: false,
            "language": {
                "sProcessing": "Procesando...",
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "No se encontraron resultados",
                "sEmptyTable": "Ningún dato disponible en esta tabla =(",
                "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix": "",
                "sSearch": "Buscar:",
                "sUrl": "",
                "sInfoThousands": ",",
                "sLoadingRecords": "Cargando...",
                "oAria": {
                    "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                },
                "buttons": {
                    "copy": "Copiar",
                    "colvis": "Visibilidad"
                }
            }
        });

  var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
            $.ajax({
                type: "GET",
                url: "AltaMensaje.aspx/BQ_Etiquetas",
                data: $.param({ iId: 2, iIdioma: Idioma }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 2) { $("#lbl2").html(Json[i].Texto) }
                    if (Json[i].Id == 3) { $("#lbl3").html(Json[i].Texto); $("#lbl8").html(Json[i].Texto) }
                    if (Json[i].Id == 4) { $("#lbl4").html(Json[i].Texto) }
                    if (Json[i].Id == 5) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 6) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 7) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 8) { $("#lbl9").html(Json[i].Texto) }
                    if (Json[i].Id == 9) { $("#lbl10").html(Json[i].Texto) }
                    if (Json[i].Id == 10) { $("#lbl11").html(Json[i].Texto) }
                    if (Json[i].Id == 11) { $("#lbl12").html(Json[i].Texto) }
                    if (Json[i].Id == 12) { $("#lbl13").html(Json[i].Texto) }
                    if (Json[i].Id == 13) { $("#lbl14").html(Json[i].Texto) }
                    if (Json[i].Id == 14) { $("#lbl15").html(Json[i].Texto) }
                    if (Json[i].Id == 15) { $("#lbl16").html(Json[i].Texto) }
                    if (Json[i].Id == 18) { $("#lbl17").html(Json[i].Texto) }
                    if (Json[i].Id == 16) { $("#lbl18").html(Json[i].Texto) }
                    if (Json[i].Id == 17) { $("#lbl19").html(Json[i].Texto) }  
                    if (Json[i].Id == 18) { $("#lbl20").html(Json[i].Texto) }
                    if (Json[i].Id == 20) { $("#lbl21").html(Json[i].Texto) }
                    if (Json[i].Id == 21) { $("#lbl22").html(Json[i].Texto) }
                    if (Json[i].Id == 22) { $("#lbl23").html(Json[i].Texto) }
                    if (Json[i].Id == 23) { $("#lbl24").html(Json[i].Texto) }
                    if (Json[i].Id == 24) { $("#lbl25").html(Json[i].Texto) }
                    if (Json[i].Id == 25) { $("#lbl26").html(Json[i].Texto) }
                    if (Json[i].Id == 26) { $("#lbl27").html(Json[i].Texto) }
                    if (Json[i].Id == 27) { $("#lbl28").html(Json[i].Texto) }
                    if (Json[i].Id == 28) { $("#lbl29").html(Json[i].Texto) }
                    if (Json[i].Id == 29) { $("#lbl30").html(Json[i].Texto) }
                    if (Json[i].Id == 30) { $("#lbl31").html(Json[i].Texto) }
                    if (Json[i].Id == 31) { $("#lbl32").html(Json[i].Texto) }
                    if (Json[i].Id == 32) { $("#lbl33").html(Json[i].Texto) }
                    if (Json[i].Id == 33) { $("#lbl34").html(Json[i].Texto) }
                    if (Json[i].Id == 34) { $("#lbl35").html(Json[i].Texto) }
                    if (Json[i].Id == 35) { $("#lbl36").html(Json[i].Texto) }
                    if (Json[i].Id == 35) { $("#lbl36").html(Json[i].Texto) }
                    if (Json[i].Id == 36) { $("#<%=invNombre.ClientID%>").attr("placeholder", Json[i].Texto); }
                    if (Json[i].Id == 37) { $("#<%=invApellido.ClientID%>").attr("placeholder", Json[i].Texto); }
                    if (Json[i].Id == 38) { $("#<%=invPuesto.ClientID%>").attr("placeholder", Json[i].Texto); }
                    if (Json[i].Id == 39) { $("#<%=btnAddInv.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 40) { $("#lbl37").html(Json[i].Texto) }
                    if (Json[i].Id == 41) { $("#lbl38").html(Json[i].Texto) }
                    if (Json[i].Id == 42) { $("#<%=btnMensajesInt.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 43) { $("#lbl39").html(Json[i].Texto) }
                    if (Json[i].Id == 44) { $("#lbl40").html(Json[i].Texto) }
                    if (Json[i].Id == 45) { $("#lbl41").html(Json[i].Texto) }
                    if (Json[i].Id == 46) { $("#lbl42").html(Json[i].Texto) }
                    if (Json[i].Id == 45) { $("#lbl43").html(Json[i].Texto) }
                    if (Json[i].Id == 47) { $("#lbl44").html(Json[i].Texto) }
                    if (Json[i].Id == 48) { $("#lbl45").html(Json[i].Texto) }
                    if (Json[i].Id == 49) { $("#lbl46").html(Json[i].Texto) }
                }

                },
                error: function (r) {
                    alert(r.d);
                }
            });

 }); // Document Ready
           
function createJson(strJson) {
        var strJson = JSON.stringify(strJson);
        var iJsonLenght = strJson.length
        strJson = strJson.substr(5, iJsonLenght);
        strJson = strJson.slice(0, -1)
        var Json = JSON.parse(strJson);
        Json = JSON.parse(Json);

        return Json;
}
</script>
    <form id="form" runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <link href="css/altaMensaje.css" rel="stylesheet" />
    <div class="container">
        <div class="row"style="margin-top:21px;">
            <div class="table-header" runat="server" id="msgId"> 
                <h4>
                    Folio: <span runat="server" id="folio" class="badge badge-secondary" style="font-size:x-large"></span> 
                    Estatus: <span runat="server" id="estatusFolio" class="badge badge-secondary"></span> 

                </h4>
            </div>                                
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                <label id ="lbl2">Información General</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id ="lbl3" for="inputTitulo">Título</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtTitulo"/>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label for="inputClasificacion" id ="lbl4">Clasificación</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlClasificacion">                                       
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="inputResponsable" id ="lbl5">Responsable</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlResponsable">                                        
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                <label id="lbl6" >Fechas</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl7" for="fechaRegistro">Registro</label>
                                <asp:TextBox Width="100%" runat="server" CssClass="form-control" ID="fechaRegistro" Enabled="false" TextMode="DateTime"/>
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl8" for="fechaClasificacion">Clasificación</label>
                                <asp:TextBox Width="100%" runat="server" CssClass="form-control" ID="fechaClasificacion" Enabled="false" TextMode="DateTime" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl9" for="ultimaAct">Última Actualización</label>
                                <asp:TextBox Width="100%" runat="server" CssClass="form-control" ID="ultimaActualizacion" Enabled="false" TextMode="DateTime"/>
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-3 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                                <label id="lbl10">Ubicación</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl11" for="selGrupo">Grupo</label>
                                <asp:DropDownList Enabled="false" runat="server" CssClass="form-control" ID="ddlGrupo" />                                                                    
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl12" for="selEmpresa">Empresa</label>
                                <asp:DropDownList Enabled="false" runat="server" CssClass="form-control" ID="ddlEmpresa" />                                                                    
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl13" for="selSitio">Sitio</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlSitio">                                    
                                </asp:DropDownList>
                            </div>
                             <div class="form-group col-md-12">
                                <label id="lbl14" for="selDepartamento">Departamento</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlDepartamento">                                    
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                 <!---->
                <div class="col-md-6 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                <label id="lbl15">Denunciante</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label id="lbl16" for="inputNombre">Nombre</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtNombre" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label id="lbl17" for="inputGrupo">Correo</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtCorreo" placeholder="info@example.com"/>
                                </div>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label id="lbl18" for="inputGrupo">Apellido Paterno</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtPaterno" />
                                </div>
                                    <div class="form-group col-md-6">
                                    <label id="lbl19" for="inputGrupo">Apellido Materno</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtMaterno" />
                                </div>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label id="lbl20" for="inputTelefono">Teléfono</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtTelefono" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label id="lbl21" for="inputTipo">Tipo</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlTipo" />                                                                    
                                </div>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6 col-xs-6">
                                    <label for="checkAnonimo">Anónimo</label>
                                    <asp:CheckBox AutoPostBack="true" OnCheckedChanged="chbkAnonimo_CheckedChanged" runat="server" ID="chbkAnonimo" />
                                </div>
                                <div class="form-group col-md-6 col-xs-6">
                                    <label id="lbl23" for="chbkSolAnonimo">Solicitud Anónimo</label>
                                    <asp:CheckBox runat="server" ID="chbkSolAnonimo" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-inbox" aria-hidden="true"></span>
                                <label id="lbl24">Mensaje</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl25" for="selImportancia">Importancia</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlImportancia" />                                                                    
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl26" for="selConducto">Conducto</label>
                                <asp:DropDownList OnSelectedIndexChanged="ddlConducto_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control" ID="ddlConducto" />                                                                    
                            </div>                            
                            <div class="form-group col-md-12">
                                <label id="lbl27" for="selForma">Forma</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlForma" />
                            </div>
                        </div>
                    </div>
                </div>
                <!---->
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-text-color" aria-hidden="true"></span>
                                <label id="lbl28">Mensaje</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl29">Nuevo: Visible para auditoría</label>
                                <asp:TextBox TextMode="MultiLine" Wrap="true" runat="server" CssClass="form-control" ID="txtMensaje2"/>
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl30">Detalle </label>
                                <asp:TextBox TextMode="MultiLine" Wrap="true" runat="server" CssClass="form-control" ID="txtDetalle" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl31">Resumen</label>
                                <asp:TextBox TextMode="MultiLine" Wrap="true" runat="server" CssClass="form-control" ID="txtResumen" />
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
                                <label id="lbl32">Tema y Subtema</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label id="lbl33" for="selTema">Tema</label>
                                    <asp:DropDownList OnSelectedIndexChanged="ddlTema_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control" ID="ddlTema" />                                
                                </div>
                                <div class="form-group col-md-4">
                                    <label id="lbl34" for="selSubtema">Subtema</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlSubtema" />                                
                                </div>
                                <div class="form-group col-md-4">
                                    <label id="lbl35">Documentos</label>
                                    <button type="button" class="btnFile btn-primary">
                                        <span class="glyphicon glyphicon-file" aria-hidden="true">Subir documentos</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                 <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                <label id="lbl36">Involucrados</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <asp:TextBox runat="server" CssClass="form-control" ID="invNombre" placeholder="Nombre"/>
                            </div>
                            <div class="form-group col-md-12">
                                <asp:TextBox runat="server" CssClass="form-control" ID="invApellido" placeholder="Apellido" />
                            </div>
                            <div class="form-group col-md-12">
                                <asp:TextBox runat="server" CssClass="form-control" ID="invPuesto" placeholder="Puesto" />
                            </div>
                            <div class="form-group col-md-12">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlPosicion" />                                
                            </div>
                            <div class="form-group col-md-4">
                                <asp:Button runat="server" CssClass="btn btn-primary" ID="btnAddInv" Text="Guardar" OnClick="addInvolucrados" />
                            </div>    
                            <div class="col-md-12" id="divInvolucrados">
                                <div style="overflow-y:scroll; height:150px">
                                <asp:GridView ID="gvInv" CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server"  AutoGenerateColumns="false">
                                    <Columns>  
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />                                         
                                        <asp:BoundField DataField="Puesto" HeaderText="Puesto"  /> 
                                        <asp:BoundField DataField="Posicion" HeaderText="Posicion"  /> 
                                    </Columns>
                                </asp:GridView>
                                 </div>
                            </div>
                        </div>                
                    </div>
                </div>
            <!---->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span>
                                <label id="lbl37">Asociar</label>
                            </p>
                        </div>
                        <div class="card-footer">
                            <div class="input-group ">
                                <span class="input-group-btn">
                                    <label class="btn-sm" style="font-weight:bold;">Asociar a</label>
                                </span>
                                <asp:DropDownList CssClass="form-control" runat="server" ID="asociadosDDL" Enabled="false">                                    
                                </asp:DropDownList>
                                <span class="input-group-btn">
                                    <asp:Button runat="server" OnClick="desasociar_Click" ID="desasociar" CssClass="btn btn-danger btn-sm" Text="Desasociar" />                                    
                                </span>
                            </div>
                        </div>
                        <div class="card-body">
                            <asp:GridView OnSelectedIndexChanged="asociadasGV_SelectedIndexChanged" runat="server" ID="asociadasGV" OnRowDataBound="asociadasGV_RowDataBound" AutoGenerateColumns="true" CssClass="strip table table-hover table-dashboard">                        
                                <Columns>
                                    <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="asociarBTN" runat="server" CommandName="Select" Text="Asociar" CssClass="btn btn-primary btn-sm"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-6 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p> 
                               <span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
                                <label id="lbl38">Comentarios Internos</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div style="overflow-y:scroll; height:150px">
                                <asp:GridView CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvCom" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Comentario" /> 
                                    </Columns>                          
                                 </asp:GridView>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="input-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtMsg" max-length="400" placeholder="Escribe tu mensaje.."/>
                                <span class="input-group-btn">
                                    <asp:Button Id="btnMensajesInt" runat="server" CssClass="form-control btn btn-warning" Text="Agregar" OnClick="addMensajesInt" ></asp:Button>
                                </span>                                    
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-6 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-send" aria-hidden="true"></span>
                                <label id="lbl39">Asignación de Responsable y Area</label>
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl40">Área Asignada</label>
                                <div class="inputGroupContainer">
                                    <div class="input-group">
                                        <span class="input-group-addon" aria-hidden="true" style="max-width: 100%;">
                                            <i class="glyphicon glyphicon-list"></i>
                                        </span>
                                        <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control" />                                         
                                    </div>
                                </div>
                            </div>
                            <div class="form-row" style="padding-bottom: 10px;">
                                <p id="lbl41">Responsable</p>
                            </div>
                            <div class="col-md-12">
                                <div class="form-row form-group">
                                    <label class="col-sm-4 " id="lbl42">Grupo</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList Enabled="false" runat="server" CssClass="form-control" ID="ddlGrupo2" />                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-row form-group">
                                    <label id="lbl43" class="col-sm-4">Responsable</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList OnSelectedIndexChanged="ddlResponsable2_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control form-control-sm" ID="ddlResponsable2" />                                            
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <div class="input-group mb-3">
                                  <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">@</span>
                                  </div>
                                  <asp:TextBox runat="server" CssClass="form-control" ID="txtEmail" Enabled="false"/>
                                </div>
                            </div>                            
                            <div class="form-group form-row col-md-12">
                                <label id="lbl44" class="col-sm-2 col-form-label">Revisor</label>
                                <div class="form-group col-sm-5">
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="idRevisor" style="display:none;"/>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtRevisor" Enabled="false"/>
                                </div>
                                <div class="form-group col-sm-5">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="revisorEmail" Enabled="false" />
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <asp:CheckBox runat="server" ID="revisorInc" />
                                <label id="lbl45" for="chbkRevisor">Deseas incluir al revisor?</label>
                            </div>
                            <div class="col-md-12">
                                <label id="lbl46">Enterados</label>
                                <asp:TextBox runat="server" ID="enterados" Width="100%" TextMode="MultiLine" Wrap="true" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                 <asp:Panel Visible="false" runat="server" ID="error">
                    <div runat="server" id="divError" class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong runat="server" id="msgError"></strong>.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </asp:Panel>
                <div class="form-row col-md-12" style="padding-top:15px;">
                    <div class="form-group col-md-4 offset-md-4 btns">
                        <asp:Button OnClick="btnGuardar_Click" runat="server" ID="btnGuardar" CssClass="btn btn-primary" Text="Guardar" />
                    </div>
                    <div class="form-group col-md-4 btns">
                        <asp:Button runat="server" ID="btnEnviar" OnClick="btnEnviar_Click" CssClass=" btn btn-danger" Text="Enviar a VOBO" />                        
                    </div>
                    <div class="form-group col-md-4 btns">
                        <asp:Button OnClick="btnCancel_Click" Visible="false" runat="server" ID="btnCancel" CssClass="btn btn-danger" Text="Cancelar"/>
                    </div>
                    <div class="form-group col-md-4 btns">
                        <asp:Button OnClick="btnAceptar_Click" Visible="false" runat="server" ID="btnAceptar" CssClass="btn btn-primary" Text="Aceptar" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>