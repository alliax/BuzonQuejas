<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BuscadorDenuncias.aspx.cs" Inherits="Portal_Investigadores.BuscadorDenuncias" %>
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
            #contenido_gvDenuncias_length label
            {
                font-size: 12px;
                margin-left: 10px;
            }

            #contenido_gvDenuncias_filter
            {
                float: none;
                font-size: 12px;
                padding-right: 10px;
            }

            #contenido_gvDenuncias_filter label
            {
                font-size: 12px;
            }

            #contenido_gvDenuncias_paginate
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
                    $('#contenido_gvDenuncias').DataTable({ info: false });
                } else {

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
                }
            });
        </script>

        <div class="container">

            <div class="row" style="margin-top:15px;"></div>

                <div runat="server" class="row" id="divCerradas" style="margin-top:21px;">
                    <div class="table-header">
                        <%--<% row = tags.Select("id = '106'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                        Denuncias
                    </div>
                    <asp:GridView ID="gvDenuncias" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvDenuncias_RowDataBound" CssClass="strip table table-hover table-dashboard">
                        <Columns>

                            <asp:HyperLinkField Text = "Detalle"
                                DataNavigateUrlFields="idDenuncia"
                                DataNavigateUrlFormatString="DenunciaDetallada.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                        </Columns>
                    </asp:GridView>
                </div>

        </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
