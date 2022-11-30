<%@ Page  Language="C#" MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="CatalogoTipos.aspx.cs" Inherits="Portal_Investigadores.CatalogoTipos" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {

  var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
            $.ajax({
                type: "GET",
                url: "CatalogoTipos.aspx/BQ_Etiquetas",
                data: $.param({ iId: 5, iIdioma: Idioma }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 136) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 137) { $("#lbl2").html(Json[i].Texto) }
                    if (Json[i].Id == 140) { $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 139) { $("#lblHeader").html(Json[i].Texto) }
                    if (Json[i].Id == 132) { $("#<%=btnAdd.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 133) { $("#<%=btnEdit.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 134) { $("#<%=btnCancel.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 136) { $("#lblAdd").html(Json[i].Texto) }
                    if (Json[i].Id == 138) { $("#lblList").html(Json[i].Texto) }
                    
                }


                },
                error: function (r) {
                    alert(r.d);
                }
            });

 }); // Document Ready
           
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
                <div class="table-header" style="padding-bottom: 27px; text-align: center;" id="lblHeader"></div>
                    <div class="col-md-6 col-lg-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p id="lblAdd" style="text-align: center;">Tipo</p>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12 form-group">
                                    <label id ="lbl1">Tipo Id</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtTipo" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label id ="lbl2">Descripción</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtDesc" />
                                </div>
                                <div  class="col-md-2 form-group">
                                    <label id ="lbl3">Activo:</label>
                                    <asp:CheckBox runat="server" ID="cbActive" CssClass="form-control"/>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="col-sm-12 row">
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnAdd" OnClick="agregarTipo" CssClass="btn btn-primary" Text="Agregar" />                                    
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnEdit" OnClick="editarTipo" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnCancel" OnClick="cancelTipo" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                             <asp:Panel ID="panelTipo" runat="server" Visible="false">
                              <div class="container">
                              <div id="msgTipo" class="alert alert-danger " >
                               <asp:Label ID="lblTipo" runat="server"></asp:Label>
                              </div>
                             </div>
                             </asp:Panel>
                        </div>
                        </div>
                    </div>


                   <div class="col-md-6 col-lg-6">
                         <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p id="lblList" style="text-align: center;">Lista de Tipos</p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:200px">
                                 <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="gvTipo_SelectedIndexChanged" CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvTipo" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Tipo Id" />
                                        <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                                        <asp:BoundField DataField="Activo" HeaderText="Activo:" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field" />
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo:" />
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


