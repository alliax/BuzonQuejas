<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Portal_Investigadores.Dashboard" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="menu" runat="server">
</asp:Content>--%>

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
            #contenido_gvEquipo_length label, 
            #contenido_gvAsignadas_length label,
            #contenido_gvDelegadas_length label,
            #contenido_gvRevAuditoria_length label,
            #contenido_gvPendVoBo_length label
            {
                font-size: 12px;
                margin-left: 10px;
            }

            #contenido_gvEquipo_filter, 
            #contenido_gvAsignadas_filter,
            #contenido_gvDelegadas_filter,
            #contenido_gvRevAuditoria_filter,
            #contenido_gvPendVoBo_filter
            {
                float: none;
                font-size: 12px;
                padding-right: 10px;
            }

            #contenido_gvEquipo_filter label, 
            #contenido_gvAsignadas_filter label,
            #contenido_gvDelegadas_filter label,
            #contenido_gvRevAuditoria_filter label,
            #contenido_gvPendVoBo_filter label
            {
                font-size: 12px;
            }

            #contenido_gvEquipo_paginate, 
            #contenido_gvAsignadas_paginate,
            #contenido_gvDelegadas_paginate,
            #contenido_gvRevAuditoria_paginate,
            #contenido_gvPendVoBo_paginate
            {
                 font-size: 12px;
                 margin-bottom:20px;
            }
        </style>

        <script>
            var idioma = '<%= Session["idioma"] %>'; 

            $(document).ready(function () {

                $('#contenido_gvEquipo tbody tr td:nth-child(7)').hide();
                $('#contenido_gvEquipo thead tr th:nth-child(8)').hide();


                if (idioma == 2) {
                    $('#contenido_gvEquipo').DataTable({ info: false });
                    $('#contenido_gvAsignadas').DataTable({ info: false });
                    $('#contenido_gvDelegadas').DataTable({ info: false });
                    $('#contenido_gvPendVoBo').DataTable({ info: false });
                    $('#contenido_gvRevAuditoria').DataTable({ info: false });

                } else {

                    $('#contenido_gvEquipo').DataTable({
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

                    $('#contenido_gvAsignadas').DataTable({
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

                    $('#contenido_gvDelegadas').DataTable({
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

                    $('#contenido_gvPendVoBo').DataTable({
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

                    $('#contenido_gvRevAuditoria').DataTable({
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
            <%--Indicadores Principales--%>
            <div class="row" style="margin-top:15px;">
                
                <% if(Session["esRevisor"].ToString() == "True" || Session["esEnterado"].ToString() == "True") { %>

                    <%--Equipo--%>
                    <div class="col" onclick="document.getElementById('contenido_divEquipo').scrollIntoView(false);" >
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">

                                <img class="dashboard-img" src="img/Revisor.svg" />
                                <div runat="server" id="numberEquipo" class="numbers">0</div>
                                <p class="card-text indPrin"> <% row = tags.Select("id = '1'");  if (row.Length > 0){Response.Write(row[0][1]);} %></p> 
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>

                                <%--<button type="button"  runat="server" class="btn-detail" id="btnGotoPendAceptar" onclick="document.getElementById('contenido_divPendientes').scrollIntoView(false);"   ><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>
                
                    <%--Asignadas--%>
                    <div class="col" onclick="document.getElementById('contenido_divAsignadas').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">
                                <img class="dashboard-img" src="img/Asignadas.svg" />
                                <div runat="server" id="numberAsignadas" class="numbers">0</div>
                                <p class="card-text indPrin"><% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail"  onclick="document.getElementById('contenido_divAsignadas').scrollIntoView(false);"><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                    <%--Delegadas--%>
                    <div class="col" onclick="document.getElementById('contenido_divDelegadas').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">
                                <img class="dashboard-img" src="img/Delegadas.svg" />
                                <div runat="server" id="numberDelegadas" class="numbers">0</div>
                                <p class="card-text indPrin" ><% row = tags.Select("id = '3'");    if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail" onclick="document.getElementById('contenido_divDelegadas').scrollIntoView(false);" ><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                    <%--Pendientes VoBo--%>
                    <div class="col" onclick="document.getElementById('contenido_divPendVoBo').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">

                                <img class="dashboard-img" src="img/Vobo.svg" />
                                <div runat="server" id="numberPendVoBo" class="numbers">0</div>
                                <p class="card-text indPrin"><% row = tags.Select("id = '4'");    if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail" onclick="document.getElementById('contenido_divPendVoBo').scrollIntoView(false);"><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                    <%--Revision Auditoria--%>
                    <div class="col" onclick="document.getElementById('contenido_divRevAuditoria').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 14.4rem;">
                            <div class="card-body ">
                                <img class="dashboard-img" src="img/Revision.svg" />
                                <div runat="server" id="numberRevAuditoria" class="numbers">0</div>
                                <p class="card-text indPrin"><% row = tags.Select("id = '5'"); if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail" onclick="document.getElementById('contenido_divRevAuditoria').scrollIntoView(false);"><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                <% } else{ %>
                    
                    <%--Asignadas--%>
                    <div class="col" onclick="document.getElementById('contenido_divAsignadas').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 18rem;">
                            <div class="card-body ">
                                <img class="dashboard-img" src="img/Asignadas.svg" />
                                <div runat="server" id="numberAsignadas2" class="numbers">0</div>
                                <p class="card-text indPrin"><% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail"  onclick="document.getElementById('contenido_divAsignadas').scrollIntoView(false);"><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                    <%--Delegadas--%>
                    <div class="col" onclick="document.getElementById('contenido_divDelegadas').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 18rem;">
                            <div class="card-body ">
                                <img class="dashboard-img" src="img/Delegadas.svg" />
                                <div runat="server" id="numberDelegadas2" class="numbers">0</div>
                                <p class="card-text indPrin" ><% row = tags.Select("id = '3'");    if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail" onclick="document.getElementById('contenido_divDelegadas').scrollIntoView(false);" ><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                    <%--Pendientes VoBo--%>
                    <div class="col" onclick="document.getElementById('contenido_divPendVoBo').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 18rem;">
                            <div class="card-body ">

                                <img class="dashboard-img" src="img/Vobo.svg" />
                                <div runat="server" id="numberPendVoBo2" class="numbers">0</div>
                                <p class="card-text indPrin"><% row = tags.Select("id = '4'");  if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail" onclick="document.getElementById('contenido_divPendVoBo').scrollIntoView(false);"><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>

                    <%--Revision Auditoria--%>
                    <div class="col" onclick="document.getElementById('contenido_divRevAuditoria').scrollIntoView(false);">
                        <div class="card card text-center agrandar" style="width: 18rem;">
                            <div class="card-body ">
                                <img class="dashboard-img" src="img/Revision.svg" />
                                <div runat="server" id="numberRevAuditoria2" class="numbers">0</div>
                                <p class="card-text indPrin"><% row = tags.Select("id = '5'"); if (row.Length > 0){Response.Write(row[0][1]);}  %></p>
                                <%--<a href="#" class="card-link">Ver Detalle</a>--%>
                                <%--<button type="button" class="btn-detail" onclick="document.getElementById('contenido_divRevAuditoria').scrollIntoView(false);"><% row = tags.Select("id = '12'");   if (row.Length > 0){Response.Write(row[0][1]);}  %></button>--%> 
                            </div>
                        </div>
                    </div>
                <% } %>

            </div>
         
            <%--Equipo--%>
            <% if( Session["esRevisor"].ToString() == "True" || Session["esEnterado"].ToString() == "True") { %>
                <div class="row" runat="server" id="divEquipo" style="margin-top:21px;">
                    <div class="table-header">
                         <% row = tags.Select("id = '1'");  if (row.Length > 0){Response.Write(row[0][1]);}   %>  
                    </div>
                    <asp:GridView ID="gvEquipo" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvEquipo_RowDataBound" ShowHeader="true" CssClass="strip table table-hover ">
                        <Columns>
                            <%--<asp:LinkButton  runat="server" ButtonType="Button" ControlStyle-CssClass="btn-detail" onclick="Display"/>
                                <asp:HyperLinkField ControlStyle-CssClass="btn-detail"  onclick="Display" />--%>
                            <%--<button type="button" class="btn-detail">Detalle</button> </td>--%>

                                    <%--<asp:LinkButton runat="server" CssClass="btn-detail" Text="Detalle" data-toggle="modal" data-target=".bd-example-modal-xl" OnClick="Display"/>--%>
                                    <%--<asp:LinkButton runat="server" CssClass="btn-detail" Text="Detalle" OnClick="Display"/>--%>
                                <asp:HyperLinkField Text = "Detalle"
                                    DataNavigateUrlFields="idDenuncia"
                                    DataNavigateUrlFormatString="Detalle.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                                                         
                        </Columns>
                    </asp:GridView>
                </div>
            <% } %>

            <%--Asignadas--%>
            <div runat="server" class="row" id="divAsignadas" style="margin-top:21px;">
                <div class="table-header">
                    <% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>
                </div>
                <asp:GridView ID="gvAsignadas" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvAsignadas_RowDataBound" CssClass="strip table table-hover table-dashboard">
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
                            DataNavigateUrlFormatString="Detalle.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                    </Columns>
                </asp:GridView>
            </div>

            <%--Delegadas--%>
            <div runat="server" class="row" id="divDelegadas" style="margin-top:21px;"> 
                <div class="table-header">
                     <% row = tags.Select("id = '3'");  if (row.Length > 0){Response.Write(row[0][1]);}   %>  
                </div>
                <asp:GridView ID="gvDelegadas" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvDelegadas_RowDataBound" CssClass="table table-hover table-dashboard">
                    <Columns>
                        <asp:HyperLinkField Text ="Detalle"
                            DataNavigateUrlFields="idDenuncia"
                            DataNavigateUrlFormatString="Detalle.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                    </Columns>
                </asp:GridView>
            </div>

            <%--Pendientes VoBo--%>
            <div runat="server" class="row" id="divPendVoBo" style="margin-top:21px;">
                <div class="table-header">
                     <% row = tags.Select("id = '4'");  if (row.Length > 0){Response.Write(row[0][1]);}   %>  
                </div>
                <asp:GridView ID="gvPendVoBo" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvPendVoBo_RowDataBound" CssClass="table table-hover table-dashboard">
                    <Columns>
                        <asp:HyperLinkField Text ="Detalle"
                            DataNavigateUrlFields="idDenuncia"
                            DataNavigateUrlFormatString="Detalle.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                    </Columns>
                </asp:GridView>
            </div>
         
            <%--Revision Auditoria--%>
            <div runat="server" class="row" id="divRevAuditoria" style="margin-top:21px;">
                <div class="table-header">
                     <% row = tags.Select("id = '5'");  if (row.Length > 0){Response.Write(row[0][1]);}   %>  
                </div>
                <asp:GridView ID="gvRevAuditoria" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvRevAuditoria_RowDataBound" CssClass="table table-hover table-dashboard">
                    <Columns>
                        <asp:HyperLinkField Text ="Detalle"
                            DataNavigateUrlFields="idDenuncia"
                            DataNavigateUrlFormatString="DetalleLite.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                    </Columns>
                </asp:GridView>
            </div>

         </div>
    </form>
    <br />
    <br />
    <br />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
