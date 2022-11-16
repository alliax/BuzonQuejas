<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DetalleLite.aspx.cs" Inherits="Portal_Investigadores.DetalleLite" %>
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
        <style>
            .btn-collapse:hover {
                color: #4E8ABE;
                /*color: #efaa28;*/
                font-weight: bold;
            }

            .btn-collapse {
                cursor:auto!important;
            }
            .lblArea {
                white-space: pre-wrap;
                height:auto;
            }
        </style>

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

                cargarInvolucradosInvestigacionLite();
                cargarTemasLite();
                addInvolucrados();
               
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
                        <button class="btn btn-collapse" type="button" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">  <%--data-toggle="collapse"--%>
                            <% row = tags.Select("id = '21'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Reporte de la Denuncia--%>
                        </button>
                        </h2>
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
                                        <label for="inputSitio"><% row = tags.Select("id = '26'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Sitio--%></label>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSitio" />
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputResumen"><% row = tags.Select("id = '35'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Denuncia--%></label>
                                    <asp:Label runat="server" ReadOnly="true" CssClass="form-control lblArea" ID="txtDenuncia" oncopy="return false" onpaste="return false"/>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingTwo">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                            <button class="btn collapsed btn-collapse" type="button"  data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> <%--data-toggle="collapse"--%>
                                <% row = tags.Select("id = '40'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Investigación--%>
                            </button>
                        </h2>
                        <%--<img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseTwo"/>--%>
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

                                <%--<div class="form-group col-md-2" style="margin-top:32.19px;">
                                    <button type="button" runat="server" id="btnDelegar" class="btn btn-primary" onclick="return DelegarDenuncia()"><% row = tags.Select("id = '43'");  if (row.Length > 0){Response.Write(row[0][1]);}  Delegar</button> --%>
                                <%--</div>--%>
                            </div>   

                            <%--Acordion Temas--%>
                            <div class="accordion" id="accordionTema" style="margin-top: 15px;">
                                <div class="card">
                                    <div class="card-header cardheader-detalle" id="headingTema">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button class="btn btn-collapse" type="button" data-toggle="" data-target="#collapseTema" aria-expanded="false" aria-controls="collapseTema">
                                                <% row = tags.Select("id = '44'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Análisis--%>
                                            </button>
                                        </h2>
                                        
                                    </div>

                                    <div id="collapseTema" class="" aria-labelledby="headingTema">
                                        <div class="card-body" >
                                            <div id="tableTema" class="table-editable">
                                                
                                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-left"><% row = tags.Select("id = '47'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Tema Investigado--%></th>
                                                            <%--<th class="text-left">Sub Tema</th>--%>
                                                            <th class="text-left"><% row = tags.Select("id = '49'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Asunto Investigado--%></th>
                                                            <%--<th class="text-left">Acitividad</th>
                                                            <th class="text-left">Detalle de la Actividad</th>--%>
                                                            <%--<th class="text-left">Plan de Acción</th>--%>
                                                            <th class="text-left"><% row = tags.Select("id = '50'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Conclusiones--%></th>
                                                            <th class="text-left"><% row = tags.Select("id = '51'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Resultado--%></th>
                                                            
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
                                            <button class="btn btn-collapse"  type="button" data-toggle="" data-target="#collapseInv2" aria-expanded="false" aria-controls="collapseInv2">
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
                                                            <th class="text-left"><% row = tags.Select("id = '60'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Acciones--%></th>
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
                                <asp:Label runat="server" CssClass="form-control lblArea" ID="txtConclusion"/>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-2 ml-auto" id="Div1" runat="server" >
                                    <button type="button" class="btn btn-secondary" onclick="location.href='Dashboard.aspx';" > <% row = tags.Select("id = '67'");  if (row.Length > 0){Response.Write(row[0][1]);} %> <%--Regresar--%></button>
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
