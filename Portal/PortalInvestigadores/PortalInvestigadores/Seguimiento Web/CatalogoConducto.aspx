<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="CatalogoConducto.aspx.cs" Inherits="Portal_Investigadores.CatalogoConducto" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
         <div class="row">
            <div class="table-header" style="padding-bottom: 27px; text-align: center;">Catalogo de conductos y casos</div>
            <div class="col-md-6 col-xs-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <p style="text-align: center;">Agregar Conducto</p>
                    </div>
                    <div class="card-body">
                        <div class="form-group col-md-12 col-xs-12">
                            <label>Conducto</label>
                            <asp:TextBox runat="server" ID="txtConducto" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-12 col-xs-12">
                            <label>Descripcion</label>
                            <asp:TextBox runat="server" ID="txtDescr" CssClass="form-control" />
                        </div>
                        <div runat="server" id="divActive" class="col-md-12 form-group">
                            <label>Activo:</label>
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
                        <p style="text-align: center;">Lista de conducto</p>
                    </div>
                    <div class="card-body">
                        <div style="overflow-y:scroll; height:200px">
                            <asp:GridView AutoGenerateSelectButton="true" OnSelectedIndexChanged="conductoGV_SelectedIndexChanged" CssClass="table-responsive strip table-dashboard table-hover table-bordered table" runat="server" ID="conductoGV" AutoGenerateColumns="false">
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
                        <p style="text-align:center;">Agregar Forma</p>
                    </div>
                    <div class="card-body">
                        <div class="form-group col-md-12 col-xs-12">
                            <label>Conducto</label>
                            <asp:TextBox runat="server" ID="txtCond" Enabled="false" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-12 col-xs-12">
                            <label>Forma</label>
                            <asp:TextBox runat="server" ID="txtForma" CssClass="form-control" />
                        </div>
                        <div class="form-group col-md-12 col-xs-12">
                            <label>Descripcion</label>
                            <asp:TextBox runat="server" ID="desc" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="col-sm-12 row">
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnAddForma" OnClick="addForma" CssClass="btn btn-primary" Text="Agregar"/>
                            </div>
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnEditForma" CssClass="btn btn-success" Text="Editar" Enabled="false" />
                            </div>
                            <div class="form-group col-sm-4">
                                <asp:Button runat="server" ID="btnCancelForma" CssClass="btn btn-danger" Text="Cancelar" Enabled="false" />
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
                        <p style="text-align:center;">Formas</p>
                    </div>
                     <div class="card-body">
                        <div style="overflow-y:scroll; height:200px">
                            <asp:GridView AutoGenerateSelectButton="true" CssClass="table-responsive strip table-dashboard table-hover table-bordered table" runat="server" ID="formaGV" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="forma" HeaderText="Conducto" />
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