
function cargarModal(row) {

    var rowData = row.parentNode.parentNode;
    //var rowIndex = rowData.rowIndex;
    //console.log(rowData);

    var idDenuncia = rowData.cells[0].firstChild.data;
   

    //$.ajax({
    //    type: "POST",
    //    url: 'Dashboard.aspx/CargarModal',
    //    // data: {'idDenuncia: ' + idDenuncia },
    //    data: JSON.stringify({ 'idDenuncia' : idDenuncia }),
    //    contentType: "application/json; charset=utf-8",
    //    dataType: "json",
    //    success: function (data) {
    //        //$("#divResult").html("success");
    //        var objdata = $.parseJSON(data.d);
    //        //console.log(objdata);

    //        $('#contenido_txtFolio').val(objdata.Denuncias["0"]["0"]); 
    //        $('#contenido_txtGrupo').val(objdata.Denuncias["0"]["1"]); 
    //        $('#contenido_txtEmpresa').val(objdata.Denuncias["0"]["2"]); 
    //        $('#contenido_txtSitio').val(objdata.Denuncias["0"]["3"]); 
    //        $('#contenido_txtDepartamento').val(objdata.Denuncias["0"]["4"]); 
    //        $('#contenido_txtTema').val(objdata.Denuncias["0"]["5"]); 
    //        $('#contenido_txtTitulo').val(objdata.Denuncias["0"]["6"]); 
    //        $('#contenido_txtResumen').val(objdata.Denuncias["0"]["7"]); 

    //        $.ajax({
    //            type: "POST",
    //            url: 'Dashboard.aspx/CargarDelegados',
    //            // data: {'idDenuncia: ' + idDenuncia },
    //            data: JSON.stringify({ 'idDenuncia': idDenuncia }),
    //            contentType: "application/json; charset=utf-8",
    //            dataType: "json",
    //            success: function (data) {
    //                //$("#divResult").html("success");
    //                var objdata = $.parseJSON(data.d);
    //                console.log(objdata);
    //                $("#btnDropDel").empty();

    //                for (i = 0; i < objdata.Table1.length-1; i++) {
    //                    //console.log(objdata.Table1[i][0]);
    //                    //console.log(objdata.Table1[i][1]);
    //                    $("#btnDropDel").append('<button onclick="return DelegarDenuncia(this)" id="' + objdata.Table1[i][0] + '" class="dropdown-item">' + objdata.Table1[i][1] + '</button>');
    //                    //$("#btnDropDel").append('<asp:Button runat="server" autopostback="true" class ="dropdown-item" onclick="DelegarDenuncia" autopostback="true" id="' + objdata.Table1[i][0] + '" text="' + objdata.Table1[i][1] + '" />');
                        
    //                }

    //            },
    //            error: function (e) {
    //                console.log(e);
    //            }
    //        });
                     
    //    },
    //    error: function (e) {
    //        console.log(e);
    //    }
    //});
}

function DelegarDenuncia() {

    var denuncia = $('#contenido_txtFolio').val();
    var delegado = $('#contenido_delegadoDDL').val();
    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'Detalle.aspx/DelegarDenuncia',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'delegado': delegado, 'usuarioAlta': usuarioAlta}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //console.log(data);
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

function AceptarDenuncia() {

    var denuncia = $('#contenido_txtFolio').val();
  
    $.ajax({
        type: "POST",
        url: 'Dashboard.aspx/AceptarDenuncia',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //console.log(data);
            //alert("hola");
            //location.reload();

            window.location.href = "Detalle.aspx?id=" + denuncia;            
        },
        error: function (e) {
            console.log(e);
        }
    });
}

function EsconderDenuncia() {
    $(".principal").hide("slow");
    $(".rechazo").show("slow");
}

function MostrarDenuncia() {
    $(".principal").show("slow");
    $(".rechazo").hide("slow");
}

function RechazarDenuncia() {

    var denuncia = $('#contenido_txtFolio').val();

    var comentario = $('#contenido_txtComentarioRechazo').val();

    $.ajax({
        type: "POST",
        url: 'Dashboard.aspx/RechazarDenuncia',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'comentario': comentario }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //console.log(data);
            //alert("hola");
            location.reload();
            //window.location.href = "v_detalle.aspx?id=" + denuncia;
        },
        error: function (e) {
            console.log(e);
        }
    });
}

$(document).ready(function () {

    $("#contenido_txtComentarioRechazo").on('keyup blur', function () {
        $('#confirmarRechazo').prop('disabled', this.value == "" ? true : false);
    });

    $("#contenido_txtComentarioRechazoInv").on('keyup blur', function () {
        $('#confirmarRechazoInv').prop('disabled', this.value == "" ? true : false);
    });

    //$("#contenido_ddlMadurez").on('keyup blur', function () {
    //    $('#contenido_ddlMadurez').prop('disabled', this.value == "" ? true : false);
    //});

    $("#contenido_txtComentario").on('keyup', function (e) {
        if (e.keyCode === 13) {
            saveComentario();
        }
    });

    //$("#modalDetail").on("hide.bs.modal", function () {

    //    alert("close Modal");
    //    // put your default event here
    //});

    //$('#modalDetail').on('hidden.bs.modal', function () {
    //    window.alert('hidden event fired!');
    //});
    

    //var height = $(window).height();

    //$('.ajax-save').height(height);    //$('.ajax-save').height(height);


    //$('#contenido_gvInvolucrados').DataTable();

    //cargarInvolucradosDenuncia();
    //cargarDenunciasAsociadas();
    //cargarInvolucradosInvestigacion();
    //cargarEntrevistados();
    //cargarTemas();

    //addInvolucrados();
    //addEntrevistados();
    //addTemas();

    //$(".ajax-save").hide();


    //$(".btn-collapse").click(function () {
    //    var textarea = $('#contenido_txtDisplayComentario');
    //    textarea.scrollTop(textarea[0].scrollHeight);
    //    console.log(textarea[0].scrollHeight);
    //});  

    //$("#fileUpload").on("change", function () {
    //    var files = $(this).get(0).files;
    //    var formData = new FormData();
    //    for (var i = 0; i < files.length; i++) {
    //        formData.append(files[i].name, files[i]);
    //    }

    //    uploadFiles(formData);
    //});


    
   
});

