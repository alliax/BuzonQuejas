<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CatalogoTemas.aspx.cs" Inherits="Portal_Investigadores.CatalogoTemas" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row">
                <div class="table-header" style="padding-bottom: 27px; text-align: center;">Configuración de catalogo de temas y subtemas</div>
                    <div class="col-md-6 col-lg-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;">TEMA</p>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12 form-group">
                                    <label>Tema Id</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtTema" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label>Descripción</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtDesc" />
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
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;">Lista de Temas</p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:200px">
                                 <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="temaGV_SelectedIndexChanged" CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="temaGV" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Tema Id" />
                                        <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p style="text-align:center;">SUBTEMA</p>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 form-group">
                                <label>Tema Id</label>
                                <asp:TextBox runat="server" CssClass="form-control" Enabled="false" ID="tbTema" />
                            </div>
                            <div class="col-md-12 form-group">
                                <label>Subtema Id</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtSubtema" />
                            </div>
                            <div class="col-md-12 form-group">
                                <label>Descripción</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtSubTemaDesc" />
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
                        <div class="card-header bg-primary text-white">
                            <p style="text-align: center;">Lista de Subtemas</p>
                        </div>
                        <div class="card-body">
                            <div style="overflow-y:scroll; height:200px">
                                <asp:GridView AutoGenerateSelectButton="true" CssClass="table table-hover" OnSelectedIndexChanged="subtemaGV_SelectedIndexChanged" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="subtemaGV" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="IdTema" HeaderText="Tema Id" />
                                    <asp:BoundField DataField="Id" HeaderText="SubTema Id" />
                                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
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
