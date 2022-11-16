<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoClasificaciones.aspx.cs" Inherits="Portal_Investigadores.CatalogoClasificaciones" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form id="form" runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row">
                <div class="table-header" style="padding-bottom: 27px; text-align: center;">Catalogo de clasificaciones</div>           
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;">Agregar clasificacion</p>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12 form-group">
                                    <label>Clasificación</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtClas" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label>Descripción</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtDesc" />
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Queja</label>
                                    <asp:CheckBox runat="server" CssClass="form-control" ID="cbQueja" />
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Envia correo</label>
                                    <asp:CheckBox runat="server" CssClass="form-control" ID="cbCorreo" />
                                </div>
                                <div runat="server" id="divActive" class="col-md-12 form-group">
                                    <label>Activo:</label>
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
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;">Lista de clasificaciones</p>
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