<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DenunciaDetallada.aspx.cs" Inherits="Portal_Investigadores.DenunciaDetallada" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="menu" runat="server">
</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/fontawesome.css" integrity="sha256-YC896To53D/eet6K3jAwOq67iCIK24u2Hg6CQ+026I8=" crossorigin="anonymous" />--%>
        <link href="css/especiales.css" rel="stylesheet" />
        <script src="scripts/denunciaDetallada.js"></script>
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

            $(document).ready(function () {
                tagsTable = JSON.parse($("#contenido_tagsJS").val());

                $("#contenido_txtComentarioRechazo").on('keyup blur', function () {
                    $('#confirmarRechazo').prop('disabled', this.value == "" ? true : false);
                });

                cargarInvolucradosDenuncia();
                cargarDenunciasAsociadas();
                cargarDocumentos();
                cargarInvolucradosInvestigacion();
                cargarEntrevistados();
                cargarTemas();

                //$("#contenido_txtDenuncia").autoResize();

                //$('#contenido_txtDenuncia').on('keyup keypress', function () {
                //    $(this).height(0);
                //    $(this).height(this.scrollHeight);
                //});

                //$(".ajax-save").hide();

                $(".btn-collapse").click(function () {
                    var textarea = $('#contenido_txtDisplayComentario');
                    textarea.scrollTop(textarea[0].scrollHeight);
                    //console.log(textarea[0].scrollHeight);
                });

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

        </script>
        
        <style type="text/css">
            .lblArea {
                white-space: pre-wrap;
                height:auto;
            }

            @media print {
                .hidden-print {
                display: none !important;
                }
            }
            .btn-collapse:hover {
                color: #4E8ABE;
                /*color: #efaa28;*/
                font-weight: bold;
            }

            .btn-collapse {
                cursor:auto!important;
            }
            .com {
                min-height: 38px;
            }
        </style>


        <style type="text/css" media="print">
             @page 
            {
                /*size:  ;*/   /* auto is the initial value */
                margin:10mm;  /* this affects the margin in the printer settings */
            }
        </style>

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
            

            <div class="accordion" id="accordionExample" style="margin-top: 15px;">
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingOne">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                        <button class="btn btn-collapse" type="button" data-toggle="" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            <% row = tags.Select("id = '21'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Reporte de la Denuncia--%>
                        </button>
                        </h2>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"> <%--data-parent="#accordionExample"--%>
                        <div class="card-body">
                            <form >
                                <div class="form-row">
                                    <div class="form-group col-md-2 ">
                                        <label for="inputFolio"> <% row = tags.Select("id = '22'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Folio--%></label>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtFolio" />
                                    </div>

                                    <div class="form-group col-md-10">
                                        <label for="inputTitulo"><% row = tags.Select("id = '23'");  if (row.Length > 0){Response.Write(row[0][1]);} %><%--Titulo--%></label>
                                        <asp:Label runat="server" ReadOnly="true" CssClass="form-control" ID="txtTitulo"  />
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
                                                <button class="btn  btn-collapse" type="button"  data-target="#collapseInv" aria-expanded="false" aria-controls="collapseInv">
                                                    <% row = tags.Select("id = '30'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Involucrados--%>
                                                </button>
                                            </h2>
                                            
                                        </div>

                                        <div id="collapseInv" class="" aria-labelledby="headingInv" >
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
                                                            <%--<tr>
                                                                <td class="pt-3-half" contenteditable="true">Antonio Reynoso Ornelas</td>
                                                                <td class="pt-3-half" contenteditable="true">Jefe de Credito y Cobranza</td>
                                                                <td class="pt-3-half" contenteditable="true">Empleado</td>
                                                            </tr>--%>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                

                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '34'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Resumen--%></label>
                                    <asp:Label runat="server" ReadOnly="true" CssClass="form-control lblArea" ID="txtResumen"/>
                                </div>

                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '35'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Denuncia--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <%--<asp:TextBox runat="server" ReadOnly="true" CssClass="form-control-plainText" ID="txtDenuncia" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>--%>
                                    <asp:Label runat="server" ReadOnly="true" CssClass="form-control lblArea" ID="txtDenuncia" />
                                    
                                </div>
                                
                                <%--Accordion de Asociadas--%>
                                <div class="accordion" id="accordionAsoc" style="margin-top: 15px;">
                                    <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingAsoc">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button class="btn btn-collapse" type="button" data-toggle="" data-target="#collapseAsoc" aria-expanded="false" aria-controls="collapseAsoc">
                                                    <% row = tags.Select("id = '36'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Casos Asociados--%>
                                                </button>
                                            </h2>
                                            
                                        </div>

                                        <div id="collapseAsoc" class="" aria-labelledby="headingAsoc" >
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
                                                <button class="btn btn-collapse" type="button" data-toggle="collapse" data-target="#collapseDocs" aria-expanded="false" aria-controls="collapseDocs">
                                                    <% row = tags.Select("id = '38'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Documentos--%>
                                                </button>
                                            </h2>
                                            
                                        </div>

                                        <div id="collapseDocs" class="" aria-labelledby="headingDocs" >
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

                                    </div>
                                </div>

                                
                            </form>
                        </div>
                    </div>
                </div>
                <p style="page-break-after: always;">&nbsp;</p>
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingTwo">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                            <button class="btn  collapsed btn-collapse" type="button"  aria-expanded="false" aria-controls="collapseTwo">
                                <% row = tags.Select("id = '40'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Investigación--%>
                            </button>
                        </h2>
                        
                    </div>                    
                    <div id="collapseTwo" class="" aria-labelledby="headingTwo"> <%--data-parent="#accordionExample"--%>
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
                            <div id="accordionTema" style="margin-top: 15px;"></div>
                            
                            <%--Acordion Involucrados2--%>
                            <div class="accordion" id="accordionInv2" style="margin-top: 15px;">
                                <div class="card" style="overflow: auto;">
                                    <div class="card-header cardheader-detalle" id="headingInv2">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button class="btn btn-collapse"  type="button" aria-expanded="false" aria-controls="collapseInv2">
                                                <% row = tags.Select("id = '30'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Involucrados--%>
                                            </button>
                                        </h2>
                                        
                                    </div>

                                    <div id="collapseInv2" class="" aria-labelledby="headingInv2" >
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
                                            <button class="btn  btn-collapse" type="button" aria-expanded="false" aria-controls="collapseEnt">
                                                <% row = tags.Select("id = '62'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Entrevistados--%>
                                            </button>
                                        </h2>
                                        
                                    </div>

                                    <div id="collapseEnt" aria-labelledby="headingEnt">
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
                                <label for="inputResumen"><% row = tags.Select("id = '64'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Conclusión General--%></label>
                                <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                <asp:Label runat="server" CssClass="form-control lblArea" ID="txtConclusion" ReadOnly="true"/>
                            </div>

                            <div class="form-group" style="margin-top:15px;">
                                <label for="inputResumen"><% row = tags.Select("id = '65'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Comentarios--%></label>
                                <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                <asp:Label runat="server" CssClass="form-control lblArea com" ID="txtDisplayComentario" ReadOnly="true"/>
                               
                            </div>

                            <div class="form-row hidden-print">
                                <div class="form-group col-md-2 ml-auto" id="Div1" runat="server" >
                                    <button type="button" class="btn btn-secondary hidden-print" onclick="location.href='BuscadorDenuncias.aspx';" > <% row = tags.Select("id = '67'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
                                </div>
                                <div class="form-group col-md-2" id="Div3" runat="server" >
                                    <button type="button" class="btn btn-primary hidden-print" onclick="window.print();" > <% row = tags.Select("id = '118'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
                                </div>
                            </div>

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
