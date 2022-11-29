<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoBuzones.aspx.cs" Inherits="Portal_Investigadores.CatalogoBuzones" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form id="form" runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row">
                <div class="table-header" style="padding-bottom: 27px; text-align: center;">Catalogo de buzones</div>           
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;">Agregar Buzón</p>
                            </div>
                            <div class="card-body">
                                <div class="form-group col-md-12">
                                    <label for="inputEmpresa">Grupo*</label>
                                    <asp:DropDownList OnSelectedIndexChanged="ddlGrupo_SelectedIndexChanged" ID="ddlGrupo" runat="server" CssClass="form-control" AutoPostBack="true" >                        
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-12">
                                    <label for="inputSitio">Empresa*</label>
                                    <asp:DropDownList ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="false">                                    
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label for="inputNombre">Nombre*</label>
                                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                                </div>
                                <div class="col-md-12 form-group">
                                    <label for="inputDescripcion">Descripción*</label>
                                    <asp:TextBox runat="server" ID="txtDesc" CssClass="form-control" />
                                </div>
                                <div runat="server" id="divActive" class="col-md-12 form-group">
                                    <label>Activo:</label>
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
                                <p style="text-align: center;">Lista de buzones</p>
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