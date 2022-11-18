<%@ Page  Language="C#" MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="CatalogoTipos.aspx.cs" Inherits="Portal_Investigadores.CatalogoTipos" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
 <form runat="server">
    <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row">
                <div class="table-header" style="padding-bottom: 27px; text-align: center;">Configuración de catalogo de Tipos</div>
                    <div class="col-md-6 col-lg-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;">Tipo</p>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12 form-group">
                                    <label>Tipo Id</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtTipo" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label>Descripción</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtDesc" />
                                </div>
                                <div  class="col-md-2 form-group">
                                    <label>Activo:</label>
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
                                <p style="text-align: center;">Lista de Tipos</p>
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


