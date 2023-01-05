<%@ Page  MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="UsuarioBuzon.aspx.cs" Inherits="Portal_Investigadores.UsuarioBuzon" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server" id="form">
        <link href="css/especiales.css" rel="stylesheet" />

        <script>

            var idUsuario = '<%= Session["idUsuario"] %>';
            var idBQ = $('#contenido_ddlBuzon').val();

            $(document).ready(function () {

                $('#contenido_ddlBuzon').change(function () { 
                    
                });
                if ($('#contenido_chbkInvestigador').is(":checked")) {                    
                    $("#contenido_divRelaciones").show();
                    $("#divSelDelegados").show();
                    $("#tableDelegados").show();
                    cargarDelegados();
                }
                if ($("#contenido_chbkRevisor").is(":checked")) {
                    $("#contenido_divRelaciones").show();
                    $("#divSelRevisados").show();
                    $("#tableRevisados").show();
                    cargarRevisados();

                }
                if ($("#contenido_chbkEnterado").is(":checked")) {
                    $("#contenido_divRelaciones").show();
                    $("#divSelEnterados").show();
                    $("#tableEnterados").show();
                }
            });


            function addDelegado() {                

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var idDelegado = $("#contenido_ddlDelegados").val();
                var idBQ = $("#contenido_ddlBuzon").val();

                if (idDelegado > 0) {
                    var usuarioAlta = idUsuario;

                    $.ajax({
                        type: "POST",
                        beforeSend: function () {
                            $('.ajax-loader').css("visibility", "visible");
                        },
                        url: 'UsuarioBuzon.aspx/AgregarDelegadoBQ',
                        data: JSON.stringify({ 'idResponsable': idResponsable, 'idDelegado': idDelegado, 'usuarioAlta': usuarioAlta, 'idBQ': idBQ }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
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
                var idBQ = $("#contenido_ddlBuzon").val();

                if (idRevisado > 0) {

                    var usuarioAlta = idUsuario;

                    $.ajax({
                        type: "POST",
                        beforeSend: function () {
                            $('.ajax-loader').css("visibility", "visible");
                        },
                        url: 'UsuarioBuzon.aspx/AgregarRevisadoBQ',
                        data: JSON.stringify({ 'idResponsable': idResponsable, 'idRevisado': idRevisado, 'usuarioAlta': usuarioAlta, 'idBQ': idBQ }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {                            
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


            function cargarRevisados() {

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var idBQ = $("#contenido_ddlBuzon").val();

                $.ajax({
                    type: "POST",
                    url: 'UsuarioBuzon.aspx/CargarRevisadosAsignadosBQ',
                    data: JSON.stringify({ 'idResponsable': idResponsable, 'idBQ': idBQ }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {                        
                        var objdata = $.parseJSON(data.d);                        

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
                            $('#tableRevisados tbody').append('<td><p style="margin-top: 10px;font-size: 19px; margin-left:45px;"> No se han añadido Revisados</p></td><td></td>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });

            }

            function cargarDelegados() {

                var idResponsable = $("#contenido_txtIdUsuario").val();
                var idBQ = $("#contenido_ddlBuzon").val();

                $.ajax({
                    type: "POST",
                    url: 'UsuarioBuzon.aspx/CargarDelegadosAsignadosBQ',
                    data: JSON.stringify({ 'idResponsable': idResponsable, 'idBQ': idBQ }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {                        
                        var objdata = $.parseJSON(data.d);                        

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
                            $('#tableDelegados tbody').append('<td><p style="margin-top: 10px;font-size: 19px; margin-left:45px;"> No se han añadido Delegados</p></td><td></td>');
                        }

                    },
                    error: function (e) {
                        console.log(e);
                    }
                });

            }



        </script>



        <div class="container">
            <div class="row" style="margin-top:21px;">
                <div class="table-header">
                    Buzón de Quejas - Gestión de Usuarios
                </div>
                <div class="form-group col-md-12">
                    <label for="inputUsuario">Usuario</label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="txtIdUsuario" style="display:none;" />
                    <asp:TextBox runat="server" CssClass="form-control" ID="txtUsuario" Enabled="false"/>
                </div>
                <div class="form-group col-md-12">
                    <label for="inputFolio">Nombre*</label>
                    <asp:TextBox Enabled="false" runat="server"  CssClass="form-control" ID="txtNombre" />
                </div>
                <div class="form-group col-md-6">
                    <label for="inputEmpresa">Grupo*</label>
                    <asp:DropDownList Enabled="false" ID="ddlGrupo" runat="server" CssClass="form-control" AutoPostBack="false" >                        
                    </asp:DropDownList>
                </div>
                
                <div class="form-group col-md-6">
                    <label for="inputSitio">Empresa*</label>
                    <asp:DropDownList Enabled="false" ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="false">                                    
                    </asp:DropDownList>
                </div>                
                <div class="form-group col-sm-4">
                    <label for="inputBuzon">Buzón</label>
                    <asp:DropDownList OnSelectedIndexChanged="ddlBuzon_SelectedIndexChanged" ID="ddlBuzon" runat="server" CssClass="form-control" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="form-group col-sm-4">
                    <asp:Button runat="server" ID="btnAdd" OnClick="agregarUsuarioBuzon" Text="Agregar" CssClass="btn btn-primary" />
                </div>
                <div class="form-group col-sm-4">
                    <asp:Button runat="server" ID="btnEdit" OnClick="editarUsuarioBuzon" Text="Editar" CssClass="btn btn-primary" />
                </div>                
                <div class="form-group col-md-2 ml-auto">
                    <label for="inputVobo">Es VoBo</label>
                    <asp:CheckBox runat="server" ID="chbkVobo" CssClass="form-control"/>
                </div>
                <div class="form-group col-md-2">
                    <label for="inputDelegado">Es Delegado</label>
                    <asp:CheckBox runat="server" ID="chbkDelegado" CssClass="form-control"/>
                </div>  
                <div class="form-group col-md-2">
                    <label for="inputInvestigador">Es Investigador</label>
                    <asp:CheckBox runat="server" ID="chbkInvestigador" CssClass="form-control"/>                    
                </div>
                <div class="form-group col-md-2">
                    <label for="inputRevisor">Es Revisor</label>
                    <asp:CheckBox runat="server" ID="chbkRevisor" CssClass="form-control"/>                    
                </div>
                <div class="form-group col-md-2">
                    <label for="inputEnterado">Es Enterado</label>
                    <asp:CheckBox runat="server" ID="chbkEnterado" CssClass="form-control"/>
                </div>
                 <div class="form-group col-md-2">
                    <label for="inputAdmin">Administrador Quejas</label>
                    <asp:CheckBox runat="server" ID="chbkAdmin" CssClass="form-control"/>
                </div>
                <div class="form-group col-md-2">
                    <label for="inputActivo">Activo</label>
                    <asp:CheckBox runat="server" ID="chbkActivo" CssClass="form-control"/>
                </div>
                <asp:Panel ID="panelSubtema" runat="server" Visible="false">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                      <asp:Label runat="server" ID="lbl" />
                      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                </asp:Panel>
                <div class="col-md-12">
                    <div style="overflow-y:scroll; height:200px">
                        <asp:GridView HeaderStyle-CssClass="thead-light" ShowHeaderWhenEmpty="true" CssClass="table-bordered table" runat="server" ID="usuariosGV" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="descripcion" HeaderText="Buzón" />                                
                                <asp:CheckBoxField DataField="BQEsVobo" HeaderText="Es Vobo" />
                                <asp:CheckBoxField DataField="EsInvestigador" HeaderText="Es Investigador" />
                                <asp:CheckBoxField DataField="EsDelegado" HeaderText="Es Delegado" />
                                <asp:CheckBoxField DataField="EsRevisor" HeaderText="Es Revisor" />
                                <asp:CheckBoxField DataField="EsEnterado" HeaderText="Es Enterado" />
                                <asp:CheckBoxField DataField="AdminQuejas" HeaderText="Administrador Quejas" />
                                <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                            </Columns>                          
                        </asp:GridView>
                    </div>
                </div>
                <div class="form-group col-md-4 offset-md-4">
                    <asp:Button runat="server" ID="btnCancel" Text="regresar" CssClass="btn btn-secondary" />
                </div>
            </div>

            <div runat="server" class="row" id="divRelaciones" style="margin-top:21px;display:none;">
                <div class="table-header"> Relaciones</div>


                <div class="form-group col-md-4" id="divSelDelegados" style="display:none;">
                    <label for="inputSitio">Selecciona Delegados</label>
                    <asp:DropDownList ID="ddlDelegados" runat="server" CssClass="form-control" AutoPostBack="false">                                        
                    </asp:DropDownList>
                        <button id="agregarDelegado" type="button" style="margin-top: 10px;" class="btn btn-primary" onclick="return addDelegado();">Agregar</button>  
                        <div id="tableDelegados" style="display:none;     margin-top: 20px;" class="table-editable">
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
                    </div>

                    <div class="form-group col-md-4" id="divSelRevisados" style="display:none;">
                        <label for="inputSitio">Selecciona a quien Revisa</label>
                        <asp:DropDownList ID="ddlRevisados" runat="server" CssClass="form-control" AutoPostBack="false">                                        
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
                        </asp:DropDownList>
                        <button id="agregarEnterado" type="button" style="margin-top: 10px;" class="btn btn-primary" onclick="return addEnterado();">Agregar</button>  

                        <div id="tableEnterados" style="display:none; margin-top: 20px;" class="table-editable">
                            <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte">
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



            </div>


        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
