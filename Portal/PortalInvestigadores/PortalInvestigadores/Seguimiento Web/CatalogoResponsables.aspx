<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CatalogoResponsables.aspx.cs" Inherits="Portal_Investigadores.CatalogoResponsables" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <script src="scripts/events.js"></script>

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
            #contenido_gvResponsables_length label
            {
                font-size: 12px;
                margin-left: 10px;
            }

            #contenido_gvResponsables_filter
            {
                float: none;
                font-size: 12px;
                padding-right: 10px;
            }

            
            #contenido_gvResponsables_filter label
            {
                font-size: 12px;
            }

            #contenido_gvResponsables_paginate
            {
                 font-size: 12px;
                 margin-bottom:20px;
            }
        </style>

        <script>
            $(document).ready(function () {

                $('#contenido_gvResponsables').DataTable({
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

            });
        </script>
        
        
        <div class="container" style="max-width:95% !important;">
            <%--Indicadores Principales--%>
            <div class="row" style="margin-top:15px;">
                
            </div>

            <div class="form-row" style="width: 100%;">
                <div class="form-group ml-auto" style="width:200px!important; margin-right: 5px;">
                    <button type="button" class="btn btn-secondary" onclick="location.href='ReasignarDenuncias.aspx';" >Reasignar Denuncias</button>
                </div>
                <div class="form-group" style="width:200px!important;">
                    <button id="gdaUsuario" type="button" class="btn btn-secondary"  onclick="location.href='Responsable.aspx';">Agregar Nuevo Usuario</button>
                </div>
            </div>

            <%--Asignadas--%>
            <div runat="server" class="row" id="divResponsables" style="margin-top:5px;">
                <div class="table-header">
                    Responsables <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                <asp:GridView ID="gvResponsables" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvResponsables_RowDataBound" CssClass="strip table table-hover table-dashboard">
                    <Columns>
                        <%--<asp:BoundField DataField="id" HeaderText="" ReadOnly="true" SortExpression="idRelevante"  />
                        <asp:BoundField DataField="Titulo" HeaderText="" ReadOnly="true" HeaderStyle-Width="50" SortExpression="Nombre" />
                        <asp:BoundField DataField="Grupo" HeaderText="" ReadOnly="true" SortExpression="Tema" />
                        <asp:BoundField DataField="Empresa" HeaderText="" ReadOnly="true" SortExpression="Area" />
                        <asp:BoundField DataField="Sitio" HeaderText="" ReadOnly="true" SortExpression="Coordinador" />
                        <asp:BoundField DataField="fechaClasificación" HeaderText="" ReadOnly="true" SortExpression="Revisor" />
                        <asp:BoundField DataField="Antiguedad" HeaderText="" ReadOnly="true" SortExpression="Ubicacion"/>--%>
                        <%--<asp:BoundField DataField="auditor" HeaderText="Auditor" ReadOnly="true" SortExpression="auditor"/>--%>

                        <%--<asp:ButtonField DataTextField="id"  ButtonType="Link"  />--%>

                        <asp:HyperLinkField Text ="Editar"
                            DataNavigateUrlFields="idusuario"
                            DataNavigateUrlFormatString="Responsable.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                    </Columns>
                </asp:GridView>
            </div>
         
         </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