function cargarInvolucradosDenuncia() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarInvolucradosDenuncia',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia, 'idioma': idioma  }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            
            var objdata = $.parseJSON(data.d);

            s = $('#accordionInv h2 button ').text().split('(')[0];

            $('#accordionInv h2 button ').empty();

            $('#accordionInv h2 button ').append(s + " (" + (objdata.Table1.length - 1) + ") ");
           
            if (objdata.Table1.length > 1) {

                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var nombre = objdata.Table1[i]["0"];
                    var tipo = objdata.Table1[i]["1"];
                    var puesto = objdata.Table1[i]["2"];

                    const $tableID = $('#tableInv');

                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="false">`+ nombre + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ tipo + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ puesto + `</td>
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableInv tbody').append(newTr);
                    }
                }
            } else {
                $('#tableInv').hide();
                $('#collapseInv .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 86; })[0].tag  +'</p>'); 
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarInvolucradosInvestigacion() {

    var idDenuncia = $('#contenido_txtFolio').val();
    var editable;

    var readOnlyActivado = validarReadOnly();

    if (readOnlyActivado == 1) {
        //var readOnly = "false";
        var editable = "false";
    } else {
        //var readOnly = "true";
        var editable = "true";
    }

    //if (estatusDenuncia == 2) {
    //    var readOnly = "false";
    //    var editable = "false";
    //} else {
    //    var readOnly = "true";
    //    var editable = "true";
    //}
    
    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarInvolucradosInvestigacion',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            $('#collapseInv2 .tblinvolucrados tbody ').empty();

            var objdata = $.parseJSON(data.d);

            //console.log(objdata);

            s = $('#accordionInv2 h2 button ').text().split('(')[0];

            $('#accordionInv2 h2 button ').empty();

            $('#accordionInv2 h2 button ').append(s+" (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {

                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var idInvolucrado = objdata.Table1[i]["0"];
                    var nombre = objdata.Table1[i]["1"];
                    var tipo = objdata.Table1[i]["2"];
                    var puesto = objdata.Table1[i]["3"];
                    var fechaIngreso = objdata.Table1[i]["4"];
                    var idAccion = objdata.Table1[i]["5"];
                    var fechaCompromiso = objdata.Table1[i]["6"];
                    var Soporte = objdata.Table1[i]["7"];
                    var heredado = objdata.Table1[i]["8"];

                    if (fechaIngreso === null )
                        fechaIngreso = "";

                    if (fechaCompromiso === null)
                        fechaCompromiso = "";

                    const $tableID = $('#tableInv2');

                    //<td class="pt-3-half" contenteditable="true">`+ fechaIngreso + `</td>
                    //<td class="pt-3-half" contenteditable="`+ readOnly + `"><button onclick="event.preventDefault(); popUp('UploadFile.aspx', 1);">subirarchivo</button></td>
                    //<button contenteditable="`+ readOnly + `" onclick="event.preventDefault(); popUp('UploadFile.aspx', 1,` + idInvolucrado +`); ">subirarchivo</button>
                    const newTr = `<tr `+(heredado == "1" ? `style= "background-color: rgba(202, 227, 235 );"` : ``)+` >
                                    <td class="pt-3-half" contenteditable="false" style="display:none;">` + idInvolucrado + `</td>
                                    <td class="pt-3-half" contenteditable="` + editable + `">` + nombre + `</td>
                                    <td class="pt-3-half" contenteditable="` + editable + `">` + puesto + `</td>
                                    <td class="pt-3-half" contenteditable="` + editable + `"><select id = "tipo` + i + `" ` + (editable == "false" ? `disabled` : ``) + `></select></td>
                                    <td class="pt-3-half" contenteditable="false"><input type="text" contenteditable="`+ editable + `" style="width: 87px;" class="fechaIngreso" value="` + fechaIngreso + `" ` + (editable == "false" ? (`readOnly`) : (``)) + `></td>
                                    <td class="pt-3-half" contenteditable="` + editable + `"><select id = "accion` + i + `" ` + (editable == "false" ? `disabled` : ``) + `></select></td>`
                        + `         <td class="pt-3-half" contenteditable="false"><input type="text" style="width: 87px;" class="fechaCompromiso" value="` + fechaCompromiso + `" ` + (editable == "false" ? ("readOnly") : ("")) + `></td>`
                        + `         <td style="min-width: 94px;">`
                        + (editable == "true" ? (`<button title="Añadir un nuevo Soporte/Add attachment" contenteditable="` + editable + `" style="width:30px; margin-right: -5px;"class="btn btn-info btn-rounded btn-sm my-0" onclick="event.preventDefault(); popUp('UploadFile.aspx', 1,` + idInvolucrado + `); ">+</button>`) : (""))
                        + (Soporte > 0 ? `<button title="Ver Soportes/View attachments" contenteditable="` + editable + `" style="width:40px;" class="btn btn-secondary btn-rounded btn-sm my-0 openModal" data-toggle="modal" data-target=".bd-example-modal-xl" onclick="event.preventDefault(); cargarModalSoporte(1,` + idInvolucrado + `); ">ver</button>` : "") + `</td>`
                        + `<td style="min-width: 84px;"> <span><button type="button" title="Guardar/Save" contenteditable="` + editable + `" style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save"  ` + (editable == "false" ? `disabled` : ``) + `><img src="img/save-2.png" style="margin-left: -4px;"/></button> <button type = "button" title = "Eliminar/Delete" contenteditable = "` + editable + `" style = "width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove" ` + (editable == "false" || heredado == "1" ? `disabled` : ``) + ` > -</button ></span> </td > </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableInv2 tbody').append(newTr);
                    }

                    cargarAcciones((i), idAccion);

                    cargarTipos((i), tipo);

                    if (editable == "true") {
                        $(".fechaIngreso").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true });
                        $(".fechaCompromiso").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true });
                    }
               
                }
            } else {
                //$('#tableInv2').hide();
                //$('#collapseInv2 .card-body').append('<p> No se han dado de alta involucrados</p>');
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarInvolucradosInvestigacionLite() {

    var idDenuncia = $('#contenido_txtFolio').val();
    var editable;

    var readOnlyActivado = validarReadOnly();

    if (readOnlyActivado == 1) {
        //var readOnly = "false";
        var editable = "false";
    } else {
        //var readOnly = "true";
        var editable = "true";
    }

    //if (estatusDenuncia == 2) {
    //    var readOnly = "false";
    //    var editable = "false";
    //} else {
    //    var readOnly = "true";
    //    var editable = "true";
    //}

    $.ajax({
        type: "POST",
        url: 'DetalleLite.aspx/CargarInvolucradosInvestigacionLite',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            $('#collapseInv2 .tblinvolucrados tbody ').empty();

            var objdata = $.parseJSON(data.d);

            //console.log(objdata);

            s = $('#accordionInv2 h2 button ').text().split('(')[0];

            $('#accordionInv2 h2 button ').empty();

            $('#accordionInv2 h2 button ').append(s + " (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {

                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var idInvolucrado = objdata.Table1[i]["0"];
                    var nombre = objdata.Table1[i]["1"];
                    var accion = objdata.Table1[i]["2"];
                   

                    const $tableID = $('#tableInv2');

                    //<td class="pt-3-half" contenteditable="true">`+ fechaIngreso + `</td>
                    //<td class="pt-3-half" contenteditable="`+ readOnly + `"><button onclick="event.preventDefault(); popUp('UploadFile.aspx', 1);">subirarchivo</button></td>
                    //<button contenteditable="`+ readOnly + `" onclick="event.preventDefault(); popUp('UploadFile.aspx', 1,` + idInvolucrado +`); ">subirarchivo</button>
                    const newTr = `<tr >
                                    <td class="pt-3-half" contenteditable="false" style="display:none;">` + idInvolucrado + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + nombre + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + accion + `</td></tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableInv2 tbody').append(newTr);
                    }

                }
            } else {
                $('#tableInv2').hide();
                $('#collapseInv2 .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 116; })[0].tag + '</p>'); 
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function saveInvolucrado(idInvolucrado, nombre, puesto, tipo, fechaIngreso, acciones, fechaCompromiso) {

    var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioAlta = idUsuario;

    //console.log("Denuncia: " + denuncia + ", idEntrevistado: " + idEntrevistado + ", usuariaAlta: " + usuarioAlta + ", nombre: " + nombre + ", puesto: " + puesto + ", entrevistado: " + entrevistador);
    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'Detalle.aspx/SaveInvolucrado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'idInvolucrado': idInvolucrado, 'nombre': nombre, 'puesto': puesto, 'tipo': tipo, 'fechaIngreso': fechaIngreso, 'acciones': acciones, 'fechaCompromiso': fechaCompromiso, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $('#tableInv2 table tbody').empty();
            cargarInvolucradosInvestigacion();
            //console.log(data);

            //window.location.href = "Detalle.aspx?id=" + denuncia;
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

function saveInvolucradoEnvio(idInvolucrado, nombre, puesto, tipo, fechaIngreso, acciones, fechaCompromiso) {

    var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioAlta = idUsuario;

    //console.log("Denuncia: " + denuncia + ", idEntrevistado: " + idEntrevistado + ", usuariaAlta: " + usuarioAlta + ", nombre: " + nombre + ", puesto: " + puesto + ", entrevistado: " + entrevistador);
    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/SaveInvolucrado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'idInvolucrado': idInvolucrado, 'nombre': nombre, 'puesto': puesto, 'tipo': tipo, 'fechaIngreso': fechaIngreso, 'acciones': acciones, 'fechaCompromiso': fechaCompromiso, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            
        },
        complete: function () {
            
        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarAcciones(i, sel) {

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarAcciones',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idioma': idioma }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            $('#accion' + i).append('<option value="0" selected="selected">' + tagsTable.filter(function (tag) { return tag.id == 87; })[0].tag +'</option > ');

            for (x = 0; x < objdata.Accion.length-1; x++){

                if (objdata.Accion[x][0] == sel) {
                    //$('#tableInv2 tbody tr:nth-child(' + i + ') td select').append('<option value="' + objdata.Accion[x][0] + '" selected="selected">' + objdata.Accion[x][1] + '</option > ');
                    $('#accion'+i).append('<option value="' + objdata.Accion[x][0] + '" selected="selected">' + objdata.Accion[x][1] + '</option > ');
                } else {
                    //$('#tableInv2 tbody tr:nth-child(' + i + ') td select').append('<option value="' + objdata.Accion[x][0] + '">' + objdata.Accion[x][1] + '</option > ');
                    $('#accion'+i).append('<option value="' + objdata.Accion[x][0] + '">' + objdata.Accion[x][1] + '</option > ');
                }
             }
            //return objdata.Accion;
        },
        error: function (e) {
            console.log(e);
            return e;
        }
    });
}

function cargarTipos(i, sel) {

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarTipos',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idioma': idioma }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            //console.log(objdata.Tipo);

            $('#tipo' + i).append('<option value="0" selected="selected">' + tagsTable.filter(function (tag) { return tag.id == 88; })[0].tag +'</option > ');

            for (x = 0; x < objdata.Tipo.length - 1; x++) {

                if (objdata.Tipo[x][0] == sel) {
                    //$('#tableInv2 tbody tr:nth-child(' + i + ') td select').append('<option value="' + objdata.Accion[x][0] + '" selected="selected">' + objdata.Accion[x][1] + '</option > ');
                    $('#tipo' + i).append('<option value="' + objdata.Tipo[x][0] + '" selected="selected">' + objdata.Tipo[x][1] + '</option > ');
                } else {
                    //$('#tableInv2 tbody tr:nth-child(' + i + ') td select').append('<option value="' + objdata.Accion[x][0] + '">' + objdata.Accion[x][1] + '</option > ');
                    $('#tipo' + i).append('<option value="' + objdata.Tipo[x][0] + '">' + objdata.Tipo[x][1] + '</option > ');
                }
            }
            //return objdata.Accion;
        },
        error: function (e) {
            console.log(e);
            return e;
        }
    });
}

