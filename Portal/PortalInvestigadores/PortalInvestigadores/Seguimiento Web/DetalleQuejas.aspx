<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DetalleQuejas.aspx.cs" Inherits="Seguimiento_Web.DetalleMensaje" %>


<%----------------------------------------------------------------------Content----------------------------------------------------------------%>
 <asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link href="css/especiales.css" rel="stylesheet" />
       <script src="scripts/events.js"></script>
       

<script type="text/javascript">
    var idUsuario = '<%= Session["idUsuario"] %>';
    var nombreUsuario = '<%= Session["nomUsuario"] %>';
    var estatusDenuncia = '<%= Session["estatusDenuncia"] %>';
    var tipoAsignacion = '<%= Session["tipoAsignacion"] %>';
    var idioma = '<%= Session["idioma"] %>';
    var idBQ = '<%= Session["idBQ"] %>';


    $(document).ready(function () {
        var idQueja = sessionStorage.getItem("sIdQueja"); 
        var idRol = sessionStorage.getItem("usrRol");

        setValues(idQueja);
        setLanguage(idioma);
        configRoles(idRol, idBQ,idioma);
        cargarEntrevistadosBQ();
        addEntrevistadosBQ();


        $('#btnEnviarRev').click(function () {
            $.ajax({
                type: "GET",
                /* async: false,*/
                url: "DetalleQuejas.aspx/BQ_Workflow",
                data: $.param({ sOpt: "'" + "EnviarOperador" + "'", iIdQueja: idQueja }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var url = window.location.origin + '/DashboardQuejas.aspx';
                    window.location.replace(url);
                },
                error: function (r) {
                    alert("Error System");
                }
            });

        });

        $('#btnEnviarVobo').click(function () {
            $.ajax({
                type: "GET",
                /* async: false,*/
                url: "DetalleQuejas.aspx/BQ_Workflow",
                data: $.param({ sOpt: "'" + "Workflow" + "'", iIdQueja: idQueja }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var url = window.location.origin + '/DashboardQuejas.aspx';
                    window.location.replace(url);
                },
                error: function (r) {
                    alert("Error System");
                }
            });

        });

        $('#btnEnviar').click(function () {
            $.ajax({
                type: "GET",
                /* async: false,*/
                url: "DetalleQuejas.aspx/BQ_Workflow",
                data: $.param({ sOpt: "'" + "Enviar" + "'", iIdQueja: idQueja }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var url = window.location.origin + '/DashboardQuejas.aspx';
                    window.location.replace(url);
                },
                error: function (r) {
                    alert("Error System");
                }
            });

        });

        $('#btnGuardar').click(function () {
            var txtCon = $("#<%=txtConclusion.ClientID%>").val();

            $.ajax({
                type: "GET",
                /* async: false,*/
                url: "DetalleQuejas.aspx/BQ_Guardar",
                data: $.param({ iIdQueja: idQueja, sConclusion: "'" + txtCon + "'", iIdUsr: idUsuario }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    if (idioma == "2") {
                        $("#usrMsg").html("Information Saved");
                    }
                    else {
                        $("#usrMsg").html("Informacion Guardada Correctamente");
                    }

                    $("#usrMsg").css("visibility", "visible")
                    setTimeout(function () { $("#usrMsg").css("visibility", "hidden") }, 1500);

                            
                },
                error: function (r) {
                    alert("Error System");
                }
            });

        });


        $('#btnSopVer').click(function () {
                var verData = archivosData(idQueja,"Analisis")

            $('#tblSoporte').html("");
            if (idioma == 1) {
                $("#tblSoporte").append("<tr><th>Archivo</th></tr>")
            }
            else {
                $("#tblSoporte").append("<tr><th>File</th></tr>")
            }
            for (i = 0; i <= verData.length - 1; i++) {
                $("#tblSoporte").append('<tr>' + '<td><a href="' + verData[i].Path +'" target="_blank">' + verData[i].Archivo + '</td>' + '</a></tr>');
            }
                  
            $('#modalSoporte').modal('show');
        });
                
        $('#btnSopInvVer').click(function () {
            var verData = archivosData(idQueja, "Involucrados")

            $('#tblSoporte').html("");
            if (idioma == 1) {
                $("#tblSoporte").append("<tr><th>Archivo</th></tr>")
            }
            else {
                $("#tblSoporte").append("<tr><th>File</th></tr>")
            }
            for (i = 0; i <= verData.length - 1; i++) {
                $("#tblSoporte").append('<tr>' + '<td><a href="' + verData[i].Path + '" target="_blank">' + verData[i].Archivo + '</td>' + '</a></tr>');
            }

            $('#modalSoporte').modal('show');

        });


    }); //Document

    function configRoles(idRol,idBQ,idioma) {
        if (idRol == 1) {
            $("#plusInv").css("visibility", "hidden");
            $("#minusInv").css("visibility", "hidden");
            $("#plusAnalisis").css("visibility", "hidden");
            $("#minusAnalisis").css("visibility", "hidden");
            $("#divGuardar").hide();
            $("#divEnviar").hide();
            $("#divDelegar").hide();
            $("#divComentario").hide();
            $("#divRevision").hide();
            $("#plusEntrevistados").css("visibility", "hidden");
            $("#<%=txtConclusion.ClientID%>").prop('disabled', true);

            $.ajax({
                type: "GET",
                async: false,
                url: "DetalleQuejas.aspx/BQ_configVal",
                data: $.param({ iIdBQ: idBQ }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var result = createJson(r);
                    Json = result;
                    if (Json.length == 0) {
                        if (idioma == 2) {
                            $("#btnEnviarVobo").html("Close Complaint");
                        }
                        else {
                            $("#btnEnviarVobo").html("Cerrar Queja");
                        }
                    }
                },
                error: function (r) {
                    alert("Error System");
                }
            });

        }

        if (idRol == 3) {
            $("#divEnviarVobo").hide();
            $("#divRevision").hide();
        }

        if (idRol == 4) {
            $("#plusInv").css("visibility", "hidden");
            $("#minusInv").css("visibility", "hidden");
            $("#plusAnalisis").css("visibility", "hidden");
            $("#minusAnalisis").css("visibility", "hidden");
            $("#divGuardar").hide();
            $("#divEnviar").hide();
            $("#divDelegar").hide();
            $("#divComentario").hide();
            $("#plusEntrevistados").css("visibility", "hidden");
            $("#<%=txtConclusion.ClientID%>").prop('disabled', true);
            $("#divEnviarVobo").hide();

        }

    }

    function archivosData(idQueja, idForm) {
        var Json = [];
        $.ajax({
            type: "GET",
            async: false,
            url: "DetalleQuejas.aspx/BQ_ArchivosAnalisis",
            data: $.param({ iIdQueja: idQueja, sForm: "'" + idForm + "'" }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                var result = createJson(r);
                Json = result;
            },
            error: function (r) {
                alert("Error System");
            }
        });
        return Json;
    }//End Function

    function setLanguage(Idioma) {
        $.ajax({
            type: "GET",
            async: false,
            url: "DetalleQuejas.aspx/BQ_Etiquetas",
            data: $.param({ iId: 4, iIdioma: Idioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
            for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 1) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 2) { $("#lbl2").html(Json[i].Texto) }
                    if (Json[i].Id == 3) { $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 4) { $("#lbl4").html(Json[i].Texto);}
                    if (Json[i].Id == 5) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 6) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 7) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 8) { $("#lbl8").html(Json[i].Texto) }
                    if (Json[i].Id == 9) { $("#lbl9").html(Json[i].Texto) }
                    if (Json[i].Id == 10) { $("#lbl10").html(Json[i].Texto) }
                    if (Json[i].Id == 11) { $("#lbl11").html(Json[i].Texto) }
                    if (Json[i].Id == 12) { $("#lbl12").html(Json[i].Texto) }
                    if (Json[i].Id == 13) { $("#lbl13").html(Json[i].Texto) }
                    if (Json[i].Id == 14) { $("#lbl14").html(Json[i].Texto) }
                    if (Json[i].Id == 15) { $("#lbl15").html(Json[i].Texto) }
                    if (Json[i].Id == 16) { $("#<%=btnDelegar.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 17) { $("#lbl17").html(Json[i].Texto) }
                    if (Json[i].Id == 18) { $("#lbl18").html(Json[i].Texto) }
                    if (Json[i].Id == 19) { $("#lbl19").html(Json[i].Texto) }
                    if (Json[i].Id == 20) { $("#lbl20").html(Json[i].Texto) }
                    if (Json[i].Id == 21) { $("#lbl21").html(Json[i].Texto) }

                    <%--if (Json[i].Id == 21) { $("#<%=btnCom.ClientID%>").val(Json[i].Texto); }--%>
                    if (Json[i].Id == 35) { $("#lbl22").html(Json[i].Texto); }
                    if (Json[i].Id == 23) { $("#lbl23").html(Json[i].Texto); }
                    if (Json[i].Id == 24) { $("#lbl24").html(Json[i].Texto); }
                    if (Json[i].Id == 36) { $("#lbl25").html(Json[i].Texto); }
                    if (Json[i].Id == 25) { $("#lbl26").html(Json[i].Texto); }
                    if (Json[i].Id == 26) { $("#lbl27").html(Json[i].Texto); }
                    if (Json[i].Id == 27) { $("#lbl28").html(Json[i].Texto); }
                    if (Json[i].Id == 28) { $("#lbl29").html(Json[i].Texto); }
                    if (Json[i].Id == 29) { $("#lbl30").html(Json[i].Texto); }
                    if (Json[i].Id == 30) { $("#lbl31").html(Json[i].Texto); }
                    if (Json[i].Id == 31) { $("#btnAddSoporteModal").html(Json[i].Texto); }
                    if (Json[i].Id == 32) { $("#btnMSop").html(Json[i].Texto); }
                    if (Json[i].Id == 33) { $("#<%=btnTemaGuardar.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 34) { $("#<%=btnTemaCancelar.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 36) { $("#lbl32").html(Json[i].Texto); }
                    if (Json[i].Id == 37) { $("#lbl33").html(Json[i].Texto); }
                    if (Json[i].Id == 38) { $("#lbl34").html(Json[i].Texto); }
                    if (Json[i].Id == 39) { $("#lbl35").html(Json[i].Texto); }
                    if (Json[i].Id == 40) { $("#lbl36").html(Json[i].Texto); }
                    if (Json[i].Id == 41) { $("#lbl37").html(Json[i].Texto); }
                    if (Json[i].Id == 33) { $("#<%=btnInvGuardar.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 34) { $("#<%=btnInvCan.ClientID%>").val(Json[i].Texto); }


            }

        },
        error: function (r) {
            alert("Error de Sistema");
        }
        });

    }

    function setValues(idQueja) {
        $.ajax({
            type: "GET",
            async:false,
            url: "DetalleQuejas.aspx/BQ_DetalleMensaje",
            data: $.param({ iIdQueja:idQueja }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                Json = createJson(r);
                $('#<%= txtQueja.ClientID %>').val(Json[0].IdQueja); 
                $('#<%= txtTitulo.ClientID %>').val(Json[0].Titulo);
                $('#<%= txtGrupo.ClientID %>').val(Json[0].Grupo);
                $('#<%= txtEmpresa.ClientID %>').val(Json[0].Empresa);
                $('#<%= txtSitio.ClientID %>').val(Json[0].Sitio);
                $('#<%= txtTema.ClientID %>').val(Json[0].Tema);
                $('#<%= txtResumen.ClientID %>').val(Json[0].Resumen);
                $('#<%= txtMensaje.ClientID %>').val(Json[0].Mensaje);
                $('#<%= txtTema.ClientID %>').val(Json[0].Tema);
                $('#<%= txtSubtema.ClientID %>').val(Json[0].Subtema);
                $('#<%= txtDepartamento.ClientID %>').val(Json[0].Departamento);
                $('#<%= txtConclusion.ClientID %>').val(Json[0].Conclusion);
                configQuejaEstatus(Json[0].Estatus);
            },
            error: function (r) {
                alert("Error System");
            }
        });
    }

    function configQuejaEstatus(idEstatus) {
        if (idEstatus == 3) {
            $("#btnGuardar").prop('disabled', true);
            $("#btnEnviar").prop('disabled', true);
        }
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

    $("#<%=fechaIngreso.ClientID%>").datepicker({dateFormat:"yyyy-MM-dd"});
    $("#<%=fechaCom.ClientID%>").datepicker({dateFormat:"yyyy-MM-dd"});

</script>
        
        <div class="container">
             <input type="hidden" id="tagsJS" runat="server" />
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
            

            <div class="accordion" id="accordionExample" style="margin-top: 15px;">
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingOne">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                        <button id="lbl1" class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
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
                                        <label id="lbl2" for="inputFolio">Id FOLIO</label>

                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtQueja" />
                                    </div>

                                    <div class="form-group col-md-10">
                                        <label for="inputTitulo" id="lbl3" >Titulo</label>
                                        <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTitulo"  />
                                    </div>
                                </div>
                                    
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <label for="inputGrupo" id="lbl4">Grupo</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtGrupo" />
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label for="inputEmpresa" id="lbl5">Empresa</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtEmpresa" />
                                    </div>

                                     <div class="form-group col-md-3">
                                        <label for="inputSitio" id="lbl6">Sitio</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtfolio" placeholder="Folio"/>--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSitio" />
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label for="inputDepartamento" id="lbl7">Departamento</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtDepartamento"  />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label for="inputTema" id="lbl8">Tema</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtTema" />
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="inputTema" id="lbl9">SubTema</label>
                                        <%--<input runat="server" type="text" readonly="true" class="form-control" id="txtGrupo" placeholder="Grupo" />--%>
                                        <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtSubtema" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="inputResumen" id="lbl10">Resumen</label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtResumen" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>
                                </div>
                                <div class="form-group">
                                    <label for="inputResumen" id="lbl11">Mensaje</label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtMensaje" textMode="MultiLine" Rows="5" oncopy="return false" onpaste="return false"/>
                                </div>
                                <%--Accordion de Asociadas--%>
                                <div class="accordion" id="accordionAsoc" style="margin-top: 15px;">
                                    <div class="card">
                                        <div class="card-header cardheader-detalle" id="headingAsoc">
                                            <h2 class="mb-0" style="float: left; width: 94%;">
                                                <button id="lbl12" class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseAsoc" aria-expanded="false" aria-controls="collapseAsoc">
                                                   Casos Asociados
                                                </button>
                                            </h2>
                                            <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseAsoc"/>
                                        </div>

                                        <div id="collapseAsoc" class="collapse" aria-labelledby="headingAsoc" >
                                            <div class="card-body">
                                                <div id="tableAsoc" class="table-editable">
                                                    <%--<span class="table-add float-right mb-3 mr-2 card-add"><a href="#!" style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>--%>
                                                     <asp:GridView runat="server" ID="gvAsociados" CssClass="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row" style="margin-top: 1rem;">

                                    <div class="form-group col-md-2 ml-auto" id="Div2" runat="server" >
                                        <button type="button" runat="server" id="btnRInv" visible="false" class="btn btn-danger" data-target=".bd-example-modal-xl" onclick="return cargarModalRechazoInv();" data-toggle="modal">Reasignar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header cardheader-detalle" id="headingTwo">
                        <h2 class="mb-0" style="float: left; width: 94%;">
                            <button id="lbl13" class="btn btn-link collapsed btn-collapse" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                               Investigación
                            </button>
                        </h2>
                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseTwo"/>
                    </div>                    
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"> <%--data-parent="#accordionExample"--%>
                        <div class="card-body">
                            <div id="divDelegar" class="form-row">
                                 <div class="form-group col-md-4">
                                    <label for="inputFolio" id="lbl14">Responsable</label>
                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="form-control" ID="txtResponsable" />
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="inputFolio" id="lbl15">Delegado</label>
                                    <asp:DropDownList ID="delegadoDDL" runat="server" CssClass="form-control" AutoPostBack="false">
                     
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group col-md-2" style="margin-top:32.19px;">
                                    <asp:Button runat="server" OnClick="btnDelegar_Click"  ID="btnDelegar" CssClass="btn btn-primary" Text="Delegate"/>
                                </div>
                            </div>   

                            <%--Acordion Analisis--%>
                            <div class="accordion" id="accordionTema" style="margin-top: 15px;">
                                <div class="card">
                                    <div class="card-header cardheader-detalle" id="headingTema">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button id="lbl17"  class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseTema" aria-expanded="false" aria-controls="collapseTema">
                                                Análisis
                                            </button>
                                        </h2>
                                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseTema"/>
                                    </div>

                                    <div id="collapseTema" class="collapse" aria-labelledby="headingTema">
                                        <div class="card-body" >
                                            <div id="tableTema" class="table-editable">
                                                <span id="plusAnalisis" class="float-right mb-3 mr-2 card-add "><asp:Button runat="server" OnClick="delTemas_Click"  ID="delTema" style="font-size:30px; font-weight:bold; text-decoration:none;  border: none; background:none;" CssClass="text-danger openModal" Text="-" /></span>
                                                <span id="minusAnalisis" class="float-right mb-3 mr-2 card-add " data-target="#modalTemas"><a id="addTemaPlus" title="Añadir un Nuevo Tema" data-toggle="modal" style="font-size:30px; font-weight:bold; text-decoration:none;"  data-target="#modalTemas" class="text-success openModal">+</a></span>                                                  
                                                <asp:GridView runat="server" ID="gvTemas" CssClass="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                        <Columns>
                                                        <asp:TemplateField>  
                                                        <EditItemTemplate>  
                                                            <asp:CheckBox ID="Chk1" runat="server" />  
                                                        </EditItemTemplate>  
                                                        <ItemTemplate>  
                                                            <asp:CheckBox ID="Chk1" runat="server" />  
                                                        </ItemTemplate>  
                                                        </asp:TemplateField>  
                                                        </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <%--Acordion Involucrados--%>
                            <div class="accordion" id="accordionInv2" style="margin-top: 15px;">
                                <div class="card" style="overflow: auto;">
                                    <div class="card-header cardheader-detalle" id="headingInv2">
                                        <h2 class="mb-0" style="float: left; width: 94%;">
                                            <button id="lbl18" class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#modalInv" aria-expanded="false" aria-controls="collapseInv">
                                               Involucrados
                                            </button>
                                        </h2>
                                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseInv"/>
                                    </div>

                                    <div id="collapseInv" class="collapse" aria-labelledby="headingInv2" >
                                        <div class="card-body">
                                            <div id="tableInv2" class="table-editable">
                                                <span id="plusInv" class="float-right mb-3 mr-2 card-add "><asp:Button runat="server" OnClick="delInv_Click"  ID="delInv" style="font-size:30px; font-weight:bold; text-decoration:none;  border: none; background:none;" CssClass="text-danger openModal" Text="-" /></span>  
                                                <span id="minusInv" class="float-right mb-3 mr-2 card-add " data-target="#modalInv"><a id="addInvPlus" title="Añadir un Nuevo Tema" data-toggle="modal" style="font-size:30px; font-weight:bold; text-decoration:none;"  data-target="#modalInv" class="text-success openModal">+</a></span>
                                                    <asp:GridView  runat="server" ID="gvInv" CssClass="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                        <Columns>
                                                        <asp:TemplateField>  
                                                        <EditItemTemplate>  
                                                            <asp:CheckBox ID="Chk2" runat="server" />  
                                                        </EditItemTemplate>  
                                                        <ItemTemplate>  
                                                            <asp:CheckBox ID="Chk2" runat="server" />  
                                                        </ItemTemplate>  
                                                        </asp:TemplateField>  
                                                        </Columns>
                                                    </asp:GridView>
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
                                            <button id="lbl19" class="btn btn-link btn-collapse" type="button" data-toggle="collapse" data-target="#collapseEnt" aria-expanded="false" aria-controls="collapseEnt">
                                              Entrevistados
                                            </button>
                                        </h2>
                                        <img src="img/down-arrow.svg" style="float:right; margin-right: 20px; margin-top: 9px; height: 24px; cursor: pointer;" data-toggle="collapse" data-target="#collapseEnt"/>
                                    </div>

                                    <div id="collapseEnt" class="collapse" aria-labelledby="headingEnt">
                                        <div class="card-body">
                                            <div id="tableEnt" class="table-editable">
                                                <span id="plusEntrevistados" class="table-addEnt float-right mb-3 mr-2 card-add"><a href="#!" id="addEntrevistadoPlus" title="Añadir un nuevo Entrevistado"  style="font-size:30px; font-weight:bold; text-decoration:none;" class="text-success">+</a></span>
                                                <table class="table table-bordered table-responsive-md table-striped text-center tblinvolucrados">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-left" style="display:none;">id</th>
                                                            <th class="text-left">Nombre Completo</th>
                                                            <th class="text-left">Puesto</th>
                                                            <th class="text-left">Entrevistado por:</th>
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
                                <label id="lbl20" for="inputResumen">Conclusión General</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtConclusion" textMode="MultiLine" Rows="4"/>
                            </div>

                            <div class="form-group" style="margin-top:15px;">
                                <label id="lbl21" for="inputResumen">Comentarios</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtDisplayComentario" textMode="MultiLine" Rows="5" ReadOnly="true"/>
                                
                                <div id="divComentario" class="form-row" style="margin-top:5px;">
                                    <div class="form-group col-md-10" >
                                        <asp:TextBox runat="server" AutoPostBack="false" CssClass="form-control" onkeydown = "return (event.keyCode!=13);" ID="txtComentarioQueja" Placeholder="Escribe un comentario/Write a comment..."/>
                                        
                                    </div>
                                    <div class="form-group col-md-2 " >
                                        <button type="button" id="txtComentarioInv" class="btn btn-info" onclick="return saveComentarioBQ()">Comentar</button>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div id="divRegresar" class="form-group col-md-2 ml-auto">
                                    <button id="btnRegresar" type="button" class="btn btn-secondary" onclick="location.href='DashboardQuejas.aspx';">Regresar</button>
                                </div>
                                <div id="divGuardar" class="form-group col-md-2" >
                                    <button id="btnGuardar" type="button" class="btn btn-primary">Guardar</button>
                                </div>
                                <div id="divEnviarVobo" class="form-group col-md-2 ">
                                    <button id="btnEnviarVobo" type="button" class="btn btn-success">Enviar a VoBo</button>
                                </div>
                                <div class="form-group col-md-2 " id="divRevision">
                                    <button id="btnEnviarRev" type="button" class="btn btn-success">Enviar a Vobo</button>
                                </div>
                                <div id="divEnviar" class="form-group col-md-2 ">
                                    <button id="btnEnviar" type="button" class="btn btn-success">Enviar</button>
                                </div>
                            <%--    <div class="form-group col-md-2 " id="btnAceptarOBT" visible="false" runat="server" >
                                    <button type="button" class="btn btn-primary" onclick="sendGerente()" data-toggle="modal">Aceptar</button>
                                </div>
                                <div class="form-group col-md-2 " id="btnAceptar" visible="false" runat="server" >
                                    <button type="button" class="btn btn-primary" onclick="" data-toggle="modal" data-target="#modalMadurez">Aceptar</button>
                                </div>
                                <div class="form-group col-md-2 " id="btnRechazo" visible="false" runat="server" >
                                    <button type="button" class="btn btn-danger" data-target=".bd-example-modal-xl" onclick="return cargarModalRechazo(0);" data-toggle="modal" data-target=".bd-example-modal-xl">Rechazar</button>
                                </div>--%>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
          
	        <div id="usrMsg" class="alert alert-success" style="text-align:center; visibility:hidden" >
	            Message
	        </div>
    

            <%--Modal Analisis--%>
            <div id="modalTemas" class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" style="display:none"> 
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 id="lbl22" class="modal-title">Análisis</h5>
                            <button runat="server" id="closeModal" type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body principal">
                    
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl23" for="inputFolio">Tema Investigado</label>
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtTema" MaxLength="100" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl24" for="inputGrupo">Asunto Investigado</label>                                       
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtAsunto" MaxLength="250" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl25" for="inputEmpresa">Actividades de la Investigación</label>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mTxtActividades" textMode="MultiLine" Rows="2" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl26" for="inputSitio">Detalle de las actividades de Investigación</label>                  
                                        <asp:TextBox runat="server"  CssClass="form-control" ID="mTxtDetalle" textMode="MultiLine" Rows="5" />
                                    </div>
                                </div>

                                <div class="form-row">
                                     <div class="form-group col-md-6">
                                        <label id="lbl27" for="inputDepartamento">Plan de Acción</label>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mTxtPlan" textMode="MultiLine" Rows="3"  />
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label id="lbl28" for="inputTema">Conclusiones</label>
                                     
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mTxtConclusiones" textMode="MultiLine" Rows="3"  />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label id="lbl29" for="inputTitulo">Resultado</label>
                                        <asp:DropDownList ID="resultadoDDL" runat="server" CssClass="form-control" >

                                        </asp:DropDownList>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label id="lbl30" for="inputResumen">Beneficio</label>
                                        <asp:DropDownList ID="beneficioDDL" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label id="lbl31" for="inputResumen">Soporte</label>
                                        <div id="SoporteContainer">
                                            <button title="Añadir Soporte" id="btnAddSoporteModal" type="button" style="width:49%;"class="btn btn-info btn-rounded btn-sm my-0" onclick="event.preventDefault(); popUp('ArchivosInvestigacion.aspx?idForm=Analisis', 2, 0 ); ">Agregar Soporte</button>
                                            <button title="Ver Soportes Agregados" id="btnSopVer"style="width:49%;" type="button" class="btn btn-secondary btn-rounded btn-sm my-0">Ver</button>   
                                     </div>
                                        
                                    </div>

                                </div>                             
                          
                               
                        </div>
                        <div class="modal-footer principal">
                            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnTemaGuardar" Text="Guardar" OnClick="btnTemaGuardar_Click"/>
                            <asp:Button runat="server" CssClass="btn btn-danger" ID="btnTemaCancelar" Text="Cancelar"/>
                        </div>
                        <div class="modal-body rechazo" style="display:none;">
                            <form>
                                <div class="form-group">
                                    <label for="inputResumen">Por favor ingresa el motivo del rechazo</label>
                                    <%--<input type="text" class="form-control" id="txt" placeholder="1234 Main St">--%>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtComentarioRechazo" textMode="MultiLine" Rows="5"/>
                                </div>
                                <div class="modal-footer ">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>
                                    <button id="confirmarRechazo" type="button" disabled="disabled" class="btn btn-danger" onclick="return sendRechazar()">Confirmar</button>
                                </div>
                            </form>
                        </div>  
                        <div class="modal-body rechazoInv" style="display:none;">
                            <form>
                                <div class="form-group">
                                    <label for="inputResumen">Por favor ingresa el motivo de la solicitud de reasignación</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtComentarioRechazoInv" textMode="MultiLine" Rows="5"/>
                                </div>
                                <div class="modal-footer ">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>
                                    <button id="confirmarRechazoInv" type="button" disabled="disabled" class="btn btn-danger" onclick="return sendRechazarInv()">Confirmar</button>
                                </div>
                            </form>
                        </div> 
                
                    </div>
                </div>
            </div>


           <%--Modal Involucrados--%>
            <div id="modalInv" class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" style="display:none"> 
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 id="lbl32" class="modal-title">Involucrados</h5>
                            <button runat="server" id="Button1" type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                          <div class="modal-body principal">
                    
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl33" for="inputFolio">Nombre Completo</label>
                                        <asp:TextBox Width="50%" runat="server"  CssClass="form-control" ID="txtInvNombre" MaxLength="100" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl34" for="inputGrupo">Puesto</label>                                       
                                        <asp:TextBox Width="50%" runat="server"  CssClass="form-control" ID="txtInvPuesto" MaxLength="250" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl35" for="inputGrupo">Tipo</label>                                       
                                        <asp:DropDownList Width="50%"  runat="server" CssClass="form-control" ID="ddlTipo" /> 
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                    <label id="lbl36" for="inputGrupo">Fecha Ingreso</label>                                       
                                        <asp:TextBox Width="50%"  runat="server" CssClass="form-control" ID="fechaIngreso" TextMode="Date"/>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label id="lbl37" for="inputGrupo">Fecha Compromiso</label>                                       
                                        <asp:TextBox Width="50%" runat="server"  CssClass="form-control" ID="fechaCom" TextMode="Date" />
                                    </div>
                                </div>
 
                        </div>
                        <div class="modal-footer principal">
                            <asp:Button runat="server" CssClass="btn btn-primary btn-rounded btn-sm my-0" ID="btnInvGuardar" Text="Guardar" OnClick="btnInvGuardar_Click"/>
                            <asp:Button runat="server" CssClass="btn btn-danger btn-rounded btn-sm my-0" ID="btnInvCan" Text="Cancelar"/>
                            <button title="Añadir Soporte" id="btnSopInv" type="button" class="btn btn-info btn-rounded btn-sm my-0" onclick="event.preventDefault(); popUp('ArchivosInvestigacion.aspx?idForm=Involucrados', 2, 0 ); ">Agregar Soporte</button>
                            <button title="Ver Soportes Agregados" id="btnSopInvVer"  type="button" class="btn btn-secondary btn-rounded btn-sm my-0 ">Ver</button> 
                        </div>

                        </div>
                    </div>
                </div>
            </div>

           

              <%--Modal Soporte--%>
            <div id="modalSoporte" class="modal fade bd-example-modal-xl"  tabindex="-1" data-backdrop-limit="1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" data-modal-parent="#modalDetail">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Archivos Soporte</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div id="tableSoporte2" class="table-editable">
                                <table id="tblSoporte" class="table table-bordered table-responsive-md table-striped text-center" style="width: 50%; margin-left: 24%;">
                                   
                                </table>
                            </div>
                        </div>   
                    </div>
                </div>
            </div>



   
    </form>
</asp:Content >
    

