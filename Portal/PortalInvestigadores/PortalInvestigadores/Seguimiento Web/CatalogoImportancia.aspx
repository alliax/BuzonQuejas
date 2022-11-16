<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoImportancia.aspx.cs" Inherits="Portal_Investigadores.CatalogoImportancia" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row" style="margin-top:21px;">
                <div class="table-header" style="padding-bottom: 27px; text-align: center;">Configuracion de Importancia</div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p style="text-align: center;">Importancia</p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label>Importancia</label>
                                <asp:TextBox runat="server" ID="txtImpo" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Descripcion</label>
                                <asp:TextBox runat="server" ID="txtDesc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Recordatorio Atencion</label>
                                <asp:TextBox runat="server" ID="txtRec" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Recordatorio Ate Escala</label>
                                <asp:TextBox runat="server" ID="txtRecAteEsc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Recordatorio Responsable</label>
                                <asp:TextBox runat="server" ID="txtRecRes" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Recordatorio Escalar</label>
                                <asp:TextBox runat="server" ID="txtRecEsc" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Escalacion Usuario</label>
                                <asp:DropDownList runat="server" ID="usuarioDDL" CssClass="form-control" AutoPostBack="false">
                                    <asp:ListItem Text="Selecciona" Value="0" />
                                </asp:DropDownList>
                            </div>
                            <div runat="server" id="divActive" class="form-group col-md-12">
                                <label>Activo:</label>
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
                            <p style="text-align: center;">Lista de Importancia</p>
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