<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DetalleQuejas.aspx.cs" Inherits="Seguimiento_Web.DetalleMensaje" %>


<%----------------------------------------------------------------------Content----------------------------------------------------------------%>
 <asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <script src="scripts/events.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

        <script type="text/javascript">
            var idUsuario = '<%= Session["idUsuario"] %>';
            var nombreUsuario = '<%= Session["nomUsuario"] %>';
            var estatusDenuncia = '<%= Session["estatusDenuncia"] %>';
            var tipoAsignacion = '<%= Session["tipoAsignacion"] %>';
            var idioma = '<%= Session["idioma"] %>';
            var tagsTable;

            window.onunload = refreshParent;

            function refreshParent() {
                window.opener.location.reload();
            }

            $(document).ready(function () {
                var idQueja = sessionStorage.getItem("sIdQueja");               
                tagsTable = JSON.parse($("#contenido_tagsJS").val());

                $("#contenido_txtComentarioRechazo").on('keyup blur', function () {
                    $('#confirmarRechazo').prop('disabled', this.value == "" ? true : false);
                });

                setValues(idQueja)
                //cargarInvolucradosDenuncia();
                //cargarDenunciasAsociadas();
                //cargarDocumentos();
                //cargarInvolucradosInvestigacion();
                //cargarEntrevistados();
                //cargarTemas();

                //addInvolucrados();
                //addEntrevistados();
                //addTemas();
                //deleteSoporte();
                //cargarDenunciasAntecedentes();

                $(".btn-collapse").click(function () {
                    var textarea = $('#contenido_txtDisplayComentario');
                    textarea.scrollTop(textarea[0].scrollHeight);
                });

                var readOnlyActivado = validarReadOnly();

                if (readOnlyActivado == 1) {
                    activarReadOnly();
                }

                $('#modalSoporte').on('show.bs.modal', function () {
                    $("#modalDetail").css('opacity', 0);
                });

                $('#modalSoporte').on('hidden.bs.modal', function () {
                    $("#modalDetail").css('opacity', 1);
                    $('body').addClass('modal-open');
                });


            });

            function setValues(idQueja) {
                $.ajax({
                    type: "GET",
                    url: "DetalleQuejas.aspx/BQ_DetalleMensaje",
                    data: $.param({ iIdQueja:idQueja }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        Json = createJson(r);
                        $('#<%= txtMsg.ClientID %>').val(Json[0].IdMensaje); 
                        $('#<%= txtTitulo.ClientID %>').val(Json[0].Titulo);
                        $('#<%= txtGrupo.ClientID %>').val(Json[0].Grupo);
                        $('#<%= txtEmpresa.ClientID %>').val(Json[0].Empresa);
                        $('#<%= txtSitio.ClientID %>').val(Json[0].Sitio);
                        $('#<%= txtTema.ClientID %>').val(Json[0].Tema);
                        $('#<%= txtResumen.ClientID %>').val(Json[0].Resumen);
                        $('#<%= txtMensaje.ClientID %>').val(Json[0].Mensaje);
                        $('#<%= txtSubtema.ClientID %>').val(Json[0].Subtema);
                        $('#<%= txtDepartamento.ClientID %>').val(Json[0].Departamento);

                        $('#tblQ').html("");
                        if (idioma == 1) {
                            $("#tblQ").append("<tr><th>IdQueja</th><th>Titulo</th></tr>")
                        }
                        else {
                            $("#tblQ").append("<tr><th>Complain Id</th><th>Title</th></tr>")
                        }
                        $('#tblQ').append('<tr>' + '<td>' + Json[0].IdQueja + '</td>' + '<td>' + Json[0].QuejaTitulo + '</td></tr>');
                    },
                    error: function (r) {
                        alert("Error System");
                    }
                });
            }
            function createJson(strJson) {
                var strJson = JSON.stringify(strJson);
                var iJsonLenght = strJson.length
                strJson = strJson.substr(5, iJsonLenght);
                strJson = strJson.slice(0, -1)
                var Json = JSON.parse(strJson);
                Json = JSON.parse(Json);

                return Json;
            }//End Function

            function hideMenu() {
                $("#menu_menuNavbar").hide();
                $("#menu_menuLine").hide();
                $("#collapseOne").removeClass("show");
                $("#collapseTwo").addClass("show");
                $("#contenido_Div1").hide();
                //alert(tipoLectura);
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
            

            <div class="accordion" id="accordionExample" style="margin-top: 15px;">
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingOne">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                        <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            Mensajes
                        </button>
                        </h2>
                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseOne"/>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"> <%--data-parent="#accordionExample"--%>
                        <div class="card-body">
                            <form>
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <label for="inputFolio">Id Mensaje</label>

                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtMsg" />
                                    </div>

                                    <div class="form-group col-md-10">
                                        <label for="inputTitulo">Titulo</label>
                                        <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTitulo"  />
                                    </div>
                                </div>
                                    
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <label for="inputGrupo">Grupo</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtGrupo" />
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label for="inputEmpresa">Empresa</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtEmpresa" />
                                    </div>

                                     <div class="form-group col-md-3">
                                        <label for="inputSitio">Sitio</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSitio" />
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label for="inputDepartamento">Departamento</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtDepartamento"  />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label for="inputTema">Tema</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTema" />
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="inputTema">SubTema</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSubtema" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '34'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Resumen--%></label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtResumen" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>
                                </div>
                                <div class="form-group">
                                    <label for="inputResumen">Mensaje</label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtMensaje" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>
                                </div>
                                <%--Accordion de Asociadas--%>
                                <div class="accordion" id="accordionAsoc" style="margin-top: 15px;">
                                    <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingAsoc">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseAsoc" aria-expanded="false" aria-controls="collapseAsoc">
                                                   Casos Asociados
                                                </button>
                                            </h2>
                                            <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseAsoc"/>
                                        </div>

                                        <div id="collapseAsoc" class="collapse" aria-labelledby="headingAsoc" >
                                            <div class="card-body">
                                                <div id="tableAsoc" class="table-editable">
                                                    <%--<span class="table-add float-right mb-3 mr-2 card-add"><a href="#!" style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>--%>
                                                    <table id="tblQ" class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                    
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

                                <%--<asp:button runat="server" autopostback="true" cssclass="dropdown-item" onclick="DelegarDenuncia" id="Button1" text="Angel Francisco Vela de la Garza Evia   "></asp:button>--%>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card">
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

                                <div class="form-group col-md-2" style="margin-top:32.19px;">
                                    <button type="button" runat="server" id="btnDelegar" class="btn btn-primary" onclick="return DelegarDenuncia()"><% row = tags.Select("id = '43'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Delegar--%></button>
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
                                                <span class="float-right mb-3 mr-2 card-add " data-target=".bd-example-modal-xl"><a id="addTemaPlus" OnClick="return cargarModalTema(0);" title="Añadir un Nuevo Tema" data-toggle="modal" style="font-size:30px; font-weight:bold; text-decoration:none;"  data-target=".bd-example-modal-xl" class="text-success openModal">+</a></span>
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
                                                            <th class="text-left"></th>
                                                      </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%--<tr>--%>

                                                            <%--<asp:LinkButton runat="server" CssClass="btn-detail openModal" Text="Detalle" data-toggle="modal" data-target=".bd-example-modal-xl" OnClientClick="return cargarModal(this);" />--%>

                                                            <%--<td runat="server" class="pt-3-half openModal" data-toggle="modal" data-target=".bd-example-modal-xl" OnClick="return cargarModal(this);" contenteditable="true">Jornadas Laborales Extensas</td>
                                                            <td class="pt-3-half" contenteditable="true">Jornadas Laborales Extensas</td>
                                                            <td class="pt-3-half" contenteditable="true">Se denuncian Jornadas extensas y entrega de pedidos extra una vez finalizadas las actividades del día</td>--%>
                                                            <%--<td class="pt-3-half" contenteditable="true">Se denuncian Jornadas extensas y entrega de pedidos extra una, e denuncian Jornadas extensas y entrega de pedidos extra una, e denuncian Jornadas extensas y entrega de pedidos extra una, e denuncian Jornadas extensas y entrega de pedidos extra una, e denuncian Jornadas extensas y entrega de pedidos extra una, e denuncian Jornadas extensas y entrega de pedidos extra una, e denuncian Jornadas extensas y entrega de pedidos extra una</td>
                                                            <td class="pt-3-half" contenteditable="true">Se pedira apoyo para una posicion nueva que se encuentre en flujo con Gerardo Carcoba</td>--%>
                                                            <%--<td class="pt-3-half" contenteditable="true">Se pide apoyo para una posición nueva que ayude aligerar las cargas</td>
                                                            <td class="pt-3-half" contenteditable="true">Verdadera</td>
                                                            <td class="pt-3-half" contenteditable="true">Verdadera</td>
                                                            <td>
                                                              <span class="table-remove"><button type="button"
                                                                  class="btn btn-danger btn-rounded btn-sm my-0">-</button></span>
                                                            </td>
                                                        </tr>--%>
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
                                                <span class="table-addInv float-right mb-3 mr-2 card-add"><a href="#!" id="addInvolucradosPlus" title="Añadir un nuevo Involucrado" style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>
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
                                                <span class="table-addEnt float-right mb-3 mr-2 card-add"><a href="#!" id="addEntrevistadoPlus" title="Añadir un nuevo Entrevistado"  style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>
                                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-left" style="display:none;">id</th>
                                                            <th class="text-left"><% row = tags.Select("id = '58'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Nombre Completo--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '33'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Puesto--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '63'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Entrevistado por--%>:</th>
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

                            
                            <div class="form-group" style="margin-top:15px;">
                                <label for="inputResumen"><% row = tags.Select("id = '64'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Conclusión General--%>*</label>
                                <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtConclusion" textMode="MultiLine" Rows="4"/>
                            </div>

                            <div class="form-group" style="margin-top:15px;">
                                <label for="inputResumen"><% row = tags.Select("id = '65'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Comentarios--%></label>
                                <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtDisplayComentario" textMode="MultiLine" Rows="5" ReadOnly="true"/>
                                
                                <div class="form-row" style="margin-top:5px;">
                                    <div class="form-group col-md-10" >
                                        <asp:TextBox runat="server" AutoPostBack="false" CssClass="form-control" onkeydown = "return (event.keyCode!=13);" ID="txtComentario" Placeholder="Escribe un comentario/Write a comment..."/>
                                        
                                    </div>
                                    <div class="form-group col-md-2 " >
                                        <button type="button" id="txtComentarioInv" class="btn btn-info" onclick="return saveComentario()"><% row = tags.Select("id = '66'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Comentar--%></button>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-2 ml-auto" id="Div1" runat="server" >
                                    <button type="button" class="btn btn-secondary" onclick="location.href='Dashboard.aspx';" > <% row = tags.Select("id = '67'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
                                </div>
                                <div class="form-group col-md-2" id="btnGuardar" visible="false" runat="server" >
                                    <button type="button" class="btn btn-primary" onclick="return saveConclusion()"><% row = tags.Select("id = '68'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Guardar--%></button>
                                </div>
                                <div class="form-group col-md-2 " id="btnVoBo" visible="false" runat="server" >
                                    <button type="button" class="btn btn-success" onclick="return sendVoBo()"><% row = tags.Select("id = '69'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Enviar a VoBo--%></button>
                                </div>
                                <div class="form-group col-md-2 " id="btnRevision" visible="false" runat="server">
                                    <button type="button" class="btn btn-success" onclick="return sendRevision()"><% row = tags.Select("id = '72'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Enviar a Revisión--%></button>
                                </div>
                                <div class="form-group col-md-2 " id="btnAuditoria" visible="false" runat="server">
                                    <button type="button" class="btn btn-success" onclick="return sendAuditoria()"><% row = tags.Select("id = '73'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Enviar a Auditoría--%></button>
                                </div>
                                <div class="form-group col-md-2 " id="btnAceptarOBT" visible="false" runat="server" >
                                    <button type="button" class="btn btn-primary" onclick="sendGerente()" data-toggle="modal"><% row = tags.Select("id = '74'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Aceptar--%></button>
                                </div>
                                <div class="form-group col-md-2 " id="btnAceptar" visible="false" runat="server" >
                                    <button type="button" class="btn btn-primary" onclick="" data-toggle="modal" data-target="#modalMadurez"><% row = tags.Select("id = '74'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Aceptar--%></button>
                                </div>
                                <div class="form-group col-md-2 " id="btnRechazo" visible="false" runat="server" >
                                    <button type="button" class="btn btn-danger" data-target=".bd-example-modal-xl" onclick="return cargarModalRechazo(0);" data-toggle="modal" data-target=".bd-example-modal-xl"><% row = tags.Select("id = '75'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Rechazar--%></button>

                                    <%--<span class="float-right mb-3 mr-2 card-add " data-target=".bd-example-modal-xl"><a OnClick="return cargarModalRechazo(0);" data-toggle="modal" style="font-size:30px; font-weight:bold; text-decoration:none;"  data-target=".bd-example-modal-xl" class="text-success openModal">+</a></span>--%>
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
</asp:Content >
    

