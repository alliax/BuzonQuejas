
function cargarModal(row) {

    var rowData = row.parentNode.parentNode;
    var idDenuncia = rowData.cells[0].firstChild.data;
   
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

   
});

function cargarInvolucradosDenuncia() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'DenunciaDetallada.aspx/CargarInvolucradosDenuncia',
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
    
    $.ajax({
        type: "POST",
        url: 'DenunciaDetallada.aspx/CargarInvolucradosInvestigacion',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

            $('#collapseInv2 .tblinvolucrados tbody ').empty();

            var objdata = $.parseJSON(data.d);

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

                    const newTr = `<tr `+(heredado == "1" ? `style= "background-color: rgba(202, 227, 235 );"` : ``)+` >
                                    <td class="pt-3-half" contenteditable="false" style="display:none;">` + idInvolucrado + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + nombre + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + puesto + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + tipo + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + fechaIngreso + `</td>
                                    <td class="pt-3-half" contenteditable="false">` + idAccion + `</td>`
                        + `         <td class="pt-3-half" contenteditable="false">` + fechaCompromiso + `</td>`
                        + `</tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableInv2 tbody').append(newTr);
                    }

                    if (editable == "true") {
                        $(".fechaIngreso").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true });
                        $(".fechaCompromiso").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true });
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

function cargarDenunciasAsociadas() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'DenunciaDetallada.aspx/CargarDenunciasAsociadas',
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
                                        <td class="pt-3-half" contenteditable="false">` + id + `</a></td>
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

function cargarDocumentos() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'DenunciaDetallada.aspx/CargarDocumentos',
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
                                        <td class="pt-3-half" contenteditable="false"><a href="http://140.140.91.31/buzon/` + liga + `" target="_blank" >` + nombre + `</a></td>
                                        
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

function cargarEntrevistados() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'DenunciaDetallada.aspx/CargarEntrevistados',
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
                                        <td class="pt-3-half" contenteditable="false">`+ nombre + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ puesto + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ entrevistador + `</td>
                                    </tr>`;

                    if ($tableID.find('tbody').length > 0) {

                        $('#tableEnt tbody').append(newTr);
                    }

                }
            } else {
                $('#tableEnt').hide();
                $('#collapseEnt .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 117; })[0].tag + '</p>'); 
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
}

function cargarTemas() {

    var idDenuncia = $('#contenido_txtFolio').val();

    $.ajax({
        type: "POST",
        url: 'DenunciaDetallada.aspx/CargarTemasDetallado',
        // data: {'idDenuncia: ' + idDenuncia },
        data: JSON.stringify({ 'idDenuncia': idDenuncia }),
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
                    var tema = objdata.PR_TemaInvestigacion[i]["1"];
                    var subtema = objdata.PR_TemaInvestigacion[i]["2"];
                    var asunto = objdata.PR_TemaInvestigacion[i]["3"];
                    var actividades = objdata.PR_TemaInvestigacion[i]["4"];
                    var detalleActividades = objdata.PR_TemaInvestigacion[i]["5"];
                    var planAccion = objdata.PR_TemaInvestigacion[i]["6"];
                    var conclusiones = objdata.PR_TemaInvestigacion[i]["7"];
                    var resultado = objdata.PR_TemaInvestigacion[i]["8"];
                    var beneficio = objdata.PR_TemaInvestigacion[i]["9"];

                    const $tableID = $('#accordionTema');

                    //' + tagsTable.filter(function (tag) { return tag.id == 90; })[0].tag +'
                     //<div class="form-row">
                                                        //    <div class="form-group col-md-12">
                                                        //        <label for="inputFolio">` + tagsTable.filter(function (tag) { return tag.id == 45; })[0].tag +` </label>
                                                        //        <input type="text" class="form-control" ID="mTxtTema" MaxLength="100" Value= "`+ tema + `" >
                                                        //     </div>
                                                        //</div>

                    const newTr = `  <div class="accordion" style="margin-top: 5px;">
                                     <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingTema">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button class="btn  btn-collapse" type="button" data-target="#collapseTema" aria-expanded="false" aria-controls="collapseTema">
                                                    ` + tagsTable.filter(function (tag) { return tag.id == 45; })[0].tag + " "+ (i+1) +" : " + tema +`
                                                            </button>
                                            </h2>

                                        </div>

                                        <div id="collapseTema" class="" aria-labelledby="headingTema">
                                            <div class="card-body" >
                                                <div id="tableTema" class="table-editable">
                                                    <form>
                                                       

                                                        <div class="form-row">
                                                            <div class="form-group col-md-12">
                                                                <label for="inputGrupo"> ` + tagsTable.filter(function (tag) { return tag.id == 46; })[0].tag + ` </label>
                                                                <input type="text" class="form-control" ID="mTxtAsunto" MaxLength="100" Value= "`+ asunto + `" >
                                                            </div>
                                                        </div>

                                                        <div class="form-row">
                                                            <div class="form-group col-md-12">
                                                                <label for="inputEmpresa"> ` + tagsTable.filter(function (tag) { return tag.id == 47; })[0].tag + ` </label>
                                                                <label class="form-control lblArea"  style="font-weight: 400"> ` + actividades +`</label>
                                                            </div>
                                                        </div>
                                        
                                                        <div class="form-row">
                                                            <div class="form-group col-md-12">
                                                                <label for="inputSitio"> ` + tagsTable.filter(function (tag) { return tag.id == 48; })[0].tag + ` </label>
                                                                <label class="form-control lblArea" style="font-weight: 400"> ` + detalleActividades + `</label>
                                                            </div>
                                                        </div>

                                                        <div class="form-row">
                                                            <div class="form-group col-md-6">
                                                                <label for="inputSitio"> ` + tagsTable.filter(function (tag) { return tag.id == 49; })[0].tag + ` </label>
                                                                <label class="form-control lblArea" style="font-weight: 400"> ` + planAccion + `</label>
                                                            </div>

                                                            <div class="form-group col-md-6">
                                                                <label for="inputSitio"> ` + tagsTable.filter(function (tag) { return tag.id == 50; })[0].tag + ` </label>
                                                                <label class="form-control lblArea" style="font-weight: 400"> ` + conclusiones + `</label>
                                                            </div>
                                                        </div>

                                                         <div class="form-row">
                                                            <div class="form-group col-md-6">
                                                                <label for="inputSitio"> ` + tagsTable.filter(function (tag) { return tag.id == 51; })[0].tag + ` </label>
                                                                <label class="form-control lblArea" style="font-weight: 400"> ` + resultado + `</label>
                                                            </div>

                                                            <div class="form-group col-md-6">
                                                                <label for="inputSitio"> ` + tagsTable.filter(function (tag) { return tag.id == 52; })[0].tag + ` </label>
                                                                <label class="form-control lblArea" style="font-weight: 400"> ` + beneficio + `</label>
                                                            </div>
                                                        </div>

                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </div>`;

                    //if ($tableID.find().length > 0) {

                    $('#accordionTema').append(newTr);
                    //}

                }
            }

        },
        error: function (e) {
            console.log(e);
        }
    });
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




