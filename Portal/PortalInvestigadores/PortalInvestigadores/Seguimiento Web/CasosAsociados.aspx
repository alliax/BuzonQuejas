<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CasosAsociados.aspx.cs" Inherits="Seguimiento_Web.CasosAsociados" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="menu" runat="server">
</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/fontawesome.css" integrity="sha256-YC896To53D/eet6K3jAwOq67iCIK24u2Hg6CQ+026I8=" crossorigin="anonymous" />--%>
        <link href="css/especiales.css" rel="stylesheet" />
        <%--<script src="scripts/events.js"></script>--%>
        <%--<script src="scripts/SimpleAjaxUploader.js"></script>--%>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <script type="text/javascript">
            var idUsuario = '<%= Session["idUsuario"] %>';
            var nombreUsuario = '<%= Session["nomUsuario"] %>';
            var estatusDenuncia = '<%= Session["estatusDenuncia"] %>';  
            var idioma = '<%= Session["idioma"] %>'; 
            var tagsTable;

            $(document).ready(function () {
                tagsTable = JSON.parse($("#contenido_tagsJS").val());
                cargarInvolucradosDenuncia();
            });

            function cargarInvolucradosDenuncia() {

                var idDenuncia = $('#contenido_txtFolio').val();

                $.ajax({
                    type: "POST",
                    url: 'Detalle.aspx/CargarInvolucradosDenuncia',
                    // data: {'idDenuncia: ' + idDenuncia },
                    data: JSON.stringify({ 'idDenuncia': idDenuncia, 'idioma': idioma }),
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
                            //$('#collapseInv .card-body').append('<p> No se han dado de alta involucrados</p>');
                            $('#collapseInv .card-body').append('<p>' + tagsTable.filter(function (tag) { return tag.id == 86; })[0].tag + '</p>'); 
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }

            function goBack() {
                window.close();
            }
        </script>
        
        <div class="container">
            <input type="hidden" id="tagsJS" runat="server" />
            <div class="accordion" id="accordionExample" style="margin-top: 15px;">
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingOne">
                        <h2 class="mb-0">
                        <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            <% row = tags.Select("id = '21'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Reporte de la Denuncia--%>
                        </button>
                        </h2>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"> <%--data-parent="#accordionExample"--%>
                        <div class="card-body">
                            <form>
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <label for="inputFolio"><% row = tags.Select("id = '22'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Folio--%></label>
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
                                            <h2 class="mb-0">
                                                <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseInv" aria-expanded="false" aria-controls="collapseInv">
                                                    <% row = tags.Select("id = '30'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Involucrados--%>
                                                </button>
                                            </h2>
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

                                <div class="form-row" style="margin-top: 1rem;">

                                    <div class="form-group col-md-2 ml-auto" id="Div1" runat="server" >
                                        <button type="button"  class="btn btn-primary" onclick="goBack()"><% row = tags.Select("id = '67'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
                                    </div>

                                    <%--<span class="float-right mb-3 mr-2 card-add " data-target=".bd-example-modal-xl"><a OnClick="return cargarModalRechazo(0);" data-toggle="modal" style="font-size:30px; font-weight:bold; text-decoration:none;"  data-target=".bd-example-modal-xl" class="text-success openModal">+</a></span>--%>
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
