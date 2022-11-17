<%@ Page  MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="UsuarioBuzon.aspx.cs" Inherits="Portal_Investigadores.UsuarioBuzon" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server" id="form">
        <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="row" style="margin-top:21px;">
                <div class="table-header">
                    Buzón de Quejas - Gestión de Usuarios
                </div>
                <div class="form-group col-md-12">
                    <label for="inputUsuario">Usuario</label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="txtIdUsuario" style="display:none;" />
                    <asp:TextBox runat="server" CssClass="form-control" ID="txtUsuario" />
                </div>
                <div class="form-group col-md-12">
                    <label for="inputFolio">Nombre*</label>
                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtNombre" />
                </div>
                <div class="form-group col-md-6">
                    <label for="inputEmpresa">Grupo*</label>
                    <asp:DropDownList ID="ddlGrupo" runat="server" CssClass="form-control" AutoPostBack="false" >                        
                    </asp:DropDownList>
                </div>
                
                <div class="form-group col-md-6">
                    <label for="inputSitio">Empresa*</label>
                    <asp:DropDownList ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="false">                                    
                    </asp:DropDownList>
                </div>
                <div class="row col-md-12" style="width: 100%;">
                    <div class="form-group col-md-4">
                        <label for="inputBuzon">Buzón</label>
                        <asp:DropDownList ID="ddlBuzon" runat="server" CssClass="form-control" AutoPostBack="false">
                        </asp:DropDownList>
                    </div>
                    <div class="form-group col-md-4">
                        <asp:Button runat="server" ID="btnUpdate" Text="Actualizar" CssClass="btn btn-primary" />
                    </div>
                    <div class="form-group col-md-4">
                        <asp:Button runat="server" ID="btnEdit" Text="Editar" CssClass="btn btn-primary" />
                    </div>
                </div>
                <div class="form-group col-md-2">
                    <label for="inputResumen">Es Delegado</label>
                    <asp:CheckBox runat="server" ID="chbkDelegado" CssClass="form-control"/>
                </div>
  
                <div class="form-group col-md-2">
                    <label for="inputTitulo">Es Investigador</label>
                    <asp:CheckBox runat="server" ID="chbkInvestigador" CssClass="form-control"/>
                    <asp:TextBox runat="server" ID="txtDenunciasInvestigador" CssClass="form-control" />
                </div>

                <div class="form-group col-md-2">
                    <label for="inputResumen">Es Revisor</label>
                    <asp:CheckBox runat="server" ID="chbkRevisor" CssClass="form-control"/>
                    <asp:TextBox runat="server" ID="txtDenunciasRevisor" CssClass="form-control" />
                </div>

                <div class="form-group col-md-2">
                    <label for="inputResumen">Es Enterado</label>
                    <asp:CheckBox runat="server" ID="chbkEnterado" CssClass="form-control"/>
                </div>

                 <div class="form-group col-md-2">
                    <label for="inputResumen">Administrador de Quejas</label>
                    <asp:CheckBox runat="server" ID="chbkAdmin" CssClass="form-control"/>
                </div>

                <div class="form-group col-md-2">
                    <label for="inputResumen">Activo</label>
                    <asp:CheckBox runat="server" ID="chbkActivo" CssClass="form-control"/>
                </div>
                <div class="form-group col-md-4 offset-md-4">
                    <asp:Button runat="server" ID="btnCancel" Text="regresar" CssClass="btn btn-secondary" />
                </div>
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
