<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Denunciados.aspx.cs" Inherits="Portal_Investigadores.Denunciados" %>
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
            #menu_menuNavbar,  #menu_menuLine{
                display:none;
            }
            body {
                /*font-size: .9rem;*/
            }
            table.dataTable tbody td {
                padding: 4px 3px;   
            }
            #contenido_txtFolio, #contenido_txtTipo, #contenido_txtUsuario {
                display: none;
            }
            #collapseInv2 {
                width:100%;
            }
            #contenido_gvDenunciados_wrapper,  #collapseInv2 {
                overflow-y: scroll;
                height: 250px;
            }
            #contenido_div1 .table-header {
                margin-bottom: 0px;
            }
            .table-header {
                margin-bottom: 5px;
            }
            .card-body {
                padding: 0px; 
            }
            .dataTables_wrapper.no-footer .dataTables_scrollBody {
                border-bottom: none;
            }
            a.btn-detail.add-Denunciado {
                color:white;
            }
        </style>

        <script>
            var idioma = '<%= Session["idioma"] %>'; 
            //cargarDenunciasAntecedentes();

            $(document).ready(function () {

                cargarDenunciasAntecedentes();

                if (idioma == 2) {
                    $('#contenido_gvDenunciados').DataTable({ info: false });
                    //$('#tblAntecedentes').DataTable({ info: false });
                } else {
                                
                    $('#contenido_gvDenunciados').DataTable({
                        info: false,
                        paging: false,
                        caseInsensitive: false,
                        bLengthChange: false,                        
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

                //cargarDenunciasAntecedentes();
                addDenunciado();
                deleteDenunciado();
            });

            (function () {

                function removeAccents(data) {
                    if (data.normalize) {
                        // Use I18n API if avaiable to split characters and accents, then remove
                        // the accents wholesale. Note that we use the original data as well as
                        // the new to allow for searching of either form.
                        return data + ' ' + data
                            .normalize('NFD')
                            .replace(/[\u0300-\u036f]/g, '');
                    }

                    return data;
                }

                var searchType = jQuery.fn.DataTable.ext.type.search;

                searchType.string = function (data) {
                    return !data ?
                        '' :
                        typeof data === 'string' ?
                            removeAccents(data) :
                            data;
                };

                searchType.html = function (data) {
                    return !data ?
                        '' :
                        typeof data === 'string' ?
                            removeAccents(data.replace(/<.*?>/g, '')) :
                            data;
                };

            }());


            function cargarDenunciasAntecedentes() {

                var idDenuncia = $('#contenido_txtFolio').val();
                var tipo = $('#contenido_txtTipo').val()

                //console.log(idDenuncia);

                $.ajax({
                    type: "POST",
                    url: 'Denunciados.aspx/CargarDenunciasAntecedentes',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idDenuncia': idDenuncia, 'tipo': tipo }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        //console.log(data);

                        var objdata = $.parseJSON(data.d);

                        $('#tableAnte tbody').empty();

                        if (objdata.Table1.length > 1) {

                            for (i = 0; i < objdata.Table1.length - 1; i++) {

                                var id = objdata.Table1[i]["0"];
                                var titulo = objdata.Table1[i]["1"];
                                var grupo = objdata.Table1[i]["2"];
                                var involucrados = objdata.Table1[i]["3"];
                                var madurez = objdata.Table1[i]["4"];

                                const $tableID = $('#tableAnte');/* href = "Cerrados_maint.asp?id=12093"*/

                                const newTr = `
                                        <tr>
                                            <td class="pt-3-half" contenteditable="false">` + id + `</td>
                                            <td class="pt-3-half" contenteditable="false">`+ titulo + `</td>
                                            <td class="pt-3-half" contenteditable="false">`+ grupo + `</td>
                                            <td class="pt-3-half" contenteditable="false">`+ involucrados + `</td>
                                            <td class="pt-3-half" contenteditable="false">`+ madurez + `</td>
                                            <td style = "min-width: 84px;" > <span><a title="Ver Denuncia Completa" href="http://alfaaic/buzon/Cerrados_maint.asp?id=`+ id + `" style="width:30px; margin-right: -5px;" class="btn btn-primary btn-rounded btn-sm my-0 table-save" target="_blank">+</a> <button type="button" title="Eliminar" style="width:30px;" class="btn btn-danger btn-rounded btn-sm my-0 del-Denunciado" >-</button ></span > </td >
                                        </tr>`;

                                if ($tableID.find('tbody').length > 0) {

                                    $('#tableAnte tbody').append(newTr);

                                }
                            }
                        } else {
                            //$('#tableAnte').hide();
                            //$('#collapseAnte .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 89; })[0].tag + '</p>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    },
                    complete: function (data) {

                        //$('#tblAntecedentes').DataTable({ info: false, paging: false, scrollY: 200 });
                    }
                });
            }

            function addDenunciado() {

                const $tableID = $('.tableDenunciados');

                $tableID.on('click', '.add-Denunciado', function () {

                    var idDenuncia;
                    var titulo;
                    var grupo;
                    var involucrado;
                    var madurez;
                    
                    $(this).parents('tr').each(function () {
                        //idDenuncia = $(this).find("td:first").html();
                        idDenuncia = $(this).find("td:nth-child(4)").html();
                        //titulo = $(this).find("td:nth-child(5)").html();
                        //grupo = $(this).find("td:nth-child(6)").html();
                        //involucrado = $(this).find("td:nth-child(1)").html();
                        //madurez = $(this).find("td:nth-child(9)").html();
                    });

                    console.log(idDenuncia);

                    $(this).parents('tr').hide();


                    //const newTr2 = `
                    //                    <tr>
                    //                        <td class="pt-3-half" contenteditable="false">`+ idDenuncia +`</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ titulo + `</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ grupo + `</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ involucrados + `</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ madurez + `</td>
                    //                        <td style = "min-width: 84px;" > <span><a title="Ver Denuncia Completa" href="Cerrados_maint.asp?id=`+ id + `" style="width:30px; margin-right: -5px;" class="btn btn-primary btn-rounded btn-sm my-0 table-save" target="_blank">+</a> <button type="button" title="Eliminar" style="width:30px;" class="btn btn-danger btn-rounded btn-sm my-0 table-remove" >-</button ></span > </td >
                    //                    </tr>`;


                    //$('#tblAntecedentes tbody').append(newTr2);

                    //table = $('#tblAntecedentes').DataTable({ info: false, paging: false, scrollY: 200 });

                    //table.destroy();

                    saveDenunciado($('#contenido_txtFolio').val(), idDenuncia, $('#contenido_txtTipo').val(), $('#contenido_txtUsuario').val());

                });

            }

            function deleteDenunciado() {

                const $tableID = $('#tblAntecedentes');

                console.log('entro al metodo');

                $tableID.on('click', '.del-Denunciado', function () {

                    var idDenunciaAnte;

                    $(this).parents('tr').each(function () {
                        //idDenuncia = $(this).find("td:first").html();
                        idDenunciaAnte = $(this).find("td:nth-child(1)").html();
                        //titulo = $(this).find("td:nth-child(5)").html();
                        //grupo = $(this).find("td:nth-child(6)").html();
                        //involucrado = $(this).find("td:nth-child(1)").html();
                        //madurez = $(this).find("td:nth-child(9)").html();
                    });

                    console.log(idDenunciaAnte + " idDenunciaAnte");

                    var idDenunciaDen;
                   
                    console.log();

                    var contador = 0;

                    $('.tableDenunciados tr').each(function () {

                        idDenunciaDen = $(this).find("td:nth-child(4)").html();

                        contador = contador + 1;

                        if (idDenunciaAnte == idDenunciaDen) {
                            $(this).show();

                            console.log("encontrado");
                        }

                    })

                    console.log(contador);

                    delDenunciado($('#contenido_txtFolio').val(), idDenunciaAnte, $('#contenido_txtTipo').val(), $('#contenido_txtUsuario').val());
                        //$(this).parents('tr').hide();


                    //const newTr2 = `
                    //                    <tr>
                    //                        <td class="pt-3-half" contenteditable="false">`+ idDenuncia +`</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ titulo + `</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ grupo + `</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ involucrados + `</td>
                    //                        <td class="pt-3-half" contenteditable="false">`+ madurez + `</td>
                    //                        <td style = "min-width: 84px;" > <span><a title="Ver Denuncia Completa" href="Cerrados_maint.asp?id=`+ id + `" style="width:30px; margin-right: -5px;" class="btn btn-primary btn-rounded btn-sm my-0 table-save" target="_blank">+</a> <button type="button" title="Eliminar" style="width:30px;" class="btn btn-danger btn-rounded btn-sm my-0 table-remove" >-</button ></span > </td >
                    //                    </tr>`;


                    //$('#tblAntecedentes tbody').append(newTr2);

                    //table = $('#tblAntecedentes').DataTable({ info: false, paging: false, scrollY: 200 });

                    //table.destroy();

                    //saveDenunciado($('#contenido_txtFolio').val(), idDenuncia, $('#contenido_txtTipo').val(), $('#contenido_txtUsuario').val());

                });

            }

            function saveDenunciado(id, idDenuncia, tipo, usuarioAlta) {

                $.ajax({
                    type: "POST",
                    url: 'Denunciados.aspx/saveDenunciado',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'id': id, 'idDenuncia': idDenuncia, 'tipo': tipo, 'usuarioAlta': usuarioAlta}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        cargarDenunciasAntecedentes();
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
                
            }

            function delDenunciado(id, idDenuncia, tipo, usuarioAlta) {

                $.ajax({
                    type: "POST",
                    url: 'Denunciados.aspx/delDenunciado',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'id': id, 'idDenuncia': idDenuncia, 'tipo': tipo, 'usuarioBaja': usuarioAlta }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        cargarDenunciasAntecedentes();
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });

            }
        </script>

        <div class="container">
            <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtFolio" />
            <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTipo" />
            <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtUsuario" />
                <div runat="server" class="row" id="divCerradas" style="margin-top:21px;">
                    <div class="table-header">
                        Busqueda de denuncias
                    </div>
                    <asp:GridView ID="gvDenunciados" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvDenunciados_RowDataBound" CssClass="strip table table-hover table-dashboard tableDenunciados">
                        <Columns>
                            <asp:HyperLinkField Text = "+"
                                    DataNavigateUrlFields="id"
                                    DataNavigateUrlFormatString="http://alfaaic/buzon/Cerrados_maint.asp?id={0}"  ControlStyle-CssClass ="btn-detail" target="_blank" />

                            <asp:HyperLinkField Text = "Agregar" ControlStyle-CssClass ="btn-detail add-Denunciado"/>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="row" style="margin-top:15px;"></div>

                <div class="row" style="margin-top:15px;"></div>

                <div runat="server" class="row" id="div1" style="margin-top:21px;">
                    <div class="table-header">
                        <% //row = tags.Select("id = '106'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>
                         Denuncias Antecedentes
                    </div>
                    <div id="collapseInv2" aria-labelledby="headingInv2" >
                        <div class="card-body">
                            <div id="tableAnte" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados" id="tblAntecedentes">
                                    <thead>
                                        <tr>
                                            <th class="text-left">Id <%--Nombre Completo--%></th>
                                            <th class="text-left">Título de la denuncia <%--Puesto--%></th>
                                            <th class="text-left">Grupo <%--Tipo--%></th>
                                            <th class="text-left">Involucrados <%--Fecha Ingreso--%></th>
                                            <th class="text-left">Madurez <%--Acciones--%></th>
                                            <%--<th class="text-left"></th>--%>
                                            <th class="text-left" style="width:85px;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
