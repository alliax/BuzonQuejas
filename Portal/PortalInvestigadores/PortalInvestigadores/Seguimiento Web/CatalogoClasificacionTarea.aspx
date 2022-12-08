<%@ Page MasterPageFile="~/Site1.Master" ResponseEncoding="utf-8" ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoClasificacionTarea.aspx.cs" Inherits="Portal_Investigadores.CatalogoClasificacionTarea" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

<%--$(document).ready(function () {
        var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
        $.ajax({
            type: "GET",
            url: "CatalogoImportancia.aspx/BQ_Etiquetas",
            data: $.param({ iId: 5, iIdioma: Idioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 168) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 169) { $("#lbl2").html(Json[i].Texto); $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 137) { $("#lbl4").html(Json[i].Texto) }
                    if (Json[i].Id == 171) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 174) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 173) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 172) { $("#lbl8").html(Json[i].Texto) }
                    if (Json[i].Id == 175) { $("#lbl9").html(Json[i].Texto) }
                    if (Json[i].Id == 140) { $("#lbl10").html(Json[i].Texto) }
                    if (Json[i].Id == 176) { $("#lbl11").html(Json[i].Texto) }

                    if (Json[i].Id == 132) { $("#<%=btnAdd.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 133) { $("#<%=btnEdit.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 134) { $("#<%=btnCancel.ClientID%>").val(Json[i].Texto); }

                 }


                },
                error: function (r) {
                    alert(r.d);
                }
            });--%>
/* });*/

//function createJson(strJson) {
//    var strJson = JSON.stringify(strJson);
//    var iJsonLenght = strJson.length
//    strJson = strJson.substr(5, iJsonLenght);
//    strJson = strJson.slice(0, -1)
//    var Json = JSON.parse(strJson);
//    Json = JSON.parse(Json);

//    return Json;
//}
</script>
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row" style="margin-top:21px;">
                <div id="lbl1" class="table-header" style="padding-bottom: 27px; text-align: center;">Configuracion de Clasificacion Tarea</div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p id="lbl2" style="text-align: center;">Clasificacion Tarea</p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl3">Clasificacion Tarea</label>
                                <asp:TextBox runat="server" ID="txtTarea" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl4">Descripcion</label>
                                <asp:TextBox runat="server" ID="txtDesc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl5">Activo:</label>
                                <asp:CheckBox runat="server" ID="cbAct" CssClass="form-control" />
                            </div>                        
                        </div>
                        <asp:Panel Visible="false" runat="server" ID="error">
                            <div runat="server" id="divError" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong runat="server" id="msgError"></strong>.
                                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </asp:Panel>
                        <div class="card-footer" style="height: 60px;">
                            <div class="col-sm-12 form-row">
                                <div class="form-group col-sm-4">
                                    <asp:Button runat="server" OnClick="btnAdd_Click" ID="btnAdd" CssClass="btn btn-primary btn-lg" Text="Agregar" />
                                </div>
                                <div class="form-group col-sm-4">
                                    <asp:Button runat="server" OnClick="btnEdit_Click" ID="btnEdit" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                                </div>
                                <div class="form-group col-sm-4">
                                    <asp:Button runat="server" OnClick="btnCancel_Click" ID="btnCancel" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p id="lbl11" style="text-align: center;">Lista de Clasificaciones Tareas</p>
                        </div>
                        <div class="card-body">
                            <div style="overflow-y:scroll; height:200px">
                                <asp:GridView OnSelectedIndexChanged="clasificacionTareaGV_SelectedIndexChanged"  ShowHeaderWhenEmpty="true" CssClass="strip table-dashboard table-hover table" runat="server" ID="clasificacionTareaGV" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField>
                                         <ItemTemplate>
                                            <asp:Button ID="selectID" runat="server" CommandName="Select" Text="Seleccionar" CssClass="btn btn-primary"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ClasificacionTarea" HeaderText="Clasificacion Tarea" />
                                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                                    <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                                </Columns>                          
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>