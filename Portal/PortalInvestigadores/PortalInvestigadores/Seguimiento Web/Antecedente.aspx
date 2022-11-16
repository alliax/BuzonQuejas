<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Antecedente.aspx.cs" Inherits="Portal_Investigadores.Antecedente" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="menu" runat="server">
</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/fontawesome.css" integrity="sha256-YC896To53D/eet6K3jAwOq67iCIK24u2Hg6CQ+026I8=" crossorigin="anonymous" />--%>
        <link href="css/especiales.css" rel="stylesheet" />
        <script src="scripts/events.js"></script>
        <%--<script src="scripts/SimpleAjaxUploader.js"></script>--%>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

        <%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
        <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>

        <%--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css"/>--%>
        <%--<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>--%>

        <script type="text/javascript">
            var idUsuario = '<%= Session["idUsuario"] %>';
            var nombreUsuario = '<%= Session["nomUsuario"] %>';
            var estatusDenuncia = '<%= Session["estatusDenuncia"] %>';  
            var tipoAsignacion = '<%= Session["tipoAsignacion"] %>';  
           <%-- var tipoLectura = '<%= Session["tipoLectura"] %>';  --%>
            var idioma = '<%= Session["idioma"] %>'; 
            var tagsTable;

            window.onunload = refreshParent;

            function refreshParent() {
                window.opener.location.reload();
            }

            function goBack() {
                window.close();
            }

            $(document).ready(function () {
                tagsTable = JSON.parse($("#contenido_tagsJS").val());

                $("#contenido_txtComentarioRechazo").on('keyup blur', function () {
                    $('#confirmarRechazo').prop('disabled', this.value == "" ? true : false);
                });

                cargarInvolucradosDenuncia();
                cargarDenunciasAsociadasAnt();
                cargarDocumentosAntecedentes();
                cargarInvolucradosInvestigacion();
                cargarEntrevistadosAntecedentes();
                cargarTemasAntecedentes();

                addInvolucrados();
                addEntrevistados();
                addTemas();
                deleteSoporte();

                //$(".ajax-save").hide();

                $(".btn-collapse").click(function () {
                    var textarea = $('#contenido_txtDisplayComentario');
                    textarea.scrollTop(textarea[0].scrollHeight);
                    //console.log(textarea[0].scrollHeight);
                });

                var readOnlyActivado = validarReadOnly();

                if (readOnlyActivado == 1) {
                    activarReadOnly();
                }

                $('#modalSoporte').on('show.bs.modal', function () {
                    //var modalParent = $(this).attr('data-modal-parent');
                    $("#modalDetail").css('opacity', 0);
                });

                $('#modalSoporte').on('hidden.bs.modal', function () {
                    //var modalParent = $(this).attr('data-modal-parent');
                    $("#modalDetail").css('opacity', 1);
                    $('body').addClass('modal-open');
                });

                //var tagsTable = JSON.parse($("#contenido_tagsJS").val());
                
                //console.log(tagsTable.filter(function (tag) { return tag.id == 25; })[0].tag);
                
            });

            function hideMenu() {
                $("#menu_menuNavbar").hide();
                $("#menu_menuLine").hide();
                $("#collapseOne").removeClass("show");
                $("#collapseTwo").addClass("show");
                $("#contenido_Div1").hide();
                //alert(tipoLectura);
            }

            function cargarTemasAntecedentes() {

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

                        $('#accordionTema h2 button ').append(s + " (" + (objdata.Table1.length - 1) + ") ");

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

                                const newTr = `<tr>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">`+ idTema + `</td>
                                        <td class="pt-3-half" contenteditable="true" style="display:none;">`+ completo + `</td>
                                        <td runat="server" class="pt-3-half openModal" data-toggle="modal" data-target=".bd-example-modal-xl" OnClick="return cargarModalTema(`+ idTema + `); " contenteditable="false" style="text-decoration: underline; color: cornflowerblue; cursor: pointer;">` + tema + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ asunto + `</td>
                                        <td class="pt-3-half" contenteditable="false" >`+ conclusiones + `</td>
                                        <td class="pt-3-half" contenteditable="false">`+ resultado + `</td>
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

            function cargarEntrevistadosAntecedentes() {

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
                        $('#accordionEnt h2 button ').append(s + " (" + (objdata.Table1.length - 1) + ") ");

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

            function cargarInvolucradosInvestigacion() {

                var idDenuncia = $('#contenido_txtFolio').val();
                var editable;

                var readOnlyActivado = 1;

                if (readOnlyActivado == 1) {
                    //var readOnly = "false";
                    var editable = "false";
                } else {
                    //var readOnly = "true";
                    var editable = "true";
                }

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

                        $('#accordionInv2 h2 button ').append(s + " (" + (objdata.Table1.length - 1) + ") ");

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

                                if (fechaIngreso === null)
                                    fechaIngreso = "";

                                if (fechaCompromiso === null)
                                    fechaCompromiso = "";

                                const $tableID = $('#tableInv2');

                                //<td class="pt-3-half" contenteditable="true">`+ fechaIngreso + `</td>
                                //<td class="pt-3-half" contenteditable="`+ readOnly + `"><button onclick="event.preventDefault(); popUp('UploadFile.aspx', 1);">subirarchivo</button></td>
                                //<button contenteditable="`+ readOnly + `" onclick="event.preventDefault(); popUp('UploadFile.aspx', 1,` + idInvolucrado +`); ">subirarchivo</button>
                                const newTr = `<tr ` + (heredado == "1" ? `style= "background-color: rgba(202, 227, 235 );"` : ``) + ` >
                                    <td class="pt-3-half" contenteditable="false" style="display:none;">` + idInvolucrado + `</td>
                                    <td class="pt-3-half" contenteditable="` + editable + `">` + nombre + `</td>
                                    <td class="pt-3-half" contenteditable="` + editable + `">` + puesto + `</td>
                                    <td class="pt-3-half" contenteditable="` + editable + `"><select id = "tipo` + i + `" ` + (editable == "false" ? `disabled` : ``) + `></select></td>
                                    <td class="pt-3-half" contenteditable="false"><input type="text" contenteditable="`+ editable + `" style="width: 87px;" class="fechaIngreso" value="` + fechaIngreso + `" ` + (editable == "false" ? (`readOnly`) : (``)) + `></td>
                                    <td class="pt-3-half" contenteditable="` + editable + `"><select id = "accion` + i + `" ` + (editable == "false" ? `disabled` : ``) + `></select></td>`
                                    + `         <td class="pt-3-half" contenteditable="false"><input type="text" style="width: 87px;" class="fechaCompromiso" value="` + fechaCompromiso + `" ` + (editable == "false" ? ("readOnly") : ("")) + `></td>`
                                    + `         <td style="min-width: 94px;">`
                                    + (Soporte > 0 ? `<button title="Ver Soportes/View attachments" contenteditable="` + editable + `" style="width:40px;" class="btn btn-secondary btn-rounded btn-sm my-0 openModal" data-toggle="modal" data-target=".bd-example-modal-xl" onclick="event.preventDefault(); cargarModalSoporte(1,` + idInvolucrado + `); ">ver</button>` : "") + `</td>`
                                    + `</tr>`;

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

            function cargarDenunciasAsociadasAnt() {

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
                                        <td class="pt-3-half" contenteditable="false"><a href="CasosAsociados.aspx?id=`+ id + `&denuncia=` + idDenuncia + `&origen=antecedentes" target="_blank">` + id + `</a></td>
                                        <td class="pt-3-half" contenteditable="false">`+ titulo + `</td>
                                    </tr>`;

                                if ($tableID.find('tbody').length > 0) {

                                    $('#tableAsoc tbody').append(newTr);
                                }
                            }
                        } else {
                            $('#tableAsoc').hide();
                            $('#collapseAsoc .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 89; })[0].tag + '</p>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }

        </script>
        
        <div class="container">
             <input type="hidden" id="tagsJS" runat="server" />
            <div class="ajax-loader" style="display:none;">
                <div class="ajax-loader-cont">
                    <img src="img/ajax-loader.gif"  class="img-responsive" />
                    <p><% row = tags.Select("id = '84'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Procesando--%></p>
                </div>
            </div>
            <div class="ajax-save" style="display:none;">
                <div class="ajax-save-cont">
                    <img src="img/214353.png"  class="img-responsive" />
                    <p><% row = tags.Select("id = '85'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Guardado con Exito--%></p>
                </div>
            </div>
            
            <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTipo" Visible="false" />
            <div class="accordion" id="accordionExample" style="margin-top: 15px;">
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingOne">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                        <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            <% row = tags.Select("id = '21'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Reporte de la Denuncia--%>
                        </button>
                        </h2>
                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseOne"/>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"> <%--data-parent="#accordionExample"--%>
                        <div class="card-body">
                            <form>
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <label for="inputFolio"> <% row = tags.Select("id = '22'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Folio--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtFolio" />
                                    </div>

                                    <div class="form-group col-md-10">
                                        <label for="inputTitulo"><% row = tags.Select("id = '23'");  if (row.Length > 0){Response.Write(row[0][1]);} %><%--Titulo--%></label>
                                        <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTitulo"  />
                                    </div>
                                </div>
                                    
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <label for="inputGrupo"><% row = tags.Select("id = '24'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Grupo--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtGrupo" />
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label for="inputEmpresa"><% row = tags.Select("id = '25'");  if (row.Length > 0){Response.Write(row[0][1]);} %><%--Empresa--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtEmpresa" />
                                    </div>

                                     <div class="form-group col-md-3">
                                        <label for="inputSitio"><% row = tags.Select("id = '26'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Sitio--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSitio" />
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label for="inputDepartamento"><% row = tags.Select("id = '27'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Departamento--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtDepartamento"  />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label for="inputTema"><% row = tags.Select("id = '28'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Tema--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTema" />
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="inputTema"><% row = tags.Select("id = '29'");  if (row.Length > 0){Response.Write(row[0][1]);} %><%--Sub Tema--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSubtema" />
                                    </div>
                                </div>

                                <%--Accordion de Involucrados--%>
                                <div class="accordion" id="accordionInv" style="margin-top: 15px; margin-bottom:15px;">
                                    <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingInv">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseInv" aria-expanded="false" aria-controls="collapseInv">
                                                    <% row = tags.Select("id = '30'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Involucrados--%>
                                                </button>
                                            </h2>
                                            <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseInv"/>
                                        </div>

                                        <div id="collapseInv" class="collapse" aria-labelledby="headingInv" >
                                            <div class="card-body">
                                                <div id="tableInv" class="table-editable">
                                                    <%--<span class="table-add float-right mb-3 mr-2 card-add"><a href="#!" style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>--%>
                                                    <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-left"><% row = tags.Select("id = '31'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Nombre--%></th>
                                                                <th class="text-left"><% row = tags.Select("id = '32'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Tipo--%></th>
                                                                <th class="text-left"><% row = tags.Select("id = '33'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Puesto--%></th>
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
                                

                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '34'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Resumen--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtResumen" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>
                                </div>

                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '35'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Denuncia--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtDenuncia" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>
                                    <div class="form-row">
                                        <label for="inputResumen" class="ml-auto"><% row = tags.Select("id = '70'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Arrastra para agrandar--%></label>
                                    </div>
                                </div>
                                
                                <%--Accordion de Asociadas--%>
                                <div class="accordion" id="accordionAsoc" style="margin-top: 15px;">
                                    <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingAsoc">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseAsoc" aria-expanded="false" aria-controls="collapseAsoc">
                                                    <% row = tags.Select("id = '36'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Casos Asociados--%>
                                                </button>
                                            </h2>
                                            <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseAsoc"/>
                                        </div>

                                        <div id="collapseAsoc" class="collapse" aria-labelledby="headingAsoc" >
                                            <div class="card-body">
                                                <div id="tableAsoc" class="table-editable">
                                                    <%--<span class="table-add float-right mb-3 mr-2 card-add"><a href="#!" style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>--%>
                                                    <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-left"><% row = tags.Select("id = '37'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Id--%></th>
                                                                <th class="text-center"><% row = tags.Select("id = '23'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Título--%></th>
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

                                 <%--Accordion de Documentos--%>
                                <div class="accordion" id="accordionDocs" style="margin-top: 15px;">
                                    <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingDocs">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseDocs" aria-expanded="false" aria-controls="collapseDocs">
                                                    <% 
                                                        if ( txtTipo.Text == "1" ){
                                                            row = tags.Select("id = '122'");  if (row.Length > 0){Response.Write(row[0][1]);}
                                                        }
                                                        else
                                                        {
                                                            row = tags.Select("id = '38'");  if (row.Length > 0){Response.Write(row[0][1]);}
                                                        }
                                                         %> <%--Documentos--%>
                                                </button>
                                            </h2>
                                            <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseDocs"/>
                                        </div>

                                        <div id="collapseDocs" class="collapse" aria-labelledby="headingDocs" >
                                            <div class="card-body">
                                                <div id="tableDocs" class="table-editable">
                                                    <%--<span class="table-add float-right mb-3 mr-2 card-add"><a href="#!" style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>--%>
                                                    <table id="docsDen" class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-left"><% row = tags.Select("id = '39'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Documento--%></th>
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

                                <div class="form-row" style="margin-top: 1rem;">

                                    <div class="form-group col-md-2 ml-auto" id="Div2" runat="server" >
                                        <button type="button" runat="server" id="btnRInv" visible="false" class="btn btn-danger" data-target=".bd-example-modal-xl" onclick="return cargarModalRechazoInv();" data-toggle="modal"> <% row = tags.Select("id = '71'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Reasignar--%></button>

                                    <%--<span class="float-right mb-3 mr-2 card-add " data-target=".bd-example-modal-xl"><a OnClick="return cargarModalRechazo(0);" data-toggle="modal" style="font-size:30px; font-weight:bold; text-decoration:none;"  data-target=".bd-example-modal-xl" class="text-success openModal">+</a></span>--%>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-2 ml-auto" id="Div3" runat="server" >
                                        <button type="button" class="btn btn-secondary" onclick="goBack()" > <% row = tags.Select("id = '67'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
                                    </div>
                                
                                </div>

                                <%--<asp:button runat="server" autopostback="true" cssclass="dropdown-item" onclick="DelegarDenuncia" id="Button1" text="Angel Francisco Vela de la Garza Evia   "></asp:button>--%>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card" id="cardInvestigacion" runat="server">
                    <div class="card-header cardheader-detalle" id="headingTwo">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                            <button class="btn btn-link collapsed btn-collapse" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                <% row = tags.Select("id = '40'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Investigación--%>
                            </button>
                        </h2>
                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseTwo"/>
                    </div>                    
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"> <%--data-parent="#accordionExample"--%>
                        <div class="card-body">
                            <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <label for="inputFolio"><% row = tags.Select("id = '41'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Responsable--%></label>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtResponsable" />
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="inputFolio"><% row = tags.Select("id = '42'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Delegado--%></label>
                                    <asp:DropDownList ID="delegadoDDL" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <asp:ListItem Text="Selecciona un Delegado" Value="0" />
                                    </asp:DropDownList>
                                </div>

                            </div>   

                            <%--Acordion Temas--%>
                            <div class="accordion" id="accordionTema" style="margin-top: 15px;">
                                <div class="card">
                                    <div class="card-header cardheader-detalle" id="headingTema">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseTema" aria-expanded="false" aria-controls="collapseTema">
                                                <% row = tags.Select("id = '44'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Análisis--%>
                                            </button>
                                        </h2>
                                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseTema"/>
                                    </div>

                                    <div id="collapseTema" class="collapse" aria-labelledby="headingTema">
                                        <div class="card-body" >
                                            <div id="tableTema" class="table-editable">
                                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-left"><% row = tags.Select("id = '45'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Tema Investigado--%></th>
                                                            <%--<th class="text-left">Sub Tema</th>--%>
                                                            <th class="text-left"><% row = tags.Select("id = '46'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Asunto Investigado--%></th>
                                                            <%--<th class="text-left">Acitividad</th>
                                                            <th class="text-left">Detalle de la Actividad</th>--%>
                                                            <%--<th class="text-left">Plan de Acción</th>--%>
                                                            <th class="text-left"><% row = tags.Select("id = '50'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Conclusiones--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '51'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Resultado--%></th>
                                                            
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
                            
                            <%--Acordion Involucrados2--%>
                            <div class="accordion" id="accordionInv2" style="margin-top: 15px;">
                                <div class="card" style="overflow: auto;">
                                    <div class="card-header cardheader-detalle" id="headingInv2">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button class="btn btn-link btn-collapse"  type="button" data-toggle="collapse" data-target="#collapseInv2" aria-expanded="false" aria-controls="collapseInv2">
                                                <% row = tags.Select("id = '30'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Involucrados--%>
                                            </button>
                                        </h2>
                                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseInv2"/>
                                    </div>

                                    <div id="collapseInv2" class="collapse" aria-labelledby="headingInv2" >
                                        <div class="card-body">
                                            <div id="tableInv2" class="table-editable">
                                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-left"><% row = tags.Select("id = '58'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Nombre Completo--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '33'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Puesto--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '32'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Tipo--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '59'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Fecha Ingreso--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '60'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Acciones--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '61'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Fecha Compromiso--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '53'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Soporte--%></th>
                                                                                                                        
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

                            <%--Acordion Entrevistados--%>
                            <div class="accordion" id="accordionEnt" style="margin-top: 15px;">
                                <div class="card">
                                    <div class="card-header cardheader-detalle" id="headingEnt">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseEnt" aria-expanded="false" aria-controls="collapseEnt">
                                                <% row = tags.Select("id = '62'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Entrevistados--%>
                                            </button>
                                        </h2>
                                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseEnt"/>
                                    </div>

                                    <div id="collapseEnt" class="collapse" aria-labelledby="headingEnt">
                                        <div class="card-body">
                                            <div id="tableEnt" class="table-editable">
                                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-left" style="display:none;">id</th>
                                                            <th class="text-left"><% row = tags.Select("id = '58'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Nombre Completo--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '33'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Puesto--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '63'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Entrevistado por--%>:</th>
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

                            
                            <div class="form-group" style="margin-top:15px;">
                                <label for="inputResumen"><% row = tags.Select("id = '64'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Conclusión General--%>*</label>
                                <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtConclusion" textMode="MultiLine" Rows="4"/>
                            </div>

                            <div class="form-group" style="margin-top:15px;">
                                <label for="inputResumen"><% row = tags.Select("id = '65'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Comentarios--%></label>
                                <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtDisplayComentario" textMode="MultiLine" Rows="5" ReadOnly="true"/>
                                
                                
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-2 ml-auto" id="Div1" runat="server" >
                                    <button type="button" class="btn btn-secondary" onclick="goBack()" > <% row = tags.Select("id = '67'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            

            <%--Modal--%>
            <div id="modalDetail" class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" style="display:none"> 
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 id="modalPrincipal-title" class="modal-title"><% row = tags.Select("id = '44'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Análisis--%></h5>
                            <button runat="server" id="closeModal" type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <%--<button runat="server" id="closeModal" type="button" class="close" aria-label="Close">--%>
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body principal">
                            <form>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="inputFolio"><% row = tags.Select("id = '45'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Tema Investigado--%>*</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtIdTema" style="display:none;" />
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtTema" MaxLength="100" />
                                    </div>
                        
                                    <%--<div class="form-group col-md-6">--%>
                                        <%--<label for="inputFolio">Sub Tema*</label>--%>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <%--<asp:TextBox runat="server"  CssClass="form-control" ID="mTxtSubTema" />--%>
                                    <%--</div>--%>
                                    
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="inputGrupo"><% row = tags.Select("id = '46'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Asunto Investigado--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtAsunto" MaxLength="250" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="inputEmpresa"><% row = tags.Select("id = '47'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Actividades de la Investigación--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mTxtActividades" textMode="MultiLine" Rows="2" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="inputSitio"><% row = tags.Select("id = '48'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Detalle de las actividades de Investigación--%></label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtDetalle" textMode="MultiLine" Rows="5" />
                                    </div>
                                </div>

                                <div class="form-row">
                                     <div class="form-group col-md-6">
                                        <label for="inputDepartamento"><% row = tags.Select("id = '49'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Plan de Acción--%>*</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mTxtPlan" textMode="MultiLine" Rows="3"  />
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label for="inputTema"><% row = tags.Select("id = '50'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Conclusiones--%>*</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mTxtConclusiones" textMode="MultiLine" Rows="3"  />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label for="inputTitulo"><% row = tags.Select("id = '51'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Resultado--%>*</label>
                                        <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                        <%--<asp:TextBox runat="server"  CssClass="form-control" ID="mTxtResultado"  />--%>
                                        <asp:DropDownList ID="resultadoDDL" runat="server" CssClass="form-control" AutoPostBack="false">
                                            <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                                        </asp:DropDownList>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="inputResumen"><% row = tags.Select("id = '52'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Beneficio--%>*</label>
                                        <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                        <%--<asp:TextBox runat="server" CssClass="form-control" ID="mTxtBeneficio" />--%>
                                        <asp:DropDownList ID="beneficioDDL" runat="server" CssClass="form-control" AutoPostBack="false">
                                            <%--<asp:ListItem Text="Selecciona un Beneficio" Value="0" />--%>
                                        </asp:DropDownList>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="inputResumen"><% row = tags.Select("id = '53'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Soporte--%></label>
                                        <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                        <%--<input type="file" class="upload"  id="f_UploadImage"><br />--%>
                                        <%--<img id="myUploadedImg" alt="Photo" style="width:180px;" />--%>
                                        <%--<asp:FileUpload ID="fupload" runat="server"  onchange='prvimg.UpdatePreview(this)' />
                                        <asp:Button ID="btnUpload" runat="server" autopostback="false" cssClass="button" Text="Upload Selected File" />--%>
                                         <%--<div id="form1" runat="server">
                                            <input type="file" name="postedFile" />
                                            <input type="button" id="btnUpload" value="Upload" />
                                            <progress id="fileProgress" style="display: none"></progress>
                                         </div>--%>
                                         <%--<a onClick="MyWindow=window.open('UploadFile.aspx','MyWindow','width=600,height=300'); return false;"> <input type="button" value="Subir"/></a>--%>
                                        <div id="SoporteContainer">
                                            <button title="Añadir Soporte" id="btnAddSoporteModal" style="width:49%;"class="btn btn-info btn-rounded btn-sm my-0" onclick="event.preventDefault(); popUp('UploadFile.aspx', 2, 0 ); "><% row = tags.Select("id = '54'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Agregar Soporte--%></button>
                                            <button title="Ver Soportes Agregados" id="btnMSop"style="width:49%;"  disabled="disabled" type="button" class="btn btn-secondary btn-rounded btn-sm my-0 btnVerModalSoporte" data-toggle="modal" data-target="#modalSoporte" onclick="event.preventDefault(); cargarModalSoporte(2,0);"><% row = tags.Select("id = '55'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Ver--%></button>
                                   
                                        </div>
                                         <%--<a href="#myModal2" role="button" class="btn btn-primary" data-toggle="modal">Launch other modal 2</a>--%>
                                        <%--<button style="width:40px;"class="btn btn-secondary btn-rounded btn-sm my-0" data-toggle="modal" data-target="#modalSoporte">ver</button> <%--onclick="event.preventDefault(); cargarModalSoporte(2,3);"--%>

                                        <%--<button onclick="event.preventDefault(); popUp('UploadFile.aspx', 2);">subirarchivo</button>--%>
                                        <%--<button ID="btnHotels" runat="server"  Text="Suggested Hotels" OnClientClick="popUp('UploadFile.aspx')" />--%>

                                        <script>
                                            </script>
                                        
                                    </div>

                                </div>
                                
                            </form>
                               
                        </div>
                        <div class="modal-footer principal">
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="return saveTema()"><% row = tags.Select("id = '56'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Guardar--%></button>
                            <%--<asp:Button runat="server" autopostback="true" OnClick="AceptarDenuncia" CssClass="btn btn-primary" Text="Aceptar"/>--%>
                            <%--<button type="button" class="btn btn-secondary" data-dismiss="modal">Aceptar y Delegar</button>--%>
                            <%--<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="return EsconderDenuncia()">Cancelar</button>--%>
                                
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><% row = tags.Select("id = '57'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Cancelar--%></button>
                        </div>
                        <div class="modal-body rechazo" style="display:none;">
                            <form>
                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '76'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Por favor ingresa el motivo del rechazo--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtComentarioRechazo" textMode="MultiLine" Rows="5"/>
                                </div>
                                <div class="modal-footer ">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal"><% row = tags.Select("id = '57'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Cancelar--%></button>
                                    <button id="confirmarRechazo" type="button" disabled="disabled" class="btn btn-danger" onclick="return sendRechazar()"> <% row = tags.Select("id = '77'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Confirmar--%></button>
                                </div>
                            </form>
                        </div>  
                        <div class="modal-body rechazoInv" style="display:none;">
                            <form>
                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '80'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Por favor ingresa el motivo de la solicitud de reasignación--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtComentarioRechazoInv" textMode="MultiLine" Rows="5"/>
                                </div>
                                <div class="modal-footer ">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal"><% row = tags.Select("id = '57'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Cancelar--%></button>
                                    <button id="confirmarRechazoInv" type="button" disabled="disabled" class="btn btn-danger" onclick="return sendRechazarInv()"><% row = tags.Select("id = '77'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Confirmar--%></button>
                                </div>
                            </form>
                        </div>
                        <div class="modal-body soporte" style="display:none;">
                            <div id="tableSoporte" class="table-editable">
                                
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte" style="width: 50%; margin-left: 24%;">
                                    <thead>
                                        <tr>
                                            <th class="text-left"><% row = tags.Select("id = '78'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Nombre del Archivo--%></th>
                                            <th class="text-left" style="width:85px;"><% row = tags.Select("id = '79'");  if (row.Length > 0){Response.Write(row[0][1]);} %>  <%--Eliminar--%></th>
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

            <div id="modalSoporte" class="modal fade bd-example-modal-xl"  tabindex="-1" data-backdrop-limit="1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" data-modal-parent="#modalDetail">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle"><% row = tags.Select("id = '81'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Archivos Soporte--%></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div id="tableSoporte2" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte" style="width: 50%; margin-left: 24%;">
                                    <thead>
                                        <tr>
                                            <th class="text-left"><% row = tags.Select("id = '78'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Nombre del Archivo--%></th>
                                            <th class="text-left" style="width:85px;"> <% row = tags.Select("id = '79'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Eliminar--%></th>
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

            <div id="modalMadurez" class="modal fade bd-example-modal-xl"  tabindex="-1" data-backdrop-limit="1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleTittle"><% row = tags.Select("id = '82'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Madurez--%></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '83'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Por favor selecciona la madurez final--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <%--<asp:TextBox runat="server" CssClass="form-control" ID="TextBox1" textMode="MultiLine" Rows="5"/>--%>
                                    <asp:DropDownList ID="ddlMadurez" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <asp:ListItem Text="Verdadera" Value="3" />
                                        <asp:ListItem Text="Sin Elementos" Value="1" />
                                        <asp:ListItem Text="Falsa" Value="2" />
                                        <asp:ListItem Text="Selecciona una madurez" Value="0" />
                                    </asp:DropDownList>
                                </div>
                                <div class="modal-footer ">
                                    <button id="confirmarMadurez" type="button"  class="btn btn-primary" onclick="return sendMadurez()"><% row = tags.Select("id = '77'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Confirmar--%></button>  <%--disabled="disabled"--%>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal"><% row = tags.Select("id = '57'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Cancelar--%></button>                                  
                                </div>
                            </form>
                        </div>   
                    </div>
                </div>
            </div>

            <br />
            <br />
            <br />

        </div>
    </form>

    

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">


</asp:Content>
