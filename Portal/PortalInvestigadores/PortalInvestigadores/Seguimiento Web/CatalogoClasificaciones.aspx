<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoClasificaciones.aspx.cs" Inherits="Portal_Investigadores.CatalogoClasificaciones" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {
        var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
        $.ajax({
            type: "GET",
            url: "CatalogoImportancia.aspx/BQ_Etiquetas",
            data: $.param({ iId: 1, iIdioma: Idioma }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                Json = createJson(r);
                for (i = 0; i <= Json.length - 1; i++) {
                    if (Json[i].Id == 50) { $("#lbl1").html(Json[i].Texto) }
                    if (Json[i].Id == 51) { $("#lbl2").html(Json[i].Texto); $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 52) { $("#lbl3").html(Json[i].Texto) }
                    if (Json[i].Id == 6) { $("#lbl4").html(Json[i].Texto); $("#lbl11").html(Json[i].Texto); }
                    if (Json[i].Id == 54) { $("#lbl5").html(Json[i].Texto) }
                    if (Json[i].Id == 55) { $("#lbl6").html(Json[i].Texto) }
                    if (Json[i].Id == 10) { $("#lbl7").html(Json[i].Texto) }
                    if (Json[i].Id == 56) { $("#lbl8").html(Json[i].Texto) }
        

                    if (Json[i].Id == 1) { $("#<%=btnAgregarClas.ClientID%>").val(Json[i].Texto);  }
                    if (Json[i].Id == 2) { $("#<%=btnEdit.ClientID%>").val(Json[i].Texto); }
                    if (Json[i].Id == 3) { $("#<%=btnCancel.ClientID%>").val(Json[i].Texto); }

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
                <div id="lbl1" class="table-header" style="padding-bottom: 27px; text-align: center;">Catalogo de clasificaciones</div>           
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header  text-white" style="background:#4E8ABE">
                                <p id="lbl2" style="text-align: center;">Agregar clasificacion</p>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12 form-group">
                                    <label id="lbl3">Clasificación</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtClas" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label id="lbl4">Descripción</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtDesc" />
                                </div>
                                <div class="col-md-6 form-group">
                                    <label id="lbl5">Queja</label>
                                    <asp:CheckBox runat="server" CssClass="form-control" ID="cbQueja" />
                                </div>
                                <div class="col-md-6 form-group">
                                    <label id="lbl6">Envia correo</label>
                                    <asp:CheckBox runat="server" CssClass="form-control" ID="cbCorreo" />
                                </div>
                                <div runat="server" id="divActive" class="col-md-12 form-group">
                                    <label id="lbl7" >Activo:</label>
                                    <asp:CheckBox runat="server" ID="cbActive" CssClass="form-control"/>
                                </div>
                            </div>
                            <div runat="server" id="divError" class="alert alert-warning alert-dismissible fade show" role="alert">
                              <strong runat="server" id="msgError"></strong>.
                              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>
                            <div class="card-footer" style="height: 60px;">                                    
                                <div class="col-sm-12 row">
                                    <div class="form-group col-sm-4">
                                        <asp:Button runat="server" CssClass="btn btn-primary btn-lg" Text="Agregar" ID="btnAgregarClas" OnClick="agregarClasificacion" />                                 
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
                            <div class="card-header  text-white" style="background:#4E8ABE">
                                <p id="lbl8" style="text-align: center;">Lista de clasificaciones</p>
                            </div>
                            <div class="card-body" style="text-align: center;">
                                <div style="overflow-y:scroll; height:200px">
                                   <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="clasificacionGV_SelectedIndexChanged" CssClass="table-responsive strip table-dashboard table-hover table-bordered table" runat="server" ID="clasificacionGV" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="clasificacion" HeaderText="Clasificación" />
                                        <asp:BoundField DataField="descripcion" HeaderText="Descripcion" />
                                        <asp:CheckBoxField DataField="queja" HeaderText="Queja" />
                                        <asp:CheckBoxField DataField="enviaCorreo" HeaderText="Envia Correo" />
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