function cargarDenunciasAsociadas() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarDenunciasAsociadas',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            $('#accordionAsoc h2 button ').append(" (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {


                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var id = objdata.Table1[i]["0"];
                    var titulo = objdata.Table1[i]["1"];

                    const $tableID = $('#tableAsoc');

                    const newTr = `
                                    <tr>
                                        <td class="pt-3-half" contenteditable="false"><a href="CasosAsociados.aspx?id=`+ id + `&denuncia=` + idDenuncia + `" target="_blank">` + id + `</a></td>
                                        <td class="pt-3-half" contenteditable="false">`+ titulo + `</td>
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableAsoc tbody').append(newTr);
                    }
                }
            } else {
                $('#tableAsoc').hide();
                $('#collapseAsoc .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 89; })[0].tag +'</p>');
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarDenunciasAntecedentes() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarDenunciasAntecedentes',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            $('#accordionAnte h2 button ').append(" (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {


                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var id = objdata.Table1[i]["0"];
                    var titulo = objdata.Table1[i]["1"];
                    var grupo = objdata.Table1[i]["2"];
                    var involucrados = objdata.Table1[i]["3"];
                    var madurez = objdata.Table1[i]["4"];
                    var tipo = objdata.Table1[i]["5"];

                    const $tableID = $('#tableAnte');

                    const newTr = `
                                    <tr>
                                        <td class="pt-3-half" contenteditable="false"><a href="Antecedente.aspx?id=` + id + `&tipo=` + tipo + ` " target="_blank">` + id + `</a></td>
                                        <td class="pt-3-half" contenteditable="false">`+ titulo + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ grupo + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ involucrados + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ madurez + `</td>
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableAnte tbody').append(newTr);
                    }
                }
            } else {
                $('#tableAnte').hide();
                $('#collapseAnte .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 89; })[0].tag + '</p>');
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarDocumentos() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarDocumentos',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            $('#accordionDocs h2 button ').append(" (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {


                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var nombre = objdata.Table1[i]["0"];
                    var liga = objdata.Table1[i]["1"];

                    const $tableID = $('#tableDocs');

                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="false"><a href="http://140.140.91.31/buzonEsp/` + liga + `" target="_blank" >` + nombre + `</a></td>
                                        
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableDocs tbody').append(newTr);
                    }
                }
            } else {
                $('#tableDocs').hide();
                $('#collapseDocs .card-body').append('<p> ' + tagsTable.filter(function (tag) { return tag.id == 90; })[0].tag +'</p>'); /*No se encontraron documentos*/
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarDocumentosAntecedentes() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'Antecedente.aspx/CargarDocumentosAntecedentes',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            $('#accordionDocs h2 button ').append(" (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {


                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var nombre = objdata.Table1[i]["0"];
                    var liga = objdata.Table1[i]["1"];

                    const $tableID = $('#tableDocs');

                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="false"><a href="http://140.140.91.31/buzonEsp/` + liga + `" target="_blank" >` + nombre + `</a></td>
                                        
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableDocs tbody').append(newTr);
                    }
                }
            } else {
                $('#tableDocs').hide();
                $('#collapseDocs .card-body').append('<p> ' + tagsTable.filter(function (tag) { return tag.id == 90; })[0].tag + '</p>'); /*No se encontraron documentos*/
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function addInvolucrados() {

    const $tableID = $('#tableInv2');

    $('.table-addInv').on('click', () => {
        var lastRow = $tableID.find("tr").length -1;

        var newTr2 = `
            <tr>
                <td class="pt-3-half" contenteditable="false" style="display:none;">0</td>
                <td class="pt-3-half" contenteditable="true"></td>
                <td class="pt-3-half" contenteditable="true"></td>
                <td class="pt-3-half" contenteditable="false"><select id = "tipo`+ lastRow + `"></select></td>
                <td class="pt-3-half" contenteditable="false"><input type="text" style="width: 87px;" class="fechaIngreso"></td>
                <td class="pt-3-half" contenteditable="false"><select id = "accion`+ lastRow + `"></select></td>
                <td class="pt-3-half" contenteditable="false"><input type="text" style="width: 87px;" class="fechaCompromiso"></td>
                <td class="pt-3-half" contenteditable="false"></td>
                <td style="min-width: 84px;">
                    <span>
                        <button type="button" style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save"><img src="img/save-2.png" style="margin-left:-4px; " /></button>
                        <button type="button" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove">-</button>
                                                
                    </span>
                </td>
            </tr>`;

        $('#tableInv2 tbody').append(newTr2);

        cargarAcciones(lastRow, 0);
        cargarTipos(lastRow, 0);

        $(".fechaIngreso").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true });
        $(".fechaCompromiso").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true });

    });

    $tableID.on('click', '.table-remove', function () {

        var r = confirm(" " + tagsTable.filter(function (tag) { return tag.id == 86; })[0].tag + ""); /*¿Estas seguro que deseas eliminar el Involucrado ?*/
        if (r == true) {

            var idInvolucrado;

            $(this).parents('tr').each(function () {
                idInvolucrado = $(this).find("td:first").html();
            });

            deleteInvolucrado(idInvolucrado);

            $(this).parents('tr').detach();
        }
    });

    $tableID.on('click', '.table-save', function () {

        var idInvolucrado;
        var nombre;
        var puesto;
        var tipo;
        var fechaIngreso;
        var acciones;
        var fechaCompromiso;

        $(this).parents('tr').each(function () {
            idInvolucrado = $(this).find("td:first").html();
            nombre = $(this).find("td:nth-child(2)").html();
            puesto = $(this).find("td:nth-child(3)").html();
            tipo = $(this).find("td:nth-child(4) select").val();
            fechaIngreso = $(this).find("td:nth-child(5) input").val();
            acciones = $(this).find("td:nth-child(6) select").val();
            fechaCompromiso = $(this).find("td:nth-child(7) input").val();
        });

        //console.log(idEntrevistado, nombre, puesto);

        saveInvolucrado(idInvolucrado, nombre, puesto, tipo, fechaIngreso, acciones, fechaCompromiso);

    });

}

function addEntrevistadosBQ() {

    const $tableIDEnt = $('#tableEnt');

    $('.table-addEnt').on('click', () => {
        var lastRow = $tableIDEnt.find("tr").length - 1;

        var newTr2 = `
            <tr>
                <td class="pt-3-half" contenteditable="true" style="display:none;">0</td>
                <td class="pt-3-half" contenteditable="false"><input type="text"></td>
                <td class="pt-3-half" contenteditable="false"><input type="text"></td>
                <td class="pt-3-half" contenteditable="false"><input type="text"></td>
                <td>
                    <span>
                        <button type="button" title="Guardar/Save" style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save"><img src="img/save-2.png" style="margin-left: -4px;" /></button>
                        <button type="button" title="Eliminar/Delete" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove">-</button>
                    </span>
                </td>
            </tr>`;

        $('#tableEnt tbody').append(newTr2);

    });

    $tableIDEnt.on('click', '.table-remove', function () {

        var txt;
        var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 92; })[0].tag + ""); /*¿Estas seguro que deseas eliminar el Entrevistado ?*/
        if (r == true) {

            var idEntrevistado;

            $(this).parents('tr').each(function () {
                idEntrevistado = $(this).find("td:first").html();
            });

            deleteEntrevistado(idEntrevistado);

            $(this).parents('tr').detach();
        }
    });

    $tableIDEnt.on('click', '.table-save', function () {

        var idEntrevistado;
        var nombre;
        var puesto;
        var entrevistado;
        var idQueja = $("#contenido_txtQueja").val();

        $(this).parents('tr').each(function () {
            idEntrevistado = $(this).find("td:first").html();
            nombre = $(this).find("td:nth-child(2) input").val();
            puesto = $(this).find("td:nth-child(3) input").val();
            entrevistado = $(this).find("td:nth-child(4) input").val();
        });

        saveEntrevistadoBQ(idQueja, idEntrevistado, nombre, puesto, entrevistado);

    });

}

