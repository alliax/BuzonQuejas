<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Responsable.aspx.cs" Inherits="Portal_Investigadores.Responsable" %>


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

       <%-- <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />  
        <script src="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/js/bootstrap-multiselect.js" type="text/javascript"></script>  --%>
        <script src="scripts/jquery.multiselect.js"></script>
        <link href="scripts/jquery.multiselect.css" rel="stylesheet" />

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

            .multiCSS .btn-group {
                width: 100%;
            }
        </style>

        <script>
                        
            var idUsuario = '<%= Session["idUsuario"] %>';
            $(document).ready(function () {

                $('#contenido_txtDenunciasInvestigador').hide();
                $('#contenido_txtDenunciasRevisor').hide();

                cargarDelegados();
                cargarRevisados();
                cargarEnterados();

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

                $("#tableDelegados").on('click', '.table-remove', function () {

                    var r = confirm("¿Estas seguro que deseas eliminar el Delegado?");
                    if (r == true) {

                        var idDelegado;

                        $(this).parents('tr').each(function () {
                            idDelegado = $(this).find("td:first").html();
                        });

                        deleteDelegadoAsignado(idDelegado);

                        $(this).parents('tr').detach();
                    }
                });

                $("#tableRevisados").on('click', '.table-remove', function () {

                    var r = confirm("¿Estas seguro que deseas eliminar el Revisado?");
                    if (r == true) {

                        var idRevisado;

                        $(this).parents('tr').each(function () {
                            idRevisado = $(this).find("td:first").html();
                        });

                        deleteRevisadoAsignado(idRevisado);

                        $(this).parents('tr').detach();
                    }
                });

                $("#tableEnterados").on('click', '.table-remove', function () {

                    var r = confirm("¿Estas seguro que deseas eliminar el Enterado?");
                    if (r == true) {

                        var idEnterado;

                        $(this).parents('tr').each(function () {
                            idEnterado = $(this).find("td:first").html();
                        });

                        deleteEnteradoAsignado(idEnterado);

                        $(this).parents('tr').detach();
                    }
                });

                $('#contenido_ddlGrupo').change(function () {

                    if ($('#contenido_ddlGrupo').val() != "0") {
                        cargarEmpresas();
                        cargarDepartamentos();
                    } else {
                        $('#contenido_ddlEmpresa').empty();
                        $('#contenido_ddlDepartamentos').empty();
                    }

                        
                });

                $('#contenido_ddlEmpresa').change(function () {

                    if ($('#contenido_ddlEmpresa').val() != "0") {

                        var grupo = $('#contenido_ddlGrupo').val()

                        var empresa = $('#contenido_ddlEmpresa').val()

                        $.ajax({
                            type: "POST",
                            url: 'Responsable.aspx/CargarSitiosAdd',
                            // data: {'idDenuncia: ' + idDenuncia },
                            data: JSON.stringify({ 'grupo': grupo , 'empresa':empresa}),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var objdata = $.parseJSON(data.d);
                               
                                if (objdata.Sitios.length > 1) {
                                    $('#contenido_ddlSitio').empty();

                                    for (i = 0; i < objdata.Sitios.length - 1; i++) {

                                        var idSitio = objdata.Sitios[i]["0"];
                                        var Sitio = objdata.Sitios[i]["1"];

                                        $('#contenido_ddlSitio').append(`<option value="` + idSitio + `"> ` + Sitio + `</option>`);

                                    }
                                    $('#contenido_ddlSitio').val("0");

                                }
                            },
                            complete: function () {

                            },
                            error: function (e) {
                                console.log(e);
                            }
                        });

                    } else {
                        $('#contenido_ddlSitio').empty();

                    }
                });

                $('#contenido_ddlGrupo').change(function () {

                    if ($("#contenido_chbkAdmin").is(":checked")) {

                        var r = confirm("Si cambias el grupo la configuracion de admnistrador de denuncias será borrada, ¿Deseas continuar? ");

                        if (r == true) {

                            var idResponsable = $("#contenido_txtIdUsuario").val();

                            $.ajax({
                                type: "POST",
                                url: 'Responsable.aspx/DeleteAdminDen',
                                data: JSON.stringify({ 'idResponsable': idResponsable }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    console.log(data);

                                    $("#contenido_chbkAdmin").prop('checked', false);
                                    $("#contenido_divAdminDen").hide();
                                    saveUsuarioAutomatico();
                                    location.reload();

                                    //window.location.href = "Detalle.aspx?id=" + denuncia;
                                },
                                error: function (e) {
                                    console.log(e);
                                }

                            });

                            

                        }
                    } 

                    
                });


                if ($("#contenido_chbkInvestigador").is(":checked")) {
                    $("#contenido_divRelaciones").show();
                    $("#divSelDelegados").show();
                    $("#tableDelegados").show();
                }

                if ($("#contenido_chbkRevisor").is(":checked")) {
                    $("#contenido_divRelaciones").show();
                    $("#divSelRevisados").show();
                    $("#tableRevisados").show();

                }
                
                if ($("#contenido_chbkEnterado").is(":checked")) {
                    $("#contenido_divRelaciones").show();
                    $("#divSelEnterados").show();
                    $("#tableEnterados").show();
                }

                if ($("#contenido_chbkAdmin").is(":checked")) {
                    $("#contenido_divAdminDen").show();
                }

                $('#contenido_chbkInvestigador').change(function () {

                    if ($("#contenido_chbkInvestigador").is(":checked")) {
                        
                    } else {
                        
                        if ($('#tableDelegados table tbody tr td').length >= 1) {
                            alert("No se puede desactivar como Investigador ya que cuenta con delegados asignados");
                            $('#contenido_chbkInvestigador').prop('checked', true);

                        } else {
                            if ($('#contenido_txtDenunciasInvestigador').val() > 0) {
                                alert("No se puede desactivar como Investigador ya que cuenta con denuncias asignadas");
                                $('#contenido_chbkInvestigador').prop('checked', true);
                            } else {
                                $("#divSelDelegados").hide();
                                $("#tableDelegados").hide();
                            }
                        }



                    }
                });

                $('#contenido_chbkRevisor').change(function () {

                    if ($("#contenido_chbkRevisor").is(":checked")) {

                    } else {

                        if ($('#tableRevisados table tbody tr td').length >= 1) {
                            alert("No se puede desactivar como Revisor ya que cuenta con usuarios asignados");
                            $('#contenido_chbkRevisor').prop('checked', true);
                        } else {
                            if ($('#contenido_txtDenunciasRevisor').val() > 0) {
                                alert("No se puede desactivar como revisor ya que cuenta con denuncias asignadas como revisor");
                                $('#contenido_chbkRevisor').prop('checked', true);
                            } else {
                                $("#divSelRevisados").hide();
                                $("#tableRevisados").hide();
                            }
                        }
                    }
                });

                $('#contenido_chbkEnterado').change(function () {

                    if ($("#contenido_chbkEnterado").is(":checked")) {

                    } else {

                        if ($('#tableEnterados table tbody tr td').length >= 1) {
                            alert("No se puede desactivar como Enterado ya que cuenta con usuarios asignados");
                            $('#contenido_chbkEnterado').prop('checked', true);
                        } else {
                            $("#divSelEnterados").hide();
                            $("#tableEnterados").hide();
                        }
                    }
                });

                $('#contenido_chbkActivo').change(function () {

                    if ($("#contenido_chbkActivo").is(":checked")) {

                    } else {

                        if ($("#contenido_chbkInvestigador").is(":checked") || $("#contenido_chbkRevisor").is(":checked") || $("#contenido_chbkEnterado").is(":checked")) {
                            alert("No se puede desactivar el usuario, ya que cuenta con perfiles activos");
                            $('#contenido_chbkActivo').prop('checked', true);
                        }
                    }
                });

                $('#contenido_chbkAdmin').change(function () {

                    if ($("#contenido_chbkAdmin").is(":checked")) {

                        //$("#contenido_divAdminDen").show();
                        
                    } else {

                        var r = confirm("Si desactivas el campo de administrador de denuncias se eliminara la configuracion, ¿Deseas continuar? ");
                        if (r == true) {

                            var idResponsable = $("#contenido_txtIdUsuario").val();

                            $.ajax({
                                type: "POST",
                                url: 'Responsable.aspx/DeleteAdminDen',
                                data: JSON.stringify({ 'idResponsable': idResponsable }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    console.log(data);

                                    //window.location.href = "Detalle.aspx?id=" + denuncia;
                                },
                                error: function (e) {
                                    console.log(e);
                                }

                            });

                            $("#contenido_divAdminDen").hide();

                            saveUsuario();

                            console.log("se va a recargar");

                            //deseleccionar todo

                            //$('[id*=lBxEmpresa]').unselectAll();
                            //$('[id*=lBxSitio]').unselectAll();
                            //$('[id*=lBxArea]').unselectAll();
                            location.reload();


                        } else {
                            $("#contenido_chbkAdmin").prop('checked', true);

                        }

                        
                    }
                });

                $('[id*=lBxEmpresa]').multiselect({
                    onControlClose: function (element) {
                        
                        $(element).each(function (i) {

                            var empresas = $(this).val();

                            let str = '';

                            if (empresas != null && empresas.length > 0) {

                                for (let i = 0; i < empresas.length; i++) {

                                    if (i == 0) {
                                        str = str + empresas[i];
                                    } else {
                                        str = str + "," + empresas[i];
                                    }

                                    console.log(str);
                                }
                            }

                            console.log(str);

                            var usuarioAlta = idUsuario;

                            var idResponsable = $("#contenido_txtIdUsuario").val();

                            $.ajax({

                                type: "POST",
                                url: "Responsable.aspx/SaveAdminDen",
                                data: JSON.stringify({ 'empresas': str, 'idUsuario': idResponsable, 'usuarioAlta': usuarioAlta }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                beforeSend: function () {
                                    $('.ajax-loader').show();
                                },
                                success: function (r) {
                                    console.log(r);
                                    location.reload();
                                },
                                error: function (r) {
                                    console.log(r);   
                                },
                                complete: function () {
                                    $('.ajax-loader').css("visibility", "hidden");

                                },
                                failure: function (r) {
                                    console.log(r);  
                                }
                            });

                        });
                    },
                    selectAll: true
                });

                $('[id*=lBxSitio]').multiselect({
                    onControlClose: function (element) {

                        $(element).each(function (i) {

                            var sitios = $(this).val();

                            let str = '';

                            if (sitios != null && sitios.length > 0) {

                                for (let i = 0; i < sitios.length; i++) {

                                    if (i == 0) {
                                        str = str + sitios[i];
                                    } else {
                                        str = str + "," + sitios[i];
                                    }

                                    console.log(str);
                                }
                            }

                            console.log(str);

                            var usuarioAlta = idUsuario;

                            var idResponsable = $("#contenido_txtIdUsuario").val();

                            $.ajax({

                                type: "POST",
                                url: "Responsable.aspx/SaveSitiosAdminDen",
                                data: JSON.stringify({ 'sitios': str, 'idUsuario': idResponsable, 'usuarioAlta': usuarioAlta}),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                beforeSend: function () {
                                    $('.ajax-loader').show();
                                },
                                success: function (r) {
                                    console.log(r);
                                    
                                },
                                complete: function () {
                                    $('.ajax-loader').hide();

                                    $(".ajax-save").show();
                                    setTimeout(function () { $(".ajax-save").hide(); }, 500);
                                },
                                error: function (r) {
                                    $('.ajax-loader').hide();
                                    console.log(r);
                                },
                                failure: function (r) {
                                    $('.ajax-loader').hide();
                                    console.log(r);
                                }
                            });

                        });
                    },
                    selectAll: true
                });

                $('[id*=lBxArea]').multiselect({
                    onControlClose: function (element) {

                        $(element).each(function (i) {

                            var areas = $(this).val();

                            let str = '';

                            if (areas != null && areas.length > 0) {

                                for (let i = 0; i < areas.length; i++) {

                                    if (i == 0) {
                                        str = str + areas[i];
                                    } else {
                                        str = str + "," + areas[i];
                                    }

                                    console.log(str);
                                }
                            }

                            console.log(str);

                            var usuarioAlta = idUsuario;

                            var idResponsable = $("#contenido_txtIdUsuario").val();

                            $.ajax({

                                type: "POST",
                                url: "Responsable.aspx/saveAreasAdminDen",
                                data: JSON.stringify({ 'areas': str, 'idUsuario': idResponsable, 'usuarioAlta': usuarioAlta }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                beforeSend: function () {
                                    $('.ajax-loader').show();
                                },
                                success: function (r) {
                                    console.log(r);

                                },
                                complete: function () {
                                    $('.ajax-loader').hide();

                                    $(".ajax-save").show();
                                    setTimeout(function () { $(".ajax-save").hide(); }, 500);
                                },
                                error: function (r) {
                                    $('.ajax-loader').hide();
                                    console.log(r);
                                },
                                failure: function (r) {
                                    $('.ajax-loader').hide();
                                    console.log(r);
                                }
                            });

                        });
                    },
                    selectAll: true
                });

            });
            
            function addDelegado() {
                //alert("hola");

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var idDelegado = $("#contenido_ddlDelegados").val();

                if (idDelegado > 0) {

                    /*var denuncia = $('#contenido_txtFolio').val();*/
                    //var conclusion = $('#contenido_txtConclusion').val();
                    var usuarioAlta = idUsuario;

                    $.ajax({
                        type: "POST",
                        beforeSend: function () {
                            $('.ajax-loader').css("visibility", "visible");
                        },
                        url: 'Responsable.aspx/AgregarDelegado',
                        // data: {'idDenuncia: ' + idDenuncia },
                        data: JSON.stringify({ 'idResponsable': idResponsable, 'idDelegado': idDelegado, 'usuarioAlta': usuarioAlta }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //window.location.href = "Dashboard.aspx";
                            console.log(data);
                            cargarDelegados();
                        },
                        complete: function () {
                            $('.ajax-loader').css("visibility", "hidden");

                            $(".ajax-save").show();
                            setTimeout(function () { $(".ajax-save").hide(); }, 500);
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    });
                }

            }

            function addRevisado() {
                //alert("hola");

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var idRevisado = $("#contenido_ddlRevisados").val();

                if (idRevisado > 0) {

                    /*var denuncia = $('#contenido_txtFolio').val();*/
                    //var conclusion = $('#contenido_txtConclusion').val();
                    var usuarioAlta = idUsuario;

                    $.ajax({
                        type: "POST",
                        beforeSend: function () {
                            $('.ajax-loader').css("visibility", "visible");
                        },
                        url: 'Responsable.aspx/AgregarRevisado',
                        // data: {'idDenuncia: ' + idDenuncia },
                        data: JSON.stringify({ 'idResponsable': idResponsable, 'idRevisado': idRevisado, 'usuarioAlta': usuarioAlta }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //window.location.href = "Dashboard.aspx";
                            console.log(data);
                            cargarRevisados();
                        },
                        complete: function () {
                            $('.ajax-loader').css("visibility", "hidden");

                            $(".ajax-save").show();
                            setTimeout(function () { $(".ajax-save").hide(); }, 500);
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    });
                }

            }

            function addEnterado() {
                //alert("hola");

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var idEnterado = $("#contenido_ddlEnterados").val();

                if (idEnterado > 0) {

                    /*var denuncia = $('#contenido_txtFolio').val();*/
                    //var conclusion = $('#contenido_txtConclusion').val();
                    var usuarioAlta = idUsuario;

                    $.ajax({
                        type: "POST",
                        beforeSend: function () {
                            $('.ajax-loader').css("visibility", "visible");
                        },
                        url: 'Responsable.aspx/AgregarEnterado',
                        // data: {'idDenuncia: ' + idDenuncia },
                        data: JSON.stringify({ 'idResponsable': idResponsable, 'idEnterado': idEnterado, 'usuarioAlta': usuarioAlta }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //window.location.href = "Dashboard.aspx";
                            console.log(data);
                            cargarEnterados();
                        },
                        complete: function () {
                            $('.ajax-loader').css("visibility", "hidden");

                            $(".ajax-save").show();
                            setTimeout(function () { $(".ajax-save").hide(); }, 500);
                        },
                        error: function (e) {
                            console.log(e);
                        }
                    });
                }

            }

            function cargarDelegados() {

                var idResponsable = $("#contenido_txtIdUsuario").val();

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/CargarDelegadosAsignados',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idResponsable': idResponsable }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //$("#divResult").html("success");
                        var objdata = $.parseJSON(data.d);
                        //console.log(objdata);

                        if (objdata.Table1.length > 1) {
                            $('#tableDelegados table tbody').empty();

                            for (i = 0; i < objdata.Table1.length - 1; i++) {

                                var idDelegado = objdata.Table1[i]["0"];
                                var nombreDelegado = objdata.Table1[i]["1"];

                                const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">` + idDelegado + `</td>
                                        <td class="pt-3-half" contenteditable="false" >` + nombreDelegado + `</td>
                                        <td style="min-width: 84px;">
                                            <span>
                                                <button type="button" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove"> -</button>
                                            </span>
                                        </td>
                                    </tr>`;

                                var $tableID = "";

                                $tableID = $('#tableDelegados');

                                if ($tableID.find('tbody').length > 0) {
                                    $('#tableDelegados tbody').append(newTr);
                                }

                            }

                        } else {
                            //$('#tableInv2').hide();
                            $('#tableDelegados tbody').append('<td><p style="margin-top: 10px;font-size: 19px; margin-left:45px;"> No se han añadido Delegados</p></td><td></td>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });

            }

            function cargarRevisados() {

                var idResponsable = $("#contenido_txtIdUsuario").val();

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/CargarRevisadosAsignados',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idResponsable': idResponsable }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //$("#divResult").html("success");
                        var objdata = $.parseJSON(data.d);
                        //console.log(objdata);

                        if (objdata.Table1.length > 1) {
                            $('#tableRevisados table tbody').empty();

                            for (i = 0; i < objdata.Table1.length - 1; i++) {

                                var idRevisado = objdata.Table1[i]["0"];
                                var nombreRevisado = objdata.Table1[i]["1"];

                                const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">` + idRevisado + `</td>
                                        <td class="pt-3-half" contenteditable="false" >` + nombreRevisado + `</td>
                                        <td style="min-width: 84px;">
                                            <span>
                                                <button type="button" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove"> -</button>
                                            </span>
                                        </td>
                                    </tr>`;

                                var $tableID = "";

                                $tableID = $('#tableRevisados');

                                if ($tableID.find('tbody').length > 0) {
                                    $('#tableRevisados tbody').append(newTr);
                                }

                            }

                        } else {
                            //$('#tableInv2').hide();
                            $('#tableRevisados tbody').append('<td><p style="margin-top: 10px;font-size: 19px; margin-left:45px;"> No se han añadido Revisados</p></td><td></td>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });

            }

            function cargarEnterados() {

                var idResponsable = $("#contenido_txtIdUsuario").val();

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/CargarEnteradosAsignados',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idResponsable': idResponsable }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //$("#divResult").html("success");
                        var objdata = $.parseJSON(data.d);
                        //console.log(objdata);

                        if (objdata.Table1.length > 1) {
                            $('#tableEnterados table tbody').empty();

                            for (i = 0; i < objdata.Table1.length - 1; i++) {

                                var idEnterado = objdata.Table1[i]["0"];
                                var nombreEnterados = objdata.Table1[i]["1"];

                                const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">` + idEnterado + `</td>
                                        <td class="pt-3-half" contenteditable="false" >` + nombreEnterados + `</td>
                                        <td style="min-width: 84px;">
                                            <span>
                                                <button type="button" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove"> -</button>
                                            </span>
                                        </td>
                                    </tr>`;

                                var $tableID = "";

                                $tableID = $('#tableEnterados');

                                if ($tableID.find('tbody').length > 0) {
                                    $('#tableEnterados tbody').append(newTr);
                                }

                            }

                        } else {
                            //$('#tableInv2').hide();
                            $('#tableEnterados tbody').append('<td><p style="margin-top: 10px;font-size: 19px; margin-left:45px;"> No se han añadido Enterados</p></td><td></td>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });

            }

            function deleteDelegadoAsignado(idDelegado) {

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var usuarioBaja = idUsuario;

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/DeleteDelegado',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idResponsable': idResponsable, 'idDelegado': idDelegado, 'usuarioBaja': usuarioBaja }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //console.log(data);

                        //window.location.href = "Detalle.aspx?id=" + denuncia;
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }

            function deleteRevisadoAsignado(idRevisado) {

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var usuarioBaja = idUsuario;

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/DeleteRevisado',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idResponsable': idResponsable, 'idRevisado': idRevisado, 'usuarioBaja': usuarioBaja }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //console.log(data);

                        //window.location.href = "Detalle.aspx?id=" + denuncia;
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }

            function deleteEnteradoAsignado(idEnterado) {

                var usuarioBaja = idUsuario;
                var idResponsable = $("#contenido_txtIdUsuario").val();

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/DeleteEnterado',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idResponsable': idResponsable, 'idEnterado': idEnterado, 'usuarioBaja': usuarioBaja }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //console.log(data);

                        //window.location.href = "Detalle.aspx?id=" + denuncia;
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }

            function cargarEmpresas() {
                var grupo = $('#contenido_ddlGrupo').val()

                    $.ajax({
                        type: "POST",
                        url: 'Responsable.aspx/CargarEmpresasAdd',
                        // data: {'idDenuncia: ' + idDenuncia },
                        data: JSON.stringify({ 'grupo': grupo }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var objdata = $.parseJSON(data.d);
                            
                            if (objdata.Empresas.length > 1) {
                                $('#contenido_ddlEmpresa').empty();

                                for (i = 0; i < objdata.Empresas.length - 1; i++) {

                                    var idEmpresa = objdata.Empresas[i]["0"];
                                    var Empresa = objdata.Empresas[i]["1"];

                                    $('#contenido_ddlEmpresa').append(`<option value="` + idEmpresa + `"> ` + Empresa + `</option>`);

                                }
                                $('#contenido_ddlEmpresa').val("0");

                            }
                        },
                        complete: function () {

                        },
                        error: function (e) {
                            console.log(e);
                        }
                    });

                

            }
            
            function cargarDepartamentos() {
                var grupo = $('#contenido_ddlGrupo').val()

                $.ajax({
                    type: "POST",
                    url: 'Responsable.aspx/CargarDepartamentosAdd',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'grupo': grupo }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var objdata = $.parseJSON(data.d);
                        
                        if (objdata.Departamentos.length > 1) {
                            $('#contenido_ddlDepartamento').empty();

                            for (i = 0; i < objdata.Departamentos.length - 1; i++) {

                                var idEmpresa = objdata.Departamentos[i]["0"];
                                var Empresa = objdata.Departamentos[i]["1"];

                                $('#contenido_ddlDepartamento').append(`<option value="` + idEmpresa + `"> ` + Empresa + `</option>`);

                            }
                            $('#contenido_ddlDepartamento').val("0");

                        }
                    },
                    complete: function () {

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });



            }

            function saveUsuario() {

                var idUsuarioSave = $('#contenido_txtIdUsuario').val();
                var usuario = $('#contenido_txtUsuario').val();
                var nombre = $('#contenido_txtNombre').val();
                //var subtema = $('#contenido_mTxtSubTema').val();
                var correo = $('#contenido_txtCorreo').val();
                var grupo = $('#contenido_ddlGrupo').val();
                var empresa = $('#contenido_ddlEmpresa').val();
                var sitio = $('#contenido_ddlSitio').val();
                var departamento = $('#contenido_ddlDepartamento').val();
                var investigador = 0;
                var delegado = 0;
                var revisor = 0;
                var enterado = 0;
                var adminDen = 0;
                var activo = 0;

                if ($("#contenido_chbkInvestigador").is(":checked")) {
                    investigador = 1;
                }
                else if ($("#contenido_chbkInvestigador").is(":not(:checked)")) {
                    investigador = 0;
                }

                if ($("#contenido_chbkDelegado").is(":checked")) {
                    delegado = 1;
                }
                else if ($("#contenido_chbkDelegado").is(":not(:checked)")) {
                    delegado = 0;
                }

                if ($("#contenido_chbkRevisor").is(":checked")) {
                    revisor = 1;
                }
                else if ($("#contenido_chbkRevisor").is(":not(:checked)")) {
                    revisor = 0;
                }

                if ($("#contenido_chbkEnterado").is(":checked")) {
                    enterado = 1;
                }
                else if ($("#contenido_chbkEnterado").is(":not(:checked)")) {
                    enterado = 0;
                }

                if ($("#contenido_chbkAdmin").is(":checked")) {
                    adminDen = 1;
                }
                else if ($("#contenido_chbkAdmin").is(":not(:checked)")) {
                    adminDen = 0;
                }

                if ($("#contenido_chbkActivo").is(":checked")) {
                    activo = 1;
                }
                else if ($("#contenido_chbkActivo").is(":not(:checked)")) {
                    activo = 0;
                }
                var usuarioAlta = idUsuario;

                if (usuario == "" || nombre == "" || correo == "" || grupo == "0" || empresa == "0" ) {
                    alert("Faltan campos obligatorios por llenar");
                } else {

                    console.log(adminDen);

                    $.ajax({
                        type: "POST",
                        beforeSend: function () {
                            $('.ajax-loader').show();
                        },
                        url: 'Responsable.aspx/saveUsuario',
                        // data: {'idDenuncia: ' + idDenuncia },
                        data: JSON.stringify({ 'idUsuario': idUsuarioSave, 'usuario': usuario, 'nombre': nombre, 'correo': correo, 'grupo': grupo, 'empresa': empresa, 'sitio': sitio, 'departamento': departamento, 'investigador': investigador, 'delegado': delegado, 'revisor': revisor, 'enterado': enterado, 'activo': activo, 'usuarioAlta': usuarioAlta, 'adminDen': adminDen }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //$("#divResult").html("success");
                            var objdata = $.parseJSON(data.d);
                            console.log(objdata);

                            //if (idUsuarioSave = 0) {
                            $('#contenido_txtIdUsuario').val(objdata);
                            //}

                            //if (investigador == "1" || revisor == "1" || enterado == "1") {
                            //    $("#contenido_divRelaciones").show();
                            //    alert("ddddd");
                            //}

                            var suma = 0;

                            if ($("#contenido_chbkInvestigador").is(":checked")) {
                                $("#contenido_divRelaciones").show();
                                $("#divSelDelegados").show();
                                $("#tableDelegados").show();
                            } else {
                                $("#divSelDelegados").hide();
                                $("#tableDelegados").hide();
                                suma = suma + 1;
                            }

                            if ($("#contenido_chbkRevisor").is(":checked")) {
                                $("#contenido_divRelaciones").show();
                                $("#divSelRevisados").show();
                                $("#tableRevisados").show();
                            } else {
                                $("#divSelRevisados").hide();
                                $("#tableRevisados").hide();
                                suma = suma + 1;
                            }

                            if ($("#contenido_chbkEnterado").is(":checked")) {
                                $("#contenido_divRelaciones").show();
                                $("#divSelEnterados").show();
                                $("#tableEnterados").show();
                            }
                            else {
                                $("#divSelEnterados").hide();
                                $("#tableEnterados").hide();
                                suma = suma + 1;
                            }

                            if (suma == 3) {
                                $("#contenido_divRelaciones").hide();
                            }

                            if ($("#contenido_chbkAdmin").is(":checked")) {

                                var grupo2 = $("#contenido_ddlGrupo2").val();

                                if (grupo2 == "0") {

                                    window.location.href += "?id=" + objdata;
                                }
                                else {
                                    $("#contenido_divAdminDen").show();
                                }
                             
                            }

                        },
                        complete: function () {
                            $('.ajax-loader').hide();

                            $(".ajax-save").show();
                            setTimeout(function () { $(".ajax-save").hide(); }, 500);
                        },
                        error: function (e) {
                            $('.ajax-loader').hide();
                            console.log(e);
                        }
                    });
                }
            }

            function saveUsuarioAutomatico() {

                var idUsuarioSave = $('#contenido_txtIdUsuario').val();
                var usuario = $('#contenido_txtUsuario').val();
                var nombre = $('#contenido_txtNombre').val();
                //var subtema = $('#contenido_mTxtSubTema').val();
                var correo = $('#contenido_txtCorreo').val();
                var grupo = $('#contenido_ddlGrupo').val();
                var empresa = $('#contenido_ddlEmpresa').val();
                var sitio = $('#contenido_ddlSitio').val();
                var departamento = $('#contenido_ddlDepartamento').val();
                var investigador = 0;
                var delegado = 0;
                var revisor = 0;
                var enterado = 0;
                var adminDen = 0;
                var activo = 0;

                if ($("#contenido_chbkInvestigador").is(":checked")) {
                    investigador = 1;
                }
                else if ($("#contenido_chbkInvestigador").is(":not(:checked)")) {
                    investigador = 0;
                }

                if ($("#contenido_chbkDelegado").is(":checked")) {
                    delegado = 1;
                }
                else if ($("#contenido_chbkDelegado").is(":not(:checked)")) {
                    delegado = 0;
                }

                if ($("#contenido_chbkRevisor").is(":checked")) {
                    revisor = 1;
                }
                else if ($("#contenido_chbkRevisor").is(":not(:checked)")) {
                    revisor = 0;
                }

                if ($("#contenido_chbkEnterado").is(":checked")) {
                    enterado = 1;
                }
                else if ($("#contenido_chbkEnterado").is(":not(:checked)")) {
                    enterado = 0;
                }

                if ($("#contenido_chbkAdmin").is(":checked")) {
                    adminDen = 1;
                }
                else if ($("#contenido_chbkAdmin").is(":not(:checked)")) {
                    adminDen = 0;
                }

                if ($("#contenido_chbkActivo").is(":checked")) {
                    activo = 1;
                }
                else if ($("#contenido_chbkActivo").is(":not(:checked)")) {
                    activo = 0;
                }
                var usuarioAlta = idUsuario;

                console.log(adminDen);

                $.ajax({
                    type: "POST",
                    beforeSend: function () {
                        $('.ajax-loader').show();
                    },
                    url: 'Responsable.aspx/saveUsuario',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idUsuario': idUsuarioSave, 'usuario': usuario, 'nombre': nombre, 'correo': correo, 'grupo': grupo, 'empresa': empresa, 'sitio': sitio, 'departamento': departamento, 'investigador': investigador, 'delegado': delegado, 'revisor': revisor, 'enterado': enterado, 'activo': activo, 'usuarioAlta': usuarioAlta, 'adminDen': adminDen }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //$("#divResult").html("success");
                        var objdata = $.parseJSON(data.d);
                        console.log(objdata);

                        //if (idUsuarioSave = 0) {
                        $('#contenido_txtIdUsuario').val(objdata);
                        //}

                        var suma = 0;

                        if ($("#contenido_chbkInvestigador").is(":checked")) {
                            $("#contenido_divRelaciones").show();
                            $("#divSelDelegados").show();
                            $("#tableDelegados").show();
                        } else {
                            $("#divSelDelegados").hide();
                            $("#tableDelegados").hide();
                            suma = suma + 1;
                        }

                        if ($("#contenido_chbkRevisor").is(":checked")) {
                            $("#contenido_divRelaciones").show();
                            $("#divSelRevisados").show();
                            $("#tableRevisados").show();
                        } else {
                            $("#divSelRevisados").hide();
                            $("#tableRevisados").hide();
                            suma = suma + 1;
                        }

                        if ($("#contenido_chbkEnterado").is(":checked")) {
                            $("#contenido_divRelaciones").show();
                            $("#divSelEnterados").show();
                            $("#tableEnterados").show();
                        }
                        else {
                            $("#divSelEnterados").hide();
                            $("#tableEnterados").hide();
                            suma = suma + 1;
                        }

                        if (suma == 3) {
                            $("#contenido_divRelaciones").hide();
                        }

                    },
                    complete: function () {
                        $('.ajax-loader').hide();

                        $(".ajax-save").show();
                        setTimeout(function () { $(".ajax-save").hide(); }, 500);
                    },
                    error: function (e) {
                        $('.ajax-loader').hide();
                        console.log(e);
                    }
                });
                
            }
        </script>
        
        
        <div class="container" style="max-width:80% !important;">
            <div class="ajax-loader" style="display:none;">
                <div class="ajax-loader-cont">
                    <img src="img/ajax-loader.gif"  class="img-responsive" />
                    <p>Procesando</p>
                </div>
            </div>
            <div class="ajax-save" style="display:none;">
                <div class="ajax-save-cont">
                    <img src="img/214353.png"  class="img-responsive" />
                    <p>Guardado con Exito</p>
                </div>
            </div>

            <%--Indicadores Principales--%>
            <div class="row" style="margin-top:15px;">
                
            </div>

            <div runat="server" class="row" id="divResponsables" style="margin-top:21px;">
                <div class="table-header">
                    Usuario <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                <form>
                    
                    <div class="form-group col-md-12">
                        <label for="inputUsuario">Usuario</label>
                        <asp:TextBox runat="server"  CssClass="form-control" ID="txtIdUsuario" style="display:none;"/>
                        <asp:TextBox runat="server"  CssClass="form-control" ID="txtUsuario" />
                    </div>
                        
                    <div class="form-group col-md-12">
                        <label for="inputFolio">Nombre*</label>
                        <asp:TextBox runat="server"  CssClass="form-control" ID="txtNombre" />
                    </div>
                 
                    <div class="form-group col-md-12">
                        <label for="inputGrupo">Correo*</label>
                        <asp:TextBox runat="server"  CssClass="form-control" ID="txtCorreo" />
                    </div>
                  
                    <div class="form-group col-md-6">
                        <label for="inputEmpresa">Grupo*</label>
                        <asp:DropDownList ID="ddlGrupo" runat="server" CssClass="form-control" AutoPostBack="false" >
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                
                    <div class="form-group col-md-6">
                        <label for="inputSitio">Empresa*</label>
                        <asp:DropDownList ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>
                       
                    <div class="form-group col-md-6">
                        <label for="inputDepartamento">Sitio</label>
                        <asp:DropDownList ID="ddlSitio" runat="server" CssClass="form-control" AutoPostBack="false">
                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="inputTema">Departamento</label>
                        <asp:DropDownList ID="ddlDepartamento" runat="server" CssClass="form-control" AutoPostBack="false">
                        </asp:DropDownList>
                    </div>

                    <div class="form-group col-md-2">
                        <label for="inputResumen">Es Delegado</label>
                        <asp:CheckBox runat="server" ID="chbkDelegado" CssClass="form-control"/>
                    </div>
  
                    <div class="form-group col-md-2">
                        <label for="inputTitulo">Es Investigador</label>
                        <asp:CheckBox runat="server" ID="chbkInvestigador" CssClass="form-control"/>
                        <asp:TextBox runat="server" ID="txtDenunciasInvestigador" CssClass="form-control" />
                    </div>

                    <div class="form-group col-md-2">
                        <label for="inputResumen">Es Revisor</label>
                        <asp:CheckBox runat="server" ID="chbkRevisor" CssClass="form-control"/>
                        <asp:TextBox runat="server" ID="txtDenunciasRevisor" CssClass="form-control" />
                    </div>

                    <div class="form-group col-md-2">
                        <label for="inputResumen">Es Enterado</label>
                        <asp:CheckBox runat="server" ID="chbkEnterado" CssClass="form-control"/>
                    </div>

                     <div class="form-group col-md-2">
                        <label for="inputResumen">Administrador de Denuncias</label>
                        <asp:CheckBox runat="server" ID="chbkAdmin" CssClass="form-control"/>
                    </div>

                    <div class="form-group col-md-2">
                        <label for="inputResumen">Activo</label>
                        <asp:CheckBox runat="server" ID="chbkActivo" CssClass="form-control"/>
                    </div>

                    <div class="form-row" style="width: 100%;">
                        <div class="form-group col-md-4">
                            <asp:LinkButton runat="server" ID="test" Text="Gestion de Buzon de Quejas" CssClass="btn btn-primary" OnClick="test_Click"/>
                        </div>
                        <div class="form-group col-md-4">
                            <button type="button" class="btn btn-secondary" onclick="location.href='CatalogoResponsables.aspx';" >Regresar</button>
                        </div>
                        <div class="form-group col-md-4">
                            <button id="gdaUsuario" type="button" class="btn btn-primary"  onclick="return saveUsuario()">Guardar</button>
                        </div>
                    </div>
                </form>
               
                                
            </div>

            <div runat="server" class="row" id="divRelaciones" style="margin-top:21px;display:none;">
                <div class="table-header">
                    Relaciones <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>
                
                    <div class="form-group col-md-4" id="divSelDelegados" style="display:none;">
                        <label for="inputSitio">Selecciona Delegados</label>
                        <asp:DropDownList ID="ddlDelegados" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>

                        <button id="agregarDelegado" type="button" style="margin-top: 10px;" class="btn btn-primary" onclick="return addDelegado();">Agregar</button>  

                        <div id="tableDelegados" style="display:none;     margin-top: 20px;" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte">  <%--style="width: 50%; margin-left: 24%;"--%>
                                    <thead>
                                        <tr>
                                            <th class="text-left">Delegados</th>
                                            <th class="text-left" style="width:85px;">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                    </div>

                    <div class="form-group col-md-4" id="divSelRevisados" style="display:none;">
                        <label for="inputSitio">Selecciona a quien Revisa</label>
                        <asp:DropDownList ID="ddlRevisados" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                         <button id="agregarRevisa" type="button" style="margin-top: 10px;" class="btn btn-primary" onclick="return addRevisado();">Agregar</button>  

                        <div id="tableRevisados" style="display:none;     margin-top: 20px;" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte">  <%--style="width: 50%; margin-left: 24%;"--%>
                                    <thead>
                                        <tr>
                                            <th class="text-left">Revisor de</th>
                                            <th class="text-left" style="width:85px;">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                    </div>

                    <div class="form-group col-md-4" id="divSelEnterados" style="display:none;">
                        <label for="inputSitio">Selecciona de quien es Enterado</label>
                        <asp:DropDownList ID="ddlEnterados" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>
                        <button id="agregarEnterado" type="button" style="margin-top: 10px;" class="btn btn-primary" onclick="return addEnterado();">Agregar</button>  

                        <div id="tableEnterados" style="display:none; margin-top: 20px;" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte">  <%--style="width: 50%; margin-left: 24%;"--%>
                                    <thead>
                                        <tr>
                                            <th class="text-left">Enterado de</th>
                                            <th class="text-left" style="width:85px;">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                    </div>

                    <%--<div class="form-group col-md-4">
                        <div id="tableDelegados" style="display:none;" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte"> 
                                    <thead>
                                        <tr>
                                            <th class="text-left">Delegados</th>
                                            <th class="text-left" style="width:85px;">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                    </div>--%>

                   <%-- <div class="form-group col-md-4">
                        
                    </div>

                    <div class="form-group col-md-4">
                        
                    </div>--%>
                <%--</div>--%>
           
            </div>

            <div runat="server" class="row" id="divAdminDen" style="margin-top:21px;margin-bottom: 40px; display:none;"><%--display:none;--%>
                <div class="table-header">
                    Administrador Denuncias <%--<% row = tags.Select("id = '2'");   if (row.Length > 0){Response.Write(row[0][1]);}  %>--%>
                </div>

                <div class="form-group col-md-12">
                    <label for="inputSitio">Selecciona que denuncias cerradas puede observar el usuario</label>
                </div>

                <div class="form-group col-md-6">
                    <label for="inputEmpresa">Grupo*</label>
                    <asp:DropDownList ID="ddlGrupo2" runat="server" CssClass="form-control" AutoPostBack="false" Enabled="false">
                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                    </asp:DropDownList>
                </div>

                <div class="form-group col-md-12" style="margin: 0;">
                </div>
                
                <div class="form-group col-md-6 multiCSS">
                    <label for="lBxEmpresa" style="display: block;">Empresa</label>
                    <asp:ListBox ID="lBxEmpresa" runat="server" CssClass="form-control" SelectionMode="Multiple">  
                    </asp:ListBox>
                </div>
                       
                <div class="form-group col-md-6 multiCSS">
                    <label for="lBxSitio" style="display: block;">Sitio</label>
                    <asp:ListBox ID="lBxSitio" runat="server" CssClass="form-control" SelectionMode="Multiple">  
                    </asp:ListBox>
                </div>

                <div class="form-group col-md-6 multiCSS">
                    <label for="lBxArea" style="display: block;">Area</label>
                    <asp:ListBox ID="lBxArea" runat="server" CssClass="form-control" SelectionMode="Multiple">  
                    </asp:ListBox>
                </div>
                    
                    <%--<asp:ListBox ID="lstFruits" runat="server" SelectionMode="Multiple" AutoPostBack="true">
                        <asp:ListItem Text="Mango" Value="1" />
                        <asp:ListItem Text="Apple" Value="2" />
                        <asp:ListItem Text="Banana" Value="3" />
                        <asp:ListItem Text="Guava" Value="4" />
                        <asp:ListItem Text="Orange" Value="5" />
                    </asp:ListBox>

                    <asp:ListBox ID="lstEmployee" runat="server" SelectionMode="Multiple">  
                        <asp:ListItem Text="Nikunj Satasiya" Value="1" />  
                        <asp:ListItem Text="Dev Karathiya" Value="2" />  
                        <asp:ListItem Text="Hiren Dobariya" Value="3" />  
                        <asp:ListItem Text="Vivek Ghadiya" Value="4" />  
                        <asp:ListItem Text="Pratik Pansuriya" Value="5" />  
                    </asp:ListBox>  --%>
                   <%-- <div class="form-group col-md-12">
                        <label for="inputSitio">O</label>
                    </div>

                     <div class="form-group col-md-6">
                        <label for="inputResumen">Denuncias de él y su equipo</label>
                        <asp:CheckBox runat="server" ID="CheckBox1" CssClass="form-control"/>
                    </div>--%>
                
                <div class="form-group col-md-12" style="margin: 0;">
                </div>

               <%-- <div class="form-group col-md-4 ml-auto">
                    <button id="gdaConfAdmin" type="button" class="btn btn-primary"  onclick="return saveConfAdmin()">Guardar</button>
                </div>--%>
                          
            </div>
         
         </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
