<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoConducto.aspx.cs" Inherits="Portal_Investigadores.CatalogoConducto" %>


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
                    if (Json[i].Id == 177) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 178) { $("#lbl2").html(Json[i].Texto); $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 179) { $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 137) { $("#lbl4").html(Json[i].Texto); $("#lbl11").html(Json[i].Texto); }
                    if (Json[i].Id == 140) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 182) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 181) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 179) { $("#lbl8").html(Json[i].Texto) }
                    if (Json[i].Id == 180) { $("#lbl9").html(Json[i].Texto) }
                    if (Json[i].Id == 176) { $("#lbl10").html(Json[i].Texto) }
                    if (Json[i].Id == 183) { $("#lbl12").html(Json[i].Texto) }

                    if (Json[i].Id == 132) { $("#<%=btnAdd.ClientID%>").val(Json[i].Texto); $("#<%=btnAddForma.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 133) { $("#<%=btnEdit.ClientID%>").val(Json[i].Texto); $("#<%=btnEditForma.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 134) { $("#<%=btnCancel.ClientID%>").val(Json[i].Texto); $("#<%=btnCancelForma.ClientID%>").val(Json[i].Texto); }

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
         <div class="row">
            <div id="lbl1" class="table-header" style="padding-bottom: 27px; text-align: center;">Catalogo de conductos y casos</div>
            <div class="col-md-6 col-xs-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <p id="lbl2" style="text-align: center;">Agregar Conducto</p>
                    </div>
                    <div class="card-body">
                        <div class="form-group col-md-12 col-xs-12">
                            <label id="lbl3">Conducto</label>
                            <asp:TextBox runat="server" ID="txtConducto" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-12 col-xs-12">
                            <label id="lbl4">Descripcion</label>
                            <asp:TextBox runat="server" ID="txtDescr" CssClass="form-control" />
                        </div>
                        <div runat="server" id="divActive" class="col-md-12 form-group">
                            <label id="lbl5">Activo:</label>
                            <asp:CheckBox runat="server" ID="cbActive" CssClass="form-control"/>
                        </div>
                    </div>
                    <div class="card-footer" style="height: 60px;">
                        <div class="col-sm-12 row">
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnAdd" CssClass="btn btn-primary" Text="Agregar" OnClick="agregarConducto" />
                            </div>
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnEdit" OnClick="btnEdit_Click" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                            </div>
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                            </div>
                        </div>
                    </div>  
                    <asp:Label runat="server" ID="msg" />
                 </div>
            </div>
            <div class="col-md-6 col-xs-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <p id="lbl6" style="text-align: center;">Lista de conducto</p>
                    </div>
                    <div class="card-body">
                        <div style="overflow-y:scroll; height:200px">
                            <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="conductoGV_SelectedIndexChanged" CssClass="strip table-dashboard table-hover table-bordered table" runat="server" ID="conductoGV" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="conducto" HeaderText="Conducto" />
                                <asp:BoundField DataField="descripcion" HeaderText="Descripcion" />
                                <asp:CheckBoxField DataField="activo" HeaderText="Activo:" />
                            </Columns>                          
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>             
            <div class="col-md-6 col-xs-12" >
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <p id="lbl7" style="text-align:center;">Agregar Forma</p>
                    </div>
                    <div class="card-body">
                        <div class="form-group col-md-12 col-xs-12">
                            <label id="lbl8">Conducto</label>
                            <asp:TextBox runat="server" ID="txtCond" Enabled="false" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-12 col-xs-12">
                            <label id="lbl9">Forma</label>
                            <asp:TextBox runat="server" ID="txtForma" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-12 col-xs-12">
                            <label id="lbl10">Descripcion</label>
                            <asp:TextBox runat="server" ID="desc" CssClass="form-control" />
                        </div>
                        <div runat="server" visible="false" id="divFormaActivo" class="col-md-12 form-group">
                            <label id="lbl11">Activo:</label>
                            <asp:CheckBox runat="server" ID="chActive" CssClass="form-control"/>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="col-sm-12 row">
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnAddForma" OnClick="addForma" CssClass="btn btn-primary" Text="Agregar"/>
                            </div>
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" OnClick="btnEditForma_Click" ID="btnEditForma" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                            </div>
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" OnClick="btnCancelForma_Click" ID="btnCancelForma" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <asp:Panel ID="panelSubtema" runat="server" Visible="false">
                            <div class="container">
                                <div id="msgSubtema" class="alert alert-danger " >
                                <asp:Label ID="lblSubtema" runat="server"></asp:Label>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
             <div class="col-md-6 col-xs-12">
                 <div class="card">
                     <div class="card-header bg-primary text-white">
                        <p id="lbl12" style="text-align:center;">Formas</p>
                    </div>
                     <div class="card-body">
                        <div style="overflow-y:scroll; height:200px">
                            <asp:GridView OnSelectedIndexChanged="formaGV_SelectedIndexChanged" ShowHeaderWhenEmpty="true" AutoGenerateSelectButton="true" CssClass="strip table-dashboard table-hover table-bordered table" runat="server" ID="formaGV" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="forma" HeaderText="Forma" />
                                <asp:BoundField DataField="descripcion" HeaderText="Descripcion" />
                                <asp:CheckBoxField DataField="activo" HeaderText="Activo:" />
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