function addEntrevistados() {

    const $tableIDEnt = $('#tableEnt');

    $('.table-addEnt').on('click', () => {
        var lastRow = $tableIDEnt.find("tr").length - 1;

        var newTr2 = `
            <tr>
                <td class="pt-3-half" contenteditable="true" style="display:none;">0</td>
                <td class="pt-3-half" contenteditable="false"><input type="text"></td>
                <td class="pt-3-half" contenteditable="false"><input type="text"></td>
                <td class="pt-3-half" contenteditable="false"><input type="text"></td>
                <td>
                    <span>
                        <button type="button" title="Guardar/Save" style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save"><img src="img/save-2.png" style="margin-left: -4px;" /></button>
                        <button type="button" title="Eliminar/Delete" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove">-</button>
                    </span>
                </td>
            </tr>`;

        $('#tableEnt tbody').append(newTr2);

    });

    $tableIDEnt.on('click', '.table-remove', function () {

        var txt;
        var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 92; })[0].tag  +""); /*¿Estas seguro que deseas eliminar el Entrevistado ?*/
        if (r == true) {

            var idEntrevistado;

            $(this).parents('tr').each(function () {
                idEntrevistado = $(this).find("td:first").html();
            });

            deleteEntrevistado(idEntrevistado);

            $(this).parents('tr').detach();
        }
    });

    $tableIDEnt.on('click', '.table-save', function () {
        
        var idEntrevistado;
        var nombre;
        var puesto;
        var entrevistado;

        $(this).parents('tr').each(function () {
            idEntrevistado = $(this).find("td:first").html();
            nombre = $(this).find("td:nth-child(2) input").val();
            puesto = $(this).find("td:nth-child(3) input").val();
            entrevistado = $(this).find("td:nth-child(4) input").val();
        });

        saveEntrevistado(idEntrevistado,nombre, puesto,entrevistado);

    });

}

function cargarEntrevistadosBQ() {

    var idQueja = $('#contenido_txtQueja').val();

    var readOnlyActivado = validarReadOnly();

    if (readOnlyActivado == 1) {
       
        var editable = "false";
    } else {
       
        var editable = "true";
    }

    $.ajax({
        type: "POST",
        url: 'DetalleQuejas.aspx/CargarEntrevistadosBQ',        
        data: JSON.stringify({ 'idQueja': idQueja }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            var s = $('#accordionEnt h2 button ').text().split('(')[0];

            $('#accordionEnt h2 button ').empty();
            $('#accordionEnt h2 button ').append(s + " (" + (objdata.Table1.length - 1) + ") ");            

            if (objdata.Table1.length > 1) {

                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var idEntrevistado = objdata.Table1[i]["0"];
                    var nombre = objdata.Table1[i]["1"];
                    var puesto = objdata.Table1[i]["2"];
                    var entrevistador = objdata.Table1[i]["3"];

                    const $tableID = $('#tableEnt');                    

                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="false" style="display:none;">`+ idEntrevistado + `</td>
                                        <td class="pt-3-half" contenteditable="false"><input type="text" value="`+ nombre + `" ` + (editable == "false" ? `readOnly` : ``) + ` ></td>
                                        <td class="pt-3-half" contenteditable="false"><input type="text" value="`+ puesto + `" ` + (editable == "false" ? `readOnly` : ``) + `></td>
                                        <td class="pt-3-half" contenteditable="false"><input type="text" value="`+ entrevistador + `" ` + (editable == "false" ? `readOnly` : ``) + `></td>
                                        <td>
                                            <span>
                                                <button type="button" title="Guardar/Save"  style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save" ` + (editable == "false" ? `disabled` : ``) + `><img src="img/save-2.png" style="margin-left:-4px;"/></button>
                                                <button type="button" title="Eliminar/Delete"  style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove" ` + (editable == "false" ? `disabled` : ``) + ` >-</button>
                                            </span>
                                        </td>
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableEnt tbody').append(newTr);
                    }

                }
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarEntrevistados() {

    var idDenuncia = $('#contenido_txtFolio').val();

    var readOnlyActivado = validarReadOnly(); 

    if (readOnlyActivado == 1) {
        //var readOnly = "false";
        var editable = "false";
    } else {
        //var readOnly = "true";
        var editable = "true";
    }

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarEntrevistados',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            var s = $('#accordionEnt h2 button ').text().split('(')[0];

            $('#accordionEnt h2 button ').empty();
            $('#accordionEnt h2 button ').append(s +" (" + (objdata.Table1.length - 1) + ") ");

            //$('#accordionEnt h2 button ').append(" ("+ (objdata.Table1.length -1 )+ ") ");

            if (objdata.Table1.length > 1) {


                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var idEntrevistado = objdata.Table1[i]["0"];
                    var nombre = objdata.Table1[i]["1"];
                    var puesto = objdata.Table1[i]["2"];
                    var entrevistador = objdata.Table1[i]["3"];
                    
                    const $tableID = $('#tableEnt');

                    //<td class="pt-3-half" contenteditable="true">`+ fechaIngreso + `</td>

                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="false" style="display:none;">`+ idEntrevistado + `</td>
                                        <td class="pt-3-half" contenteditable="false"><input type="text" value="`+ nombre + `" ` + (editable == "false" ? `readOnly` : ``) + ` ></td>
                                        <td class="pt-3-half" contenteditable="false"><input type="text" value="`+ puesto + `" ` + (editable == "false" ? `readOnly` : ``) + `></td>
                                        <td class="pt-3-half" contenteditable="false"><input type="text" value="`+ entrevistador + `" ` + (editable == "false" ? `readOnly` : ``) + `></td>
                                        <td>
                                            <span>
                                                <button type="button" title="Guardar/Save"  style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save" ` + (editable == "false" ? `disabled` : ``) + `><img src="img/save-2.png" style="margin-left:-4px;"/></button>
                                                <button type="button" title="Eliminar/Delete"  style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove" ` + (editable == "false" ? `disabled` : ``) + ` >-</button>
                                            </span>
                                        </td>
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableEnt tbody').append(newTr);
                    }

                }
            } 

        },
        error: function (e) {
            console.log(e);
        }
    });
}


