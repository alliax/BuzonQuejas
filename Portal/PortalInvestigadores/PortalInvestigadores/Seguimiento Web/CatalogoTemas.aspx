<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CatalogoTemas.aspx.cs" Inherits="Portal_Investigadores.CatalogoTemas" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {

  var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
            $.ajax({
                type: "GET",
                url: "CatalogoTemas.aspx/BQ_Etiquetas",
                data: $.param({ iId: 1, iIdioma: Idioma }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 9) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 23) { $("#lbl2").html(Json[i].Texto) }
                    if (Json[i].Id == 24) { $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 6) { $("#lbl4").html(Json[i].Texto) }
                    if (Json[i].Id == 10) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 27) { $("#lbl12").html(Json[i].Texto) }
                    if (Json[i].Id == 25) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 24) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 26) { $("#lbl8").html(Json[i].Texto) }
                    if (Json[i].Id == 6) { $("#lbl9").html(Json[i].Texto) }
                    if (Json[i].Id == 10) { $("#lbl10").html(Json[i].Texto) }
                    if (Json[i].Id == 28) { $("#lbl11").html(Json[i].Texto) }
                        
                    if (Json[i].Id == 1) { $("#<%=btnAdd.ClientID%>").val(Json[i].Texto); $("#<%=btnAddSb.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 2) { $("#<%=btnEdit.ClientID%>").val(Json[i].Texto); $("#<%=btnEdiSb.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 3) { $("#<%=btnCancel.ClientID%>").val(Json[i].Texto); $("#<%=btnCanSb.ClientID%>").val(Json[i].Texto); }
     
                    
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
                <div id="lbl1" class="table-header" style="padding-bottom: 27px; text-align: center;">Configuración de catalogo de Temas y Subtemas</div>
                    <div class="col-md-6 col-lg-6">
                        <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
                                <p id="lbl2" style="text-align: center;">Tema</p>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12 form-group">
                                    <label id="lbl3">Tema Id</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtTema" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label id="lbl4">Descripción</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtDesc" />
                                </div>
                                <div  class="col-md-2 form-group">
                                    <label id="lbl5">Activo:</label>
                                    <asp:CheckBox runat="server" ID="cbActivo" CssClass="form-control"/>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="col-sm-12 row">
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnAdd" OnClick="agregarTema" CssClass="btn btn-primary" Text="Agregar" />                                    
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnEdit" OnClick="editarTema" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Tema" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                             <asp:Panel ID="panelTema" runat="server" Visible="false">
                              <div class="container">
                              <div id="msgTema" class="alert alert-danger " >
                               <asp:Label ID="lblTema" runat="server"></asp:Label>
                              </div>
                             </div>
                             </asp:Panel>
                        </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                         <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
                                <p  id="lbl12" style="text-align: center;">Lista de Temas</p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:200px">
                                 <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="temaGV_SelectedIndexChanged" CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="temaGV" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Tema Id" />
                                        <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                                        <asp:BoundField DataField="Activo" HeaderText="Activo:" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field" />
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo:" />
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header  text-white" style="background:#4E8ABE">
                            <p id="lbl6" style="text-align:center;">Subtema</p>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 form-group">
                                <label id="lbl7">Tema Id</label>
                                <asp:TextBox runat="server" CssClass="form-control" Enabled="false" ID="tbTema" />
                            </div>
                            <div class="col-md-12 form-group">
                                <label id="lbl8">Subtema Id</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtSubtema" />
                            </div>
                            <div class="col-md-12 form-group">
                                <label id="lbl9">Descripción</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtSubTemaDesc" />
                            </div>
                           <div  class="col-md-2 form-group">
                            <label id="lbl10">Activo:</label>
                               <asp:CheckBox runat="server" ID="cbSubActivo" CssClass="form-control"/>
                           </div>
                        </div>
                        <div class="card-footer">
                            <div class="col-sm-12 row">
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnAddSb" OnClick="agregarSubtema" CssClass="btn btn-primary" Text="Agregar" Enabled="false" />                                    
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnEdiSb" OnClick="editarSubtema" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" ID="btnCanSb" OnClick="cancelSubtema" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
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
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header  text-white" style="background:#4E8ABE">
                            <p id="lbl11" style="text-align: center;">Lista de Subtemas</p>
                        </div>
                        <div class="card-body">
                            <div style="overflow-y:scroll; height:200px">
                                <asp:GridView AutoGenerateSelectButton="true" CssClass="table table-hover" OnSelectedIndexChanged="subtemaGV_SelectedIndexChanged" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="subtemaGV" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="IdTema" HeaderText="Tema Id" />
                                    <asp:BoundField DataField="Id" HeaderText="SubTema Id" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
