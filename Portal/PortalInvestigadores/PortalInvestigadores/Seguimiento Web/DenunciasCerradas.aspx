<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DenunciasCerradas.aspx.cs" Inherits="Portal_Investigadores.DenunciasCerradas" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="menu" runat="server">
</asp:Content>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <script src="scripts/events.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"></script>
        <style>
            .container {
                max-width: 90% !important;
            }
            #contenido_gvCerradas_length label
            {
                font-size: 12px;
                margin-left: 10px;
            }

            #contenido_gvCerradas_filter
            {
                float: none;
                font-size: 12px;
                padding-right: 10px;
            }

            #contenido_gvCerradas_filter label
            {
                font-size: 12px;
            }

            #contenido_gvCerradas_paginate
            {
                 font-size: 12px;
                 margin-bottom:20px;
            }

            #contenido_divCerradas div:nth-child(2)
            {
                width: 100%;
            }
        </style>

        <script>
            var idioma = '<%= Session["idioma"] %>'; 

            $(document).ready(function () {

                if (idioma == 2) {
                    $('#contenido_gvCerradas').DataTable({ info: false });
                } else {

                    $('#contenido_gvCerradas').DataTable({
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
                }
            });
        </script>

        <div class="container">

            <div class="row" style="margin-top:15px;"></div>

                <div runat="server" class="row" id="divCerradas" style="margin-top:21px;">
                    <div class="table-header">
                        <% row = tags.Select("id = '106'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>
                        <%--Denuncias Cerradas--%>
                    </div>
                    <asp:GridView ID="gvCerradas" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvCerradas_RowDataBound" CssClass="strip table table-hover table-dashboard">
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

                            <asp:HyperLinkField Text = "Detalle"
                                DataNavigateUrlFields="idDenuncia"
                                DataNavigateUrlFormatString="ReporteDenunciaCerrada.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                        </Columns>
                    </asp:GridView>
                </div>

        </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