function saveEntrevistadoBQ(idQueja, idEntrevistado, nombre, puesto, entrevistador) {

    var queja = idQueja;
    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'DetalleQuejas.aspx/SaveEntrevistadoBQ',
        
        data: JSON.stringify({ 'idQueja': queja, 'idEntrevistado': idEntrevistado, 'nombre': nombre, 'puesto': puesto, 'entrevistador': entrevistador, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $('#tableEnt table tbody').empty();
            cargarEntrevistadosBQ();

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

function saveEntrevistado(idEntrevistado,nombre, puesto, entrevistador) {

    var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioAlta = idUsuario;

    //console.log("Denuncia: " + denuncia + ", idEntrevistado: " + idEntrevistado + ", usuariaAlta: " + usuarioAlta + ", nombre: " + nombre + ", puesto: " + puesto + ", entrevistado: " + entrevistador);
    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'Detalle.aspx/SaveEntrevistado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'idEntrevistado': idEntrevistado, 'nombre': nombre, 'puesto': puesto, 'entrevistador': entrevistador, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $('#tableEnt table tbody').empty();
            cargarEntrevistados();
            //console.log(data);
            
            //window.location.href = "Detalle.aspx?id=" + denuncia;
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

function saveEntrevistadoEnvio(idEntrevistado, nombre, puesto, entrevistador) {

    var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioAlta = idUsuario;

    //console.log("Denuncia: " + denuncia + ", idEntrevistado: " + idEntrevistado + ", usuariaAlta: " + usuarioAlta + ", nombre: " + nombre + ", puesto: " + puesto + ", entrevistado: " + entrevistador);
    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/SaveEntrevistado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'idEntrevistado': idEntrevistado, 'nombre': nombre, 'puesto': puesto, 'entrevistador': entrevistador, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
        },
        complete: function () {
            
        },
        error: function (e) {
            console.log(e);
        }
    });
}

function deleteEntrevistadoBQ(idEntrevistado) {
    var queja = $('#contenido_txtFolio').val();
    var usuarioBaja = idUsuario;

    $.ajax({
        type: "POST",
        url: 'DetalleQuejas.aspx/DeleteEntrevistadoBQ',
        
        data: JSON.stringify({ 'idEntrevistado': idEntrevistado, 'usuarioBaja': usuarioBaja }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function deleteEntrevistado(idEntrevistado) {

    var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioBaja = idUsuario;

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/DeleteEntrevistado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({'idEntrevistado': idEntrevistado, 'usuarioBaja': usuarioBaja }),
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

function deleteInvolucrado(idInvolucrado) {

    //var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioBaja = idUsuario;

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/DeleteInvolucrado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idInvolucrado': idInvolucrado, 'usuarioBaja': usuarioBaja }),
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

function deleteSoporte() {

    const $tableID = $('#tableSoporte');

    $tableID.on('click', '.table-remove', function () {

        var txt;
        var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 93; })[0].tag + ""); /*¿Estas seguro que deseas eliminar el Soporte?*/
        if (r == true) {
            var idSoporte;

            $(this).parents('tr').each(function () {
                idSoporte = $(this).find("td:first").html();
            });

            deleteSoporteBD(idSoporte);

            $(this).parents('tr').detach();

        } 
    });

    const $tableID2 = $('#tableSoporte2');

    $tableID2.on('click', '.table-remove', function () {

        var txt;
        var r = confirm(""+ tagsTable.filter(function (tag) { return tag.id == 93; })[0].tag +""); /*¿Estas seguro que deseas eliminar el Soporte ?*/
        if (r == true) {
            var idSoporte;

            $(this).parents('tr').each(function () {
                idSoporte = $(this).find("td:first").html();
            });

            deleteSoporteBD(idSoporte);

            $(this).parents('tr').detach();
        }
    });

}

function cargarTemas() {

    var idDenuncia = $('#contenido_txtFolio').val();

    var readOnlyActivado = validarReadOnly();

    if (readOnlyActivado == 1) {
        var editable = "false";
    } else {
        var editable = "true";
    }

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/CargarTemas',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            var s = $('#accordionTema h2 button ').text().split('(')[0];

            $('#accordionTema h2 button ').empty();

            $('#accordionTema h2 button ').append(s+" (" + (objdata.Table1.length - 1) + ") ");

            if (objdata.Table1.length > 1) {

                for (i = 0; i < objdata.Table1.length - 1; i++) {

                    var idTema = objdata.Table1[i]["0"];
                    var tema = objdata.Table1[i]["1"];
                    //var subtema = objdata.Table1[i]["2"];
                    var asunto = objdata.Table1[i]["3"];
                    //var planAccion = objdata.Table1[i]["4"];
                    var conclusiones = objdata.Table1[i]["5"];
                    var resultado = objdata.Table1[i]["6"];
                    var completo = objdata.Table1[i]["7"];

                    const $tableID = $('#tableTema');

                    //<td class="pt-3-half" contenteditable="true">`+ fechaIngreso + `</td>
                    //<button type="button" style="width:30px; margin-right: -5px;" class="btn btn-success btn-rounded btn-sm my-0 table-save"><img src="img/save.png" style="height:12px;" /></button>
                    //<td class="pt-3-half" contenteditable="true">`+ planAccion +`</td>
                    //<td class="pt-3-half" contenteditable="false">`+ subtema +`</td>
                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">`+ idTema + `</td>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">`+ completo + `</td>
                                        <td runat="server" class="pt-3-half openModal" data-toggle="modal" data-target=".bd-example-modal-xl" OnClick="return cargarModalTema(`+ idTema + `); " contenteditable="false" style="text-decoration: underline; color: cornflowerblue; cursor: pointer;">`+ tema + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ asunto +`</td>
                                        <td class="pt-3-half" contenteditable="false" >`+ conclusiones +`</td>
                                        <td class="pt-3-half" contenteditable="false">`+ resultado +`</td>
                                        <td>
                                            <span>
                                                <button title="Eliminar/Delete" type="button" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove" ` + (editable == "false" ? `disabled` : ``) + `>-</button>
                                            </span>
                                        </td>
                                    </tr> `;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableTema tbody').append(newTr);
                    }

                }
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarTemasLite() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'DetalleLite.aspx/CargarTemasLite',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia, 'idioma': idioma }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            var objdata = $.parseJSON(data.d);

            var s = $('#accordionTema h2 button ').text().split('(')[0];

            $('#accordionTema h2 button ').empty();

            $('#accordionTema h2 button ').append(s + " (" + (objdata.PR_TemaInvestigacion.length - 1) + ") ");

            if (objdata.PR_TemaInvestigacion.length > 1) {

                for (i = 0; i < objdata.PR_TemaInvestigacion.length - 1; i++) {

                    var idTema = objdata.PR_TemaInvestigacion[i]["0"];
                    var actividades = objdata.PR_TemaInvestigacion[i]["1"];
                    var planAccion = objdata.PR_TemaInvestigacion[i]["2"];
                    var conclusiones = objdata.PR_TemaInvestigacion[i]["3"];
                    var resultado = objdata.PR_TemaInvestigacion[i]["4"];

                    const $tableID = $('#tableTema');

                    const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="false" style="display:none;">`+ idTema + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ actividades + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ planAccion + `</td>
                                        <td class="pt-3-half" contenteditable="false" >`+ conclusiones + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ resultado + `</td>
                                    </tr> `;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableTema tbody').append(newTr);
                    }

                }
            } else {
                $('#tableTema').hide();
                $('#collapseTema .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 119; })[0].tag + '</p>'); 
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function addTemas() {

    const $tableIDEnt = $('#tableTema');

    $tableIDEnt.on('click', '.table-remove', function () {

        var txt;
        var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 94; })[0].tag + ""); /*¿Estas seguro que deseas eliminar el Tema ?*/
        if (r == true) {

            var idTema;

            $(this).parents('tr').each(function () {
                idTema = $(this).find("td:first").html();
            });

            deleteTema(idTema);

            $(this).parents('tr').detach();
        }
    });

    //$tableIDEnt.on('click', '.table-save', function () {

    //    var idEntrevistado;
    //    var nombre;
    //    var puesto;
    //    var entrevistado;

    //    $(this).parents('tr').each(function () {
    //        idEntrevistado = $(this).find("td:first").html();
    //        nombre = $(this).find("td:nth-child(2)").html();
    //        puesto = $(this).find("td:nth-child(3)").html();
    //        entrevistado = $(this).find("td:nth-child(4)").html();
    //    });

    //    saveEntrevistado(idEntrevistado, nombre, puesto, entrevistado);

    //});

}

function cargarModalTema(idTema) {

    $(".rechazo").hide();
    $(".soporte").hide();
    $(".rechazoInv").hide();
    $(".principal").show();
    
    $("#modalPrincipal-title").text("" + tagsTable.filter(function (tag) { return tag.id == 44; })[0].tag + ""); /*Analisis*/

    limpiarModalTema();

    if (idTema > 0) {
        $.ajax({
            type: "POST",
            url: 'Detalle.aspx/CargarModalTema',
            // data: {'idDenuncia: ' + idDenuncia },
            data: JSON.stringify({ 'idTema': idTema }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //$("#divResult").html("success");
                var objdata = $.parseJSON(data.d);
                //console.log(objdata);

                $('#contenido_mTxtIdTema').val(objdata.PR_TemaInvestigacion["0"]["0"]);
                $('#contenido_mTxtTema').val(objdata.PR_TemaInvestigacion["0"]["1"]);
                //$('#contenido_mTxtSubTema').val(objdata.PR_TemaInvestigacion["0"]["2"]);
                $('#contenido_mTxtAsunto').val(objdata.PR_TemaInvestigacion["0"]["3"]);
                $('#contenido_mTxtActividades').val(objdata.PR_TemaInvestigacion["0"]["4"]);
                $('#contenido_mTxtDetalle').val(objdata.PR_TemaInvestigacion["0"]["5"]);
                $('#contenido_mTxtPlan').val(objdata.PR_TemaInvestigacion["0"]["6"]);
                $('#contenido_mTxtConclusiones').val(objdata.PR_TemaInvestigacion["0"]["7"]);

                if (objdata.PR_TemaInvestigacion["0"]["8"] > 0) {
                    $('#contenido_resultadoDDL').val(objdata.PR_TemaInvestigacion["0"]["8"]);
                }
                if (objdata.PR_TemaInvestigacion["0"]["9"] > 0) {
                    $('#contenido_beneficioDDL').val(objdata.PR_TemaInvestigacion["0"]["9"]);
                }
                
                if (objdata.PR_TemaInvestigacion["0"]["10"]>0) {
                    $('#btnMSop').prop('disabled', false);
                    
                } else {
                    $('#btnMSop').prop('disabled', true);
                   
                }

                $('#btnAddSoporteModal').prop('disabled', false);

            },
            error: function (e) {
                console.log(e);
            }
        });
    } else {
        $('#contenido_mTxtIdTema').val('0');
        $('#btnAddSoporteModal').prop('disabled', true);

    }
}

function cargarModalSoporte(tipo, id) {

    if (tipo == 1) {

        $(".principal").hide();
        $(".rechazo").hide();
        $(".soporte").show();
        $(".rechazoInv").hide();

        $('#tableSoporte tbody').empty();

        $("#modalPrincipal-title").text("" + tagsTable.filter(function (tag) { return tag.id == 53; })[0].tag + ""); /*Soporte*/

    } else {

        id = $('#contenido_mTxtIdTema').val();
        $('#tableSoporte2 tbody').empty();
    }
    
    if (tipo > 0 && id > 0) {
        var editable;

        var readOnlyActivado = validarReadOnly();

        if (readOnlyActivado == 1) {
            //var readOnly = "false";
            var editable = "false";
        } else {
            //var readOnly = "true";
            var editable = "true";
        }


        $.ajax({
            type: "POST",
            url: 'Detalle.aspx/CargarSoporte',
            // data: {'idDenuncia: ' + idDenuncia },
            data: JSON.stringify({ 'tipo': tipo, 'id':id }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //$("#divResult").html("success");
                var objdata = $.parseJSON(data.d);
                //console.log(objdata);

                if (objdata.PR_DocumentosInvestigacion.length > 1) {

                    for (i = 0; i < objdata.PR_DocumentosInvestigacion.length - 1; i++) {

                        var idSoporte = objdata.PR_DocumentosInvestigacion[i]["0"];
                        var nombreOriginal = objdata.PR_DocumentosInvestigacion[i]["3"];
                        var nombre = objdata.PR_DocumentosInvestigacion[i]["4"];
                        //var fechaIngreso = objdata.DocumentosInvestigacion[i]["4"];
                        //var idAccion = objdata.DocumentosInvestigacion[i]["5"];
                        //var fechaCompromiso = objdata.DocumentosInvestigacion[i]["6"];
                        //var Soporte = objdata.DocumentosInvestigacion[i]["7"];
                        //var tipo = objdata.DocumentosInvestigacion[i]["8"];

                        //var url = setPath();

                        var url = document.location.hostname;

                        url = nombre;
                        var $tableID="";

                        if (tipo == 1) {
                            $tableID = $('#tableSoporte');
                        } else {
                            $tableID = $('#tableSoporte2');
                        }

                        //<td class="pt-3-half" contenteditable="true">`+ fechaIngreso + `</td>
                        //<td class="pt-3-half" contenteditable="`+ readOnly + `"><button onclick="event.preventDefault(); popUp('UploadFile.aspx', 1);">subirarchivo</button></td>
                        //<button contenteditable="`+ readOnly + `" onclick="event.preventDefault(); popUp('UploadFile.aspx', 1,` + idInvolucrado +`); ">subirarchivo</button>
                        const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">` + idSoporte + `</td>
                                        <td class="pt-3-half" ><a download href="`+ url + `" >` + nombreOriginal + `</td>
                                        <td style="min-width: 84px;">
                                            <span>
                                                <button type="button" style="width:30px;"class="btn btn-danger btn-rounded btn-sm my-0 table-remove" ` + (editable == "false" ? `disabled` : ``) + ` >-</button>
                                            </span>
                                        </td>
                                    </tr>`;

                        if ($tableID.find('tbody').length > 0) {

                            if (tipo == 1) {
                                $('#tableSoporte tbody').append(newTr);
                            } else {
                                $('#tableSoporte2 tbody').append(newTr);
                            }

                            
                        }

                    }
                } else {
                    //$('#tableInv2').hide();
                    $('#tableSoporte tbody').append('<td><p style="margin-top: 10px;font-size: 19px; margin-left:45px;"> '+ tagsTable.filter(function (tag) { return tag.id == 95; })[0].tag +'</p></td><td></td>');
                }

            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}

function cargarModalRechazo(idTema) {

    $(".principal").hide();
    $(".soporte").hide();
    $(".rechazoInv").hide();
    $(".rechazo").show();

    $("#modalPrincipal-title").text(""+ tagsTable.filter(function (tag) { return tag.id == 96; })[0].tag  +""); /*Rechazar Investigación*/
}

function cargarModalRechazoInv() {

    $(".principal").hide();
    $(".soporte").hide();
    $(".rechazo").hide();
    $(".rechazoInv").show();

    //$("#modalPrincipal-title").text("Reasignar Investigación");

    $("#modalPrincipal-title").text("" + tagsTable.filter(function (tag) { return tag.id == 104; })[0].tag + ""); /*Analisis*/


}

function saveTema(idTema) {

    var denuncia = $('#contenido_txtFolio').val();
    var idTema = $('#contenido_mTxtIdTema').val();
    var tema = $('#contenido_mTxtTema').val();
    //var subtema = $('#contenido_mTxtSubTema').val();
    var asunto = $('#contenido_mTxtAsunto').val();
    var actividades = $('#contenido_mTxtActividades').val();
    var detalleActividades = $('#contenido_mTxtDetalle').val();
    var planAccion = $('#contenido_mTxtPlan').val();
    var conclusiones = $('#contenido_mTxtConclusiones').val();
    var resultado = $('#contenido_resultadoDDL').val();
    var beneficio = $('#contenido_beneficioDDL').val();

    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/saveTema',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'idTema': idTema, 'tema': tema, 'asunto': asunto, 'actividades': actividades, 'detalleActividades': detalleActividades, 'planAccion': planAccion, 'conclusiones': conclusiones, 'resultado': resultado, 'beneficio': beneficio, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) { 
            //$("#divResult").html("success");
            var objdata = $.parseJSON(data.d);
            //console.log(objdata);

            //console


            $('#tableTema table tbody tr').remove();
            cargarTemas();

            
        },
        error: function (e) {
            console.log(e);
        }
    });
}

function limpiarModalTema() {

    $('#contenido_mTxtIdTema').val('');
    $('#contenido_mTxtTema').val('');
    //$('#contenido_mTxtSubTema').val('');
    $('#contenido_mTxtAsunto').val('');
    $('#contenido_mTxtActividades').val('');
    $('#contenido_mTxtDetalle').val('');
    $('#contenido_mTxtPlan').val('');
    $('#contenido_mTxtConclusiones').val('');
    $('#contenido_resultadoDDL').val(0);
    $('#contenido_beneficioDDL').val(0);
}

function deleteTema(idTema) {

    //var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioBaja = idUsuario;

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/DeleteTema',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idTema': idTema, 'usuarioBaja': usuarioBaja }),
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

function deleteSoporteBD(idSoporte) {

    //var denuncia = $('#contenido_txtFolio').val();
    //var usuarioAlta = "<%= Session['idUsuario'] %>";

    var usuarioBaja = idUsuario;

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/DeleteSoporte',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idSoporte': idSoporte, 'usuarioBaja': usuarioBaja }),
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

function saveComentarioBQ() {
    var queja = $('#contenido_txtQueja').val();
    var comentario = $('#contenido_txtComentarioQueja').val();
    var usuarioAlta = idUsuario;

    if (comentario.length > 0) {

        $.ajax({
            type: "POST",
            url: 'DetalleQuejas.aspx/saveComentarioBQ',
            // data: {'idDenuncia: ' + idDenuncia },
            data: JSON.stringify({ 'idQueja': queja, 'comentario': comentario, 'usuarioAlta': usuarioAlta }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {                
                var objdata = $.parseJSON(data.d);                

                $('#contenido_txtComentario').val('');

                var comentarioAnterior = $('#contenido_txtDisplayComentario').val();

                const date = new Date();
                
                const formattedDate = date.toLocaleDateString('es-ES', {
                    day: 'numeric', month: 'short', year: 'numeric'
                }).replace(/ /g, ' ').replace('.', '').replace(/\w\S*/g, function (txt) { return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase(); });;                

                $('#contenido_txtDisplayComentario').val(comentarioAnterior + '\n' + formattedDate + ' - ' + nombreUsuario + ' - ' + comentario);

                var $textarea = $('#contenido_txtDisplayComentario');
                $textarea.scrollTop($textarea[0].scrollHeight);

            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}


function saveComentario() {

    var denuncia = $('#contenido_txtFolio').val();
    var comentario = $('#contenido_txtComentario').val();
    var usuarioAlta = idUsuario;

    if (comentario.length > 0) {

        $.ajax({
            type: "POST",
            url: 'Detalle.aspx/saveComentario',
            // data: {'idDenuncia: ' + idDenuncia },
            data: JSON.stringify({ 'idDenuncia': denuncia, 'comentario': comentario, 'usuarioAlta': usuarioAlta }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //$("#divResult").html("success");
                var objdata = $.parseJSON(data.d);
                //console.log(objdata);

                $('#contenido_txtComentario').val('');

                var comentarioAnterior = $('#contenido_txtDisplayComentario').val();

                const date = new Date();
                //en-GB
                const formattedDate = date.toLocaleDateString('es-ES', {
                    day: 'numeric', month: 'short', year: 'numeric'
                }).replace(/ /g, ' ').replace('.', '').replace(/\w\S*/g, function (txt) { return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase(); });;
                //console.log(formattedDate);

                $('#contenido_txtDisplayComentario').val(comentarioAnterior + '\n' + formattedDate + ' - ' + nombreUsuario + ' - ' + comentario);

                var $textarea = $('#contenido_txtDisplayComentario');
                $textarea.scrollTop($textarea[0].scrollHeight);

            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}

function saveConclusion() {

    var denuncia = $('#contenido_txtFolio').val();
    var conclusion = $('#contenido_txtConclusion').val();
    var usuarioAlta = idUsuario;

    guardarInvolucrados();
    guardarEntrevistados();

    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'Detalle.aspx/saveConclusion',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'conclusion': conclusion, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //$("#divResult").html("success");
            var objdata = $.parseJSON(data.d);
            //console.log(objdata);

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

function saveConclusionEnvio() {

    var denuncia = $('#contenido_txtFolio').val();
    var conclusion = $('#contenido_txtConclusion').val();
    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        beforeSend: function () {
        },
        url: 'Detalle.aspx/saveConclusion',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'conclusion': conclusion, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //$("#divResult").html("success");
            var objdata = $.parseJSON(data.d);
            //console.log(objdata);
        },
        error: function (e) {
            console.log(e);
        }
    });
}

function sendAuditoria() {

    //cargarInvolucradosInvestigacion();

    var txt;
    var r = confirm(""+ tagsTable.filter(function (tag) { return tag.id == 97; })[0].tag  +""); /*¿Estas seguro que deseas enviar la investigación a Revisión por Auditoria ?*/
    if (r == true) {

        var pasaValidacion = true;
        var valInvolucrados = true;
        var valEntrevistados = true;
        var valTemas = true;
        saveConclusion();
        //var conclusion = $('#contenido_txtConclusion').val();

        if ($('#contenido_txtConclusion').val() == "") {
            $('#contenido_txtConclusion').addClass("error");
            pasaValidacion = false;
        } else {
            $('#contenido_txtConclusion').removeClass("error");
        }

        valInvolucrados = validarInvolucrados();

        if (valInvolucrados == false) {
            pasaValidacion = false;
        }

        valEntrevistados = validarEntrevistados();

        if (valEntrevistados == false) {
            pasaValidacion = false;
        }

        valTemas = validarTemas();
        if (valTemas == false) {
            pasaValidacion = false;
        }

        if (pasaValidacion) {

            var denuncia = $('#contenido_txtFolio').val();
            //var conclusion = $('#contenido_txtConclusion').val();
            var usuarioAlta = idUsuario;

            $.ajax({
                type: "POST",
                beforeSend: function () {
                    $('.ajax-loader').css("visibility", "visible");
                },
                url: 'Detalle.aspx/sendAuditoria',
                // data: {'idDenuncia: ' + idDenuncia },
                data: JSON.stringify({ 'idDenuncia': denuncia, 'usuarioAlta': usuarioAlta }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    window.location.href = "Dashboard.aspx";
                },
                complete: function () {
                    $('.ajax-loader').css("visibility", "hidden");

                    //$(".ajax-save").show();
                    //setTimeout(function () { $(".ajax-save").hide(); }, 500);
                },
                error: function (e) {
                    console.log(e);
                }
            });
        } else {
            alert("" + tagsTable.filter(function (tag) { return tag.id == 98; })[0].tag + ""); /*Te falta llenar algunos campos obligatorios*/
        }
    }
}

function sendVoBo() {

    var txt;
    var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 99; })[0].tag + ""); /*¿Estas seguro que deseas enviar la investigación a VoBo ?*/
    if (r == true) {

        var pasaValidacion = true;
        var valInvolucrados = true;
        var valEntrevistados = true;
        var valTemas = true;
        //var conclusion = $('#contenido_txtConclusion').val();

        if ($('#contenido_txtConclusion').val() == "") {
            $('#contenido_txtConclusion').addClass("error");
            pasaValidacion = false;
        } else {
            $('#contenido_txtConclusion').removeClass("error");
            saveConclusionEnvio();
        }

        valInvolucrados = validarInvolucrados();

        if (valInvolucrados == false) {
            pasaValidacion = false;
        }

        valEntrevistados = validarEntrevistados();

        if (valEntrevistados == false) {
            pasaValidacion = false;
        }

        valTemas = validarTemas();
        if (valTemas == false) {
            pasaValidacion = false;
        }

        if (pasaValidacion) {

            var denuncia = $('#contenido_txtFolio').val();
            //var conclusion = $('#contenido_txtConclusion').val();
            var usuarioAlta = idUsuario;

            $.ajax({
                type: "POST",
                beforeSend: function () {
                    $('.ajax-loader').css("visibility", "visible");
                },
                url: 'Detalle.aspx/sendVoBo',
                // data: {'idDenuncia: ' + idDenuncia },
                data: JSON.stringify({ 'idDenuncia': denuncia, 'usuarioAlta': usuarioAlta }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    window.location.href = "Dashboard.aspx";
                    //console.log(data);
                },
                complete: function () {
                    $('.ajax-loader').css("visibility", "hidden");

                    //$(".ajax-save").show();
                    //setTimeout(function () { $(".ajax-save").hide(); }, 500);
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }
    }
}

function sendRevision() {

    var txt;
    var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 100; })[0].tag + ""); /*¿Estas seguro que deseas enviar la investigación a Revisión ?*/
    if (r == true) {

        var pasaValidacion = true;
        var valInvolucrados = true;
        var valEntrevistados = true;
        var valTemas = true;
        //var conclusion = $('#contenido_txtConclusion').val();

        if ($('#contenido_txtConclusion').val() == "") {
            $('#contenido_txtConclusion').addClass("error");
            pasaValidacion = false;
        } else {
            $('#contenido_txtConclusion').removeClass("error");
            saveConclusionEnvio();
        }

        valInvolucrados = validarInvolucrados();

        if (valInvolucrados == false) {
            pasaValidacion = false;
        }

        valEntrevistados = validarEntrevistados();

        if (valEntrevistados == false) {
            pasaValidacion = false;
        }

        valTemas = validarTemas();
        if (valTemas == false) {
            pasaValidacion = false;
        }

        if (pasaValidacion) {

            var denuncia = $('#contenido_txtFolio').val();
            //var conclusion = $('#contenido_txtConclusion').val();
            var usuarioAlta = idUsuario;

            $.ajax({
                type: "POST",
                beforeSend: function () {
                    $('.ajax-loader').css("visibility", "visible");
                },
                url: 'Detalle.aspx/sendRevision',
                // data: {'idDenuncia: ' + idDenuncia },
                data: JSON.stringify({ 'idDenuncia': denuncia, 'usuarioAlta': usuarioAlta }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    window.location.href = "Dashboard.aspx";
                    //console.log(data);
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
}

function sendRechazar() {

    var denuncia = $('#contenido_txtFolio').val();
    var comentarioRechazo = $('#contenido_txtComentarioRechazo').val();
    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'Detalle.aspx/sendRechazar',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({'idDenuncia': denuncia, 'comentarioRechazo': comentarioRechazo, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //window.location.href = "Dashboard.aspx";
            window.location.reload();
            //console.log(data);
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

function sendRechazarInv() {

    var denuncia = $('#contenido_txtFolio').val();
    var comentarioRechazo = $('#contenido_txtComentarioRechazoInv').val();
    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        beforeSend: function () {
            $('.ajax-loader').css("visibility", "visible");
        },
        url: 'Detalle.aspx/sendRechazarInv',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'comentarioRechazo': comentarioRechazo, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            window.location.href = "Dashboard.aspx";
            //console.log(data);
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

function sendGerente() {

    //cargarInvolucradosInvestigacion();
    var txt;
    var r = confirm("" + tagsTable.filter(function (tag) { return tag.id == 101; })[0].tag + ""); /*"¿Estas seguro que deseas enviar la investigación al Gerente?"*/
    if (r == true) {

        var denuncia = $('#contenido_txtFolio').val();
        //var conclusion = $('#contenido_txtConclusion').val();
        var usuarioAlta = idUsuario;

        $.ajax({
            type: "POST",
            beforeSend: function () {
                $('.ajax-loader').css("visibility", "visible");
            },
            url: 'Detalle.aspx/sendGerente',
            // data: {'idDenuncia: ' + idDenuncia },
            data: JSON.stringify({ 'idDenuncia': denuncia, 'usuarioAlta': usuarioAlta }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                alert("Se envio al gerente con exito");
                //window.location.reload;

            },
            complete: function () {
                $('.ajax-loader').css("visibility", "hidden");
                location.reload();
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}

function sendMadurez() {

    //cargarInvolucradosInvestigacion();
    var txt;
    var r = confirm("¿Estas seguro que deseas aceptar y asignar madurez a la denuncia?"); 
    if (r == true) {

        var madurez = $("#contenido_ddlMadurez").val();

        if (madurez == 0) {

            alert("Por favor selecciona una madurez");

        }
        else {

            var denuncia = $('#contenido_txtFolio').val();
            //var conclusion = $('#contenido_txtConclusion').val();
            var usuarioAlta = idUsuario;

            $.ajax({
                type: "POST",
                beforeSend: function () {
                    $('.ajax-loader').css("visibility", "visible");
                },
                url: 'Detalle.aspx/sendMadurez',
                // data: {'idDenuncia: ' + idDenuncia },
                data: JSON.stringify({ 'idDenuncia': denuncia, 'madurez': madurez, 'usuarioAlta': usuarioAlta }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    alert("Se guardó la información correctamente");
                    //window.location.reload;

                },
                complete: function () {
                    $('.ajax-loader').css("visibility", "hidden");
                    location.reload();
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }

    }
}

function uploadFiles(formData) {
    //console.log("hola");
    $.ajax({
        url: "Detalle.aspx/UploadFiles",
        method: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function (data) {
            var str = "";
            for (var i = 0; i < data.length; i++) {
                str += "<img src='" + data[i] + "' height='100' width='100'>"
            }

            $(".file-upload-container").append(str);
        },
        error: function (data) {
            alert("Upload Failed!");
        }
    })
}

function popUp(url, tipo,id) {
    var usuarioAlta = idUsuario;

    guardarInvolucrados();

    if (tipo == 2) {
        saveTema();
        id = $('#contenido_mTxtIdTema').val();
    } else {
        guardarInvolucrados();
    }
    //alert(id);
    localStorage.clear();
    //localStorage.setItem("idDenuncia", $("#contenido_txtFolio").val());
    localStorage.setItem("tipo", tipo);
    localStorage.setItem("id", id);
    localStorage.setItem("usuarioAlta", usuarioAlta);
   
    var popUpObj = window.open(url, "Popup", "toolbar=no,scrollbars=no,location=no" +
        ",statusbar=no,menubar=no,resizable=0,width=600," +
        "height=300,right= 400,top = 300,");

    popUpObj.focus();

}

function validarInvolucrados() {

    var pasaValidacion = true;

    $("#tableInv2 table tbody tr").each(function () {
        var idInvolucrado = $(this).find("td:first").html();
        var nombre = $(this).find("td:nth-child(2)").html();
        var puesto = $(this).find("td:nth-child(3)").html();
        var tipo = $(this).find("td:nth-child(4) select").val();
        var fechaIngreso = $(this).find("td:nth-child(5) input").val();
        var acciones = $(this).find("td:nth-child(6) select").val();
        var fechaCompromiso = $(this).find("td:nth-child(7) input").val()

        saveInvolucradoEnvio(idInvolucrado, nombre, puesto, tipo, fechaIngreso, acciones, fechaCompromiso);

        if (nombre.trim() == "" || nombre == '&nbsp;') {
            pasaValidacion = false;
            $(this).find("td:nth-child(2)").addClass("error");
        } else {
            $(this).find("td:nth-child(2)").removeClass("error");
        }

        if (tipo == 0) {
            pasaValidacion = false;
            $(this).find("td:nth-child(4) select").addClass("error");
        }
        else {
            $(this).find("td:nth-child(4) select").removeClass("error");
        }

        //if (fechaIngreso == "") {
        //    pasaValidacion = false;
        //    $(this).find("td:nth-child(5) input").addClass("error");
        //} else {
        //    $(this).find("td:nth-child(5) input").removeClass("error");
        //}

        if (acciones == 0) {
            pasaValidacion = false;
            $(this).find("td:nth-child(6) select").addClass("error");
        } else {
            $(this).find("td:nth-child(6) select").removeClass("error");
        }

        if (fechaCompromiso == "" && acciones !=4) {
            pasaValidacion = false;
            $(this).find("td:nth-child(7) input").addClass("error");
        } else {
            $(this).find("td:nth-child(7) input").removeClass("error");
        }

    });

    if (pasaValidacion == false) {
        $("#accordionInv2 .card-header button").addClass("errorTitle");
    }
    else {
        $("#accordionInv2 .card-header button").removeClass("errorTitle");
    }

    return pasaValidacion;
   
}

function validarEntrevistados() {

    var pasaValidacion = true;

    $("#tableEnt table tbody tr").each(function () {
        var idEntrevistado = $(this).find("td:first").html();
        var nombre = $(this).find("td:nth-child(2) input").val();
        var puesto = $(this).find("td:nth-child(3) input").val();
        var entrevistado = $(this).find("td:nth-child(4) input").val();
        
        saveEntrevistadoEnvio(idEntrevistado, nombre, puesto, entrevistado);

        if (nombre == "") {
            pasaValidacion = false;
            $(this).find("td:nth-child(2)").addClass("error");
        } else {
            $(this).find("td:nth-child(2)").removeClass("error");
        }

        if (puesto == 0) {
            pasaValidacion = false;
            $(this).find("td:nth-child(3)").addClass("error");
        }
        else {
            $(this).find("td:nth-child(3)").removeClass("error");
        }

        if (entrevistado == 0) {
            pasaValidacion = false;
            $(this).find("td:nth-child(4)").addClass("error");
        }
        else {
            $(this).find("td:nth-child(4)").removeClass("error");
        }

    });

    if (pasaValidacion == false) {
        $("#accordionEnt .card-header button").addClass("errorTitle");
    }
    else {
        $("#accordionEnt .card-header button").removeClass("errorTitle");
    }

    return pasaValidacion;

}

function validarTemas() {

    var pasaValidacion = true;
    var completo;


    $("#tableTema table tbody tr").each(function () {
        var idTema = $(this).find("td:first").html();

        var completo = $(this).find("td:nth-child(2)").html();
       
        if (completo == "0") {
            pasaValidacion = false;

            $(this).addClass("error");


        } else {
            $(this).removeClass("error");
        }

    });

    if (pasaValidacion == false) {
        $("#accordionTema .card-header button").addClass("errorTitle");
    }
    else {
        $("#accordionTema .card-header button").removeClass("errorTitle");
    }

    return pasaValidacion;
}

function activarReadOnly() {

    $("#contenido_delegadoDDL").prop('disabled', true);
    $("#contenido_btnDelegar").prop('disabled', true);
    $("#contenido_txtConclusion").prop('disabled', true);

    //Modal Análisis
    $("#contenido_mTxtTema").prop('disabled', true);
    //$("#contenido_mTxtSubTema").prop('disabled', true);
    $("#contenido_mTxtAsunto").prop('disabled', true);
    $("#contenido_mTxtActividades").prop('disabled', true);
    $("#contenido_mTxtDetalle").prop('disabled', true);
    $("#contenido_mTxtPlan").prop('disabled', true);
    $("#contenido_mTxtConclusiones").prop('disabled', true);
    $("#contenido_resultadoDDL").prop('disabled', true);
    $("#contenido_beneficioDDL").prop('disabled', true);
    //$("#btnAddSoporteModal").prop('disabled', true);
    $("#btnAddSoporteModal").hide();
    $(".modal-footer.principal button:nth-child(1)").prop('disabled', true);

    $("#addTemaPlus").hide();
    $("#addEntrevistadoPlus").hide();
    $("#addInvolucradosPlus").hide();

}

function validarReadOnly() {

    //Si es responsable principal y esta asignada o pendiente de su VoBo puede editar
    if (tipoAsignacion == 1 && (estatusDenuncia == 2 || estatusDenuncia == 3)) {
        return 0;
    }

    //Si es delegado y esta asignada si puede editar
    if (tipoAsignacion == 2 && estatusDenuncia == 2) {
        return 0;
    }

    //Si es Revisor y esta pendiente de revision si puede editar
    if (tipoAsignacion == 3 && estatusDenuncia == 5) {
        return 0;
    }

    return 1;
}

function guardarInvolucrados() {

    $("#tableInv2 table tbody tr").each(function () {
        var idInvolucrado = $(this).find("td:first").html();
        var nombre = $(this).find("td:nth-child(2)").html();
        var puesto = $(this).find("td:nth-child(3)").html();
        var tipo = $(this).find("td:nth-child(4) select").val();
        var fechaIngreso = $(this).find("td:nth-child(5) input").val();
        var acciones = $(this).find("td:nth-child(6) select").val();
        var fechaCompromiso = $(this).find("td:nth-child(7) input").val()

        saveInvolucradoEnvio(idInvolucrado, nombre, puesto, tipo, fechaIngreso, acciones, fechaCompromiso);

    });

}

function guardarEntrevistados() {
    
    $("#tableEnt table tbody tr").each(function () {
        var idEntrevistado = $(this).find("td:first").html();
        var nombre = $(this).find("td:nth-child(2) input").val();
        var puesto = $(this).find("td:nth-child(3) input").val();
        var entrevistado = $(this).find("td:nth-child(4) input").val();

        saveEntrevistadoEnvio(idEntrevistado, nombre, puesto, entrevistado);
        
    });
}

function guardarTema() {

    var denuncia = $('#contenido_txtFolio').val();
    var idTema = $('#contenido_mTxtIdTema').val();
    var tema = $('#contenido_mTxtTema').val();
    //var subtema = $('#contenido_mTxtSubTema').val();
    var asunto = $('#contenido_mTxtAsunto').val();
    var actividades = $('#contenido_mTxtActividades').val();
    var detalleActividades = $('#contenido_mTxtDetalle').val();
    var planAccion = $('#contenido_mTxtPlan').val();
    var conclusiones = $('#contenido_mTxtConclusiones').val();
    var resultado = $('#contenido_resultadoDDL').val();
    var beneficio = $('#contenido_beneficioDDL').val();

    var usuarioAlta = idUsuario;

    $.ajax({
        type: "POST",
        url: 'Detalle.aspx/saveTema',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': denuncia, 'idTema': idTema, 'tema': tema, 'asunto': asunto, 'actividades': actividades, 'detalleActividades': detalleActividades, 'planAccion': planAccion, 'conclusiones': conclusiones, 'resultado': resultado, 'beneficio': beneficio, 'usuarioAlta': usuarioAlta }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //$("#divResult").html("success");
            var objdata = $.parseJSON(data.d);
            //console.log(objdata);

            $('#tableTema table tbody tr').remove();
            cargarTemas();


        },
        error: function (e) {
            console.log(e);
        }
    });
}

