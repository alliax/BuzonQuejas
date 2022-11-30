<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoImportancia.aspx.cs" Inherits="Portal_Investigadores.CatalogoImportancia" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {
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
            });
 });

function createJson(strJson) {
    var strJson = JSON.stringify(strJson);
    var iJsonLenght = strJson.length
    strJson = strJson.substr(5, iJsonLenght);
    strJson = strJson.slice(0, -1)
    var Json = JSON.parse(strJson);
    Json = JSON.parse(Json);

    return Json;
}
</script>
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row" style="margin-top:21px;">
                <div id="lbl1" class="table-header" style="padding-bottom: 27px; text-align: center;">Configuracion de Importancia</div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p id="lbl2" style="text-align: center;">Importancia</p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label id="lbl3">Importancia</label>
                                <asp:TextBox runat="server" ID="txtImpo" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl4">Descripcion</label>
                                <asp:TextBox runat="server" ID="txtDesc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl5">Recordatorio Atencion</label>
                                <asp:TextBox runat="server" ID="txtRec" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl6">Recordatorio Ate Escala</label>
                                <asp:TextBox runat="server" ID="txtRecAteEsc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl7">Recordatorio Responsable</label>
                                <asp:TextBox runat="server" ID="txtRecRes" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl8">Recordatorio Escalar</label>
                                <asp:TextBox runat="server" ID="txtRecEsc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label id="lbl9">Escalacion Usuario</label>
                                <asp:DropDownList runat="server" ID="usuarioDDL" CssClass="form-control" AutoPostBack="false">
                                    <asp:ListItem Text="Selecciona" Value="0" />
                                </asp:DropDownList>
                            </div>
                            <div runat="server" id="divActive" class="form-group col-md-12">
                                <label id="lbl10">Activo:</label>
                                <asp:CheckBox runat="server" ID="cbAct" CssClass="form-control" Visible="false" />
                            </div>                            
                        </div>
                        <div class="card-footer" style="height: 60px;">
                            <div class="col-sm-12 row">
                                <div class="form-group col-sm-4">
                                    <asp:Button runat="server" OnClick="agregarImportancia" ID="btnAdd" CssClass="btn btn-primary btn-lg" Text="Agregar" />
                                </div>
                                <div class="form-group col-sm-4">
                                    <asp:Button runat="server" ID="btnEdit" OnClick="btnEdit_Click" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                                </div>
                                <div class="form-group col-sm-4">
                                    <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p id="lbl11" style="text-align: center;">Lista de Importancia</p>
                        </div>
                        <div class="card-body">
                            <div style="overflow-y:scroll; height:200px">
                                <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="importanciaGV_SelectedIndexChanged" ShowHeaderWhenEmpty="true" CssClass="table-responsive strip table-dashboard table-hover table-bordered table" runat="server" ID="importanciaGV" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="importancia" HeaderText="Importancia" />
                                    <asp:BoundField DataField="descripcion" HeaderText="Descripcion" />
                                    <asp:BoundField DataField="RecordatorioAtencion" HeaderText="Recordatorio Atencion" />
                                    <asp:BoundField DataField="RecordatorioAteEscala" HeaderText="Recordatorio Ate Escala" />
                                    <asp:BoundField DataField="RecordatorioResponsable" HeaderText="Recordatorio Responsable" />
                                    <asp:BoundField DataField="RecordatorioEscalar" HeaderText="Recordatorio Escalar" />
                                    <asp:BoundField DataField="EscalacionUsuario" HeaderText="Escalacion Usuario" />
                                    <asp:CheckBoxField DataField="activo" HeaderText="Activo" />
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