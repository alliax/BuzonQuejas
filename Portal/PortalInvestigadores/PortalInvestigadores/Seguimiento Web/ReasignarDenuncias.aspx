<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReasignarDenuncias.aspx.cs" enableEventValidation="false" Inherits="Portal_Investigadores.ReasignarDenuncias" MaintainScrollPositionOnPostback="true"%>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
         <script src="scripts/events.js"></script>
        <br />
         <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"></script>
        <script>
            $(document).ready(function ()
            {
                //$('#contenido_gvDenuncias').prepend($("<thead></thead>").append($(this).find("#contenido_gvDenuncias tr:first")));
                //SearchText();
                    $('#contenido_gvDenuncias').DataTable({
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
                            "oPaginate": {
                                "sFirst": "Primero",
                                "sLast": "Último",
                                "sNext": "Siguiente",
                                "sPrevious": "Anterior"
                            },
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

                    //$('#contenido_ddlGrupo').change(function () {

                    //    if ($('#contenido_ddlGrupo').val() != "0") {
                    //        $('#contenido_ddlGrupo2').val($('#contenido_ddlGrupo').val());
                    //        cargarEmpresas(1);
                    //        cargarEmpresas(2);
                    //        cargarResponsables($('#contenido_ddlGrupo').val(), "", "", 1);
                    //        cargarResponsables($('#contenido_ddlGrupo').val(), "", "", 2);
                    //    } else {
                    //        $('#contenido_ddlEmpresa').empty();
                    //    }


                    //});

                    //$('#contenido_ddlGrupo2').change(function () {

                    //    if ($('#contenido_ddlGrupo2').val() != "0") {
                    //        cargarEmpresas(2);
                    //        cargarResponsables($('#contenido_ddlGrupo2').val(), "", "", 2);
                    //    } else {
                    //        $('#contenido_ddlEmpresa').empty();
                    //    }


                    //});

                    //$('#contenido_ddlEmpresa').change(function () {

                    //    if ($('#contenido_ddlEmpresa').val() != "0") {
                    //        $('#contenido_ddlEmpresa2').val($('#contenido_ddlEmpresa').val());
                    //        cargarSitios(1);
                    //        cargarSitios(2);
                    //        cargarResponsables($('#contenido_ddlGrupo').val(), $('#contenido_ddlEmpresa').val(), "", 1);
                    //        cargarResponsables($('#contenido_ddlGrupo2').val(), $('#contenido_ddlEmpresa').val(), "", 2);
                    //    } else {
                    //        $('#contenido_ddlSitio').empty();
                    //    }
                    //});

                    //$('#contenido_ddlEmpresa2').change(function () {

                    //    if ($('#contenido_ddlEmpresa2').val() != "0") {
                    //        cargarSitios(2);
                    //        cargarResponsables($('#contenido_ddlGrupo2').val(), $('#contenido_ddlEmpresa2').val(), "", 2);
                    //    } else {
                    //        $('#contenido_ddlSitio2').empty();
                    //    }
                    //});

                    //$('#contenido_ddlSitio').change(function () {

                    //    if ($('#contenido_ddlSitio').val() != "0") {
                    //        $('#contenido_ddlSitio2').val($('#contenido_ddlSitio').val());
                    //        cargarResponsables($('#contenido_ddlGrupo').val(), $('#contenido_ddlEmpresa').val(), $('#contenido_ddlSitio').val(), 1);
                    //        cargarResponsables($('#contenido_ddlGrupo2').val(), $('#contenido_ddlEmpresa').val(), $('#contenido_ddlSitio').val(), 2);
                    //    } else {
                    //        $('#contenido_ddlSitio').empty();
                    //    }
                    //});

                    //$('#contenido_ddlSitio2').change(function () {

                    //    if ($('#contenido_ddlSitio2').val() != "0") {
                    //        cargarResponsables($('#contenido_ddlGrupo2').val(), $('#contenido_ddlEmpresa2').val(), $('#contenido_ddlSitio2').val(), 2);
                    //    } else {
                    //        $('#contenido_ddlResponsable2').empty();
                    //    }
                    //});


                    //cargarResponsables("", "", "", 1);
                    //cargarResponsables("", "", "", 2);


                

            });
            //function crearTabla() {

            //    $('#contenido_gvDenuncias').DataTable({
            //        info: false,
            //        "language": {
            //            "sProcessing": "Procesando...",
            //            "sLengthMenu": "Mostrar _MENU_ registros",
            //            "sZeroRecords": "No se encontraron resultados",
            //            "sEmptyTable": "Ningún dato disponible en esta tabla =(",
            //            "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            //            "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            //            "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
            //            "sInfoPostFix": "",
            //            "sSearch": "Buscar:",
            //            "sUrl": "",
            //            "sInfoThousands": ",",
            //            "sLoadingRecords": "Cargando...",
            //            "oPaginate": {
            //                "sFirst": "Primero",
            //                "sLast": "Último",
            //                "sNext": "Siguiente",
            //                "sPrevious": "Anterior"
            //            },
            //            "oAria": {
            //                "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
            //                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            //            },
            //            "buttons": {
            //                "copy": "Copiar",
            //                "colvis": "Visibilidad"
            //            }
            //        }
            //    });
            //}

            function SelectAll(CheckBoxControl) {

                if (CheckBoxControl.checked == true) {
                    var i;

                    for (i = 0; i < document.forms[0].elements.length; i++) {

                        if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('gvDenuncias') > -1)) {
                            if (document.forms[0].elements[i].disabled) {
                                document.forms[0].elements[i].checked = false;
                            }
                            else {
                                document.forms[0].elements[i].checked = true;
                            }
                        }
                    }
                    if ($("#contenido_responsableReaDDL option:selected").val() != 0) {
                        $("#contenido_btnReasignar").removeAttr("disabled");
                    }

                } else {
                    var i;
                    for (i = 0; i < document.forms[0].elements.length; i++) {

                        if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('gvDenuncias') > -1)) {
                            document.forms[0].elements[i].checked = false;

                        }
                    }
                    $("#contenido_btnReasignar").attr("disabled", "disabled");
                }
            }
  
            function SearchText() {
                
                $("#contenido_txtResponsable").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "ReasignarDenuncias.aspx/CargarResponsables",
                            data: "{'resp':'" + document.getElementById('contenido_txtResponsable').value + "'}",
                            dataType: "json",
                            success: function (data) {
                                console.log(data.d);
                                //response($.map, data, function (responsable) {

                                var array = data.error ? [] : $.map(data.d, function (responsable) {
                                        return {
                                            nombre: responsable.nombre,
                                            idUsuario: responsable.idUsuario
                                        };
                                    });
                                    response(array);
                                //});
                            },
                            error: function (result) {
                                alert("No Match");
                            }
                        });
                    },
                    select: function (e, i) {
                        <%--$("#<%=hfCustomerId.ClientID %>").val(i.item.val);--%>
                    },
                    minLength: 1
                });

            } 

            //function cargarEmpresas(dropDown) {
            //    var $grupo;
            //    var $empresa;
                
            //    if (dropDown == 1) {
            //         $grupo = $('#contenido_ddlGrupo');
            //         $empresa = $('#contenido_ddlEmpresa');
            //    } else {
            //         $grupo = $('#contenido_ddlGrupo2');
            //         $empresa = $('#contenido_ddlEmpresa2');
            //    }

            //    var grupo = $grupo.val()

            //    $.ajax({
            //        type: "POST",
            //        url: 'ReasignarDenuncias.aspx/CargarEmpresas',
            //        // data: {'idDenuncia: ' + idDenuncia },
            //        data: JSON.stringify({ 'grupo': grupo }),
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (data) {
            //            var objdata = $.parseJSON(data.d);

            //            if (objdata.Empresas.length > 1) {
            //                $empresa.empty();

            //                for (i = 0; i < objdata.Empresas.length - 1; i++) {

            //                    var idEmpresa = objdata.Empresas[i]["0"];
            //                    var Empresa = objdata.Empresas[i]["1"];

            //                    $empresa.append(`<option value="` + idEmpresa + `"> ` + Empresa + `</option>`);

            //                }
            //                $empresa.val("0");

            //            }
            //        },
            //        complete: function () {

            //        },
            //        error: function (e) {
            //            console.log(e);
            //        }
            //    });
            //}

            //function cargarSitios(dropDown) {

            //    var $grupo;
            //    var $empresa;
            //    var $sitio;

            //    if (dropDown == 1) {
            //        $grupo = $('#contenido_ddlGrupo');
            //        $empresa = $('#contenido_ddlEmpresa');
            //        $sitio = $('#contenido_ddlSitio');
            //    } else {
            //        $grupo = $('#contenido_ddlGrupo2');
            //        $empresa = $('#contenido_ddlEmpresa2');
            //        $sitio = $('#contenido_ddlSitio2');
            //    }

            //    var grupo = $grupo.val()
            //    var empresa = $empresa.val()

            //    $.ajax({
            //        type: "POST",
            //        url: 'ReasignarDenuncias.aspx/CargarSitios',
            //        // data: {'idDenuncia: ' + idDenuncia },
            //        data: JSON.stringify({ 'grupo': grupo, 'empresa': empresa }),
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (data) {
            //            var objdata = $.parseJSON(data.d);

            //            if (objdata.Sitios.length > 1) {
            //                $sitio.empty();

            //                for (i = 0; i < objdata.Sitios.length - 1; i++) {

            //                    var idSitio = objdata.Sitios[i]["0"];
            //                    var Sitio = objdata.Sitios[i]["1"];

            //                    $sitio.append(`<option value="` + idSitio + `"> ` + Sitio + `</option>`);

            //                }
            //                $sitio.val("0");

            //            }
            //        },
            //        complete: function () {

            //        },
            //        error: function (e) {
            //            console.log(e);
            //        }
            //    });

            //}

            //function cargarResponsables(grupo, empresa, sitio, dropDown) {

            //    var $responsable;
               
            //    if (dropDown == 1) {
            //        $responsable = $('#contenido_ddlResponsable');
            //    } else {
            //        $responsable = $('#contenido_ddlResponsable2');
            //    }

            //    $.ajax({
            //        type: "POST",
            //        url: 'ReasignarDenuncias.aspx/CargarResponsables',
            //        // data: {'idDenuncia: ' + idDenuncia },
            //        data: JSON.stringify({ 'grupo': grupo, 'empresa': empresa, 'sitio': sitio }),
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (data) {
            //            console.log(data);
            //            var objdata = $.parseJSON(data.d);

            //            if (objdata.responsable.length > 1) {
            //                $responsable.empty();

            //                for (i = 0; i < objdata.responsable.length - 1; i++) {

            //                    var idUsuario = objdata.responsable[i]["0"];
            //                    var nombre = objdata.responsable[i]["1"];

            //                    $responsable.append(`<option value="` + idUsuario + `"> ` + nombre + `</option>`);

            //                }
            //                $responsable.val("0");

            //            }
            //        },
            //        complete: function () {

            //        },
            //        error: function (e) {
            //            console.log(e);
            //        }
            //    });

            //}

        </script>
        <style>
            #contenido_divDenuncias div:nth-child(2) {
                width:100%;
            }

        </style>
        <div class="contenido2">
            <%--<label style="border: none; font-size: large">Captura nuevo director</label>--%>
            <%--<div ><h2>Reasignar Denuncias</h2></div>--%>
            <div>
                <div class="medio" style="display:none;">
                    
                   <%-- <asp:dropdownlist id="grupoDDL" runat="server" AutoPostBack="true" cssclass="almost form-control" onselectedindexchanged="grupoDDL_SelectedIndexChanged">
                        
                    </asp:dropdownlist>
                    <span style="color: red; font-weight: 800; font-size: larger">*</span>
                    <br />
                    <br />

                     <asp:dropdownlist id="empresaDDL" runat="server" AutoPostBack="true" cssclass="almost form-control" onselectedindexchanged="empresaDDL_SelectedIndexChanged">
                         <asp:ListItem selected hidden>Selecciona una Empresa</asp:ListItem>
                     </asp:dropdownlist>
                    <span style="color: red; font-weight: 800; font-size: larger">*</span>
                    <br />
                    <br />

                    <asp:dropdownlist id="sitioDDL" runat="server" AutoPostBack="true" cssclass="almost form-control" onselectedindexchanged="sitioDDL_SelectedIndexChanged">
                         <asp:ListItem selected hidden>Selecciona un Sitio</asp:ListItem>
                     </asp:dropdownlist>
                    <span style="color: red; font-weight: 800; font-size: larger">*</span>
                    <br />
                    <br />

                    <asp:dropdownlist id="responsableDDL" runat="server" AutoPostBack="true" cssclass="almost form-control" onselectedindexchanged="responsableDDL_SelectedIndexChanged">
                         <asp:ListItem selected hidden>Selecciona un Responsable</asp:ListItem>
                     </asp:dropdownlist>
                    <span style="color: red; font-weight: 800; font-size: larger">*</span>
                    <br />
                    <br />--%>

                    <%--<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                    <asp:TextBox id="txtResponsable" runat="server"  > </asp:TextBox>
                    <asp:HiddenField ID="hfCustomerId" runat="server" />--%>
                    
                    <br />
                    <br />
                    
                    <br />
                    <%--<div>
                         <asp:LinkButton runat="server" style="margin-right:2%;" OnClick="insertar_Director" CssClass="btn boton move dir">Guardar&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></asp:LinkButton>
                        <asp:LinkButton runat="server" OnClick="cancelar" CssClass="btn boton move dir">Cancelar&nbsp;<span class="glyphicon glyphicon-remove-circle"></span></asp:LinkButton>
                       
                    </div>--%>
                    <asp:TextBox ID="txtplanAccion" runat="server" Visible="false"></asp:TextBox>
                </div>
                <div class="medio" style="display:none;">
                                  
                   
                </div>
            </div>

        

            <div runat="server" class="row" id="div3" style="margin-top:5px;">
                <div class="table-header">
                    Reasignar Denuncias<%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                
                <div class="form-group col-md-6">
                    <label for="inputFolio">Denuncias asignadas como:</label>
                     <asp:DropDownList ID="ddlTipoAsignacion" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlTipoAsignacion_SelectedIndexChanged">
                        <asp:ListItem Text="Responsable" Value="1" />
                        <asp:ListItem Text="Revisor" Value="2" />
                    </asp:DropDownList>
                </div>

                <%--<div class="form-group col-md-2">
                    <label for="" style="color:white;">i</label>
                    <asp:button runat="server" CssClass="btn btn-secondary" OnClick="buscarPorDenuncia_OnClick" Text="Buscar" AutoPostBack="true"/>
                </div>--%>

            </div>

            <div runat="server" class="row" id="divResponsables" style="margin-top:21px; width:50%;">
                <div class="table-header">
                    Buscar por Responsable <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                                 
                    <div class="form-group col-md-6">
                        <label for="inputEmpresa">Grupo*</label>
                        <asp:DropDownList ID="ddlGrupo" runat="server" CssClass="form-control" OnSelectedIndexChanged="grupoDDL_SelectedIndexChanged" AutoPostBack="true">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                
                    <div class="form-group col-md-6">
                        <label for="inputSitio">Empresa*</label>
                        <asp:DropDownList ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="empresaDDL_SelectedIndexChanged">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                       
                    <div class="form-group col-md-6">
                        <label for="inputDepartamento">Sitio</label>
                        <asp:DropDownList ID="ddlSitio" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="sitioDDL_SelectedIndexChanged">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="inputDepartamento">Responsable*</label>
                        <asp:DropDownList ID="ddlResponsable" runat="server" CssClass="form-control" AutoPostBack="true">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                   
                    <div class="form-row" style="width: 100%;">
                        <%--<asp:TextBox runat="server" ID="txtValueResponsable" Text="1"></asp:TextBox>--%>
                        <div class="form-group col-md-2 ml-auto">
                            <asp:button runat="server" CssClass="btn btn-secondary" OnClick="buscarPorResponsable_OnClick" Text="Buscar" AutoPostBack="true"/>
                        </div>

                       <%-- <asp:dropdownlist id="Dropdownlist1" runat="server" AutoPostBack="true" cssclass="almost form-control" onselectedindexchanged="responsableDDL_SelectedIndexChanged">
                         <asp:ListItem selected hidden>Selecciona un Responsable</asp:ListItem>
                     </asp:dropdownlist>--%>

                    </div>              
                                
            </div>


            <div runat="server" class="row" id="div1" style="margin-top:5px; width:50%; float:left;">
                <div class="table-header">
                    Buscar por Denuncia <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                
                <div class="form-group col-md-6">
                    <label for="inputFolio">Id Denuncia</label>
                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtidDenuncia" />
                </div>

                <div class="form-group col-md-2">
                    <label for="" style="color:white;">i</label>
                    <asp:button runat="server" CssClass="btn btn-secondary" OnClick="buscarPorDenuncia_OnClick" Text="Buscar" AutoPostBack="true"/>
                </div>

            </div>

            <div runat="server" class="row" id="div2" style="margin-top:5px; width:50%; float:right; margin-top: -295px;">
                <div class="table-header">
                    Reasignar a <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>

                <div class="form-group col-md-6">
                        <label for="inputEmpresa">Grupo*</label>
                        <asp:DropDownList ID="ddlGrupo2" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlGrupo2_SelectedIndexChanged">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                
                    <div class="form-group col-md-6">
                        <label for="inputSitio">Empresa*</label>
                        <asp:DropDownList ID="ddlEmpresa2" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEmpresa2_SelectedIndexChanged">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                       
                    <div class="form-group col-md-6">
                        <label for="inputDepartamento">Sitio</label>
                        <asp:DropDownList ID="ddlSitio2" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSitio2_SelectedIndexChanged">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="inputDepartamento">Responsable*</label>
                        <asp:DropDownList ID="ddlResponsable2" runat="server" CssClass="form-control" AutoPostBack="false">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>

                <div class="form-group col-md-2 ml-auto">
                    <button type="button" class="btn btn-secondary" onclick="location.href='CatalogoResponsables.aspx';" >Cancelar</button>
                </div>

                <div class="form-group col-md-2">
                    <asp:button runat="server" ID="btnReasignar" CssClass="btn btn-secondary" OnClick="reasingar_denuncias" Text="Reasignar" AutoPostBack="true"/>
                    <%--<button type="button"  class="btn btn-primary" onclick="" >Reasignar</button>--%>
                </div>
            </div>

            <div runat="server" class="row" id="divDenuncias" style="margin-top:20px; width:100%; float: left;" visible ="false">
                <div class="table-header">
                    Denuncias a Reasignar <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                <asp:GridView ID="gvDenuncias" runat="server" AutoGenerateColumns="false" ShowHeader="true" ShowHeaderWhenEmpty="true" OnPreRender="gvDenuncias_PreRender"  OnRowDataBound="gvDenuncias_RowDataBound" OnDataBound="gvDenuncias_DataBound" CssClass="strip table table-hover table-dashboard"  EmptyDataText="No se encontraron denuncias para el Responsable seleccionado">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id"/>
                        <asp:BoundField DataField="Titulo" HeaderText="Titulo" />
                        <asp:BoundField DataField="Grupo" HeaderText="Grupo" />
                        <asp:BoundField DataField="Empresa" HeaderText="Empresa" />
                        <asp:BoundField DataField="Sitio" HeaderText="Sitio" />
                        <asp:BoundField DataField="idResponsable" HeaderText="idResponsable" Visible="false"/>
                        <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                    
                        <asp:TemplateField HeaderText="Reasignar All">
                            <HeaderTemplate>
                                All
                                <input id="chkSelect"  name="Select All"  onclick="SelectAll(this)" type="checkbox" ></input>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbDen" runat="server" AutoPostBack="true" OnCheckedChanged="cbRea_CheckChanged"  /> <%--<AutoPostBack="true"--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
           
            <br />
            <br />
        </div>
        </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
