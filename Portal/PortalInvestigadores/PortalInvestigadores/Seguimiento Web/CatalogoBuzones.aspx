<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoBuzones.aspx.cs" Inherits="Portal_Investigadores.CatalogoBuzones" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {
        var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
        $.ajax({
            type: "GET",
            url: "CatalogoBuzones.aspx/BQ_Etiquetas",
            data: $.param({ iId: 5, iIdioma: Idioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 162) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 167) { $("#lbl2").html(Json[i].Texto) }
                    if (Json[i].Id == 149) { $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 150) { $("#lbl4").html(Json[i].Texto) }
                    if (Json[i].Id == 164) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 137) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 140) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 163) { $("#lbl8").html(Json[i].Texto) }

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
    <form id="form" runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row">
                <div id="lbl1"  class="table-header" style="padding-bottom: 27px; text-align: center;">Catalogo de buzones</div>           
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p id="lbl2"  style="text-align: center;">Agregar Buzón</p>
                            </div>
                            <div class="card-body">
                                <div class="form-group col-md-12">
                                    <label id="lbl3" for="inputEmpresa">Grupo*</label>
                                    <asp:DropDownList OnSelectedIndexChanged="ddlGrupo_SelectedIndexChanged" ID="ddlGrupo" runat="server" CssClass="form-control" AutoPostBack="true" >                        
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-12">
                                    <label id="lbl4" for="inputSitio">Empresa*</label>
                                    <asp:DropDownList ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="false">                                    
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label id="lbl5" for="inputNombre">Nombre*</label>
                                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label id="lbl6" for="inputDescripcion">Descripción*</label>
                                    <asp:TextBox runat="server" ID="txtDesc" CssClass="form-control"/>
                                </div>
                                <div runat="server" id="divActive" class="col-md-12 form-group">
                                    <label id="lbl7" >Activo:</label>
                                    <asp:CheckBox runat="server" ID="activeCH" CssClass="form-control"/>
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
                                <div class="col-sm-12 row">
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" OnClick="agregarBuzon" CssClass="btn btn-primary" Text="Agregar" ID="btnAdd" />                                 
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" OnClick="editarBuzon" ID="btnEdit" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" OnClick="cancelarBuzon" ID="btnCancel" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                     
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p id="lbl8"  style="text-align: center;">Lista de buzones</p>
                                <asp:Label runat="server" ID="lbl" />
                            </div>
                            <div class="card-body" style="text-align: center;">
                                <div style="overflow-y:scroll; height:400px">
                                   <asp:GridView OnSelectedIndexChanged="buzonesGV_SelectedIndexChanged" CssClass="strip table-dashboard table-hover table-bordered table" runat="server" ID="buzonesGV" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="buzonSelect" runat="server" CommandName="Select" Text="Seleccionar" CssClass="btn btn-primary"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="grupo" HeaderText="Grupo" />                                        
                                        <asp:BoundField DataField="empresa" HeaderText="Empresa" />
                                        <asp:BoundField DataField="nombreBQ" HeaderText="Nombre Buzón" />
                                        <asp:BoundField DataField="descripcion" HeaderText="Descripcion" />
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