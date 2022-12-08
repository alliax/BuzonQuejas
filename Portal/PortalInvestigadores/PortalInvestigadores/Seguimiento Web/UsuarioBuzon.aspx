<%@ Page  MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="UsuarioBuzon.aspx.cs" Inherits="Portal_Investigadores.UsuarioBuzon" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form runat="server" id="form">
        <link href="css/especiales.css" rel="stylesheet" />

        <script>

            var idUsuario = '<%= Session["idUsuario"] %>';

            $(document).ready(function () {

            });



        </script>



        <div class="container">
            <div class="row" style="margin-top:21px;">
                <div class="table-header">
                    Buzón de Quejas - Gestión de Usuarios
                </div>
                <div class="form-group col-md-12">
                    <label for="inputUsuario">Usuario</label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="txtIdUsuario" style="display:none;" />
                    <asp:TextBox runat="server" CssClass="form-control" ID="txtUsuario" Enabled="false"/>
                </div>
                <div class="form-group col-md-12">
                    <label for="inputFolio">Nombre*</label>
                    <asp:TextBox Enabled="false" runat="server"  CssClass="form-control" ID="txtNombre" />
                </div>
                <div class="form-group col-md-6">
                    <label for="inputEmpresa">Grupo*</label>
                    <asp:DropDownList Enabled="false" ID="ddlGrupo" runat="server" CssClass="form-control" AutoPostBack="false" >                        
                    </asp:DropDownList>
                </div>
                
                <div class="form-group col-md-6">
                    <label for="inputSitio">Empresa*</label>
                    <asp:DropDownList Enabled="false" ID="ddlEmpresa" runat="server" CssClass="form-control" AutoPostBack="false">                                    
                    </asp:DropDownList>
                </div>                
                <div class="form-group col-sm-4">
                    <label for="inputBuzon">Buzón</label>
                    <asp:DropDownList OnSelectedIndexChanged="ddlBuzon_SelectedIndexChanged" ID="ddlBuzon" runat="server" CssClass="form-control" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="form-group col-sm-4">
                    <asp:Button runat="server" ID="btnAdd" OnClick="agregarUsuarioBuzon" Text="Agregar" CssClass="btn btn-primary" />
                </div>
                <div class="form-group col-sm-4">
                    <asp:Button runat="server" ID="btnEdit" OnClick="editarUsuarioBuzon" Text="Editar" CssClass="btn btn-primary" />
                </div>                
                <div class="form-group col-md-2 ml-auto">
                    <label for="inputVobo">Es VoBo</label>
                    <asp:CheckBox runat="server" ID="chbkVobo" CssClass="form-control"/>
                </div>
                <div class="form-group col-md-2">
                    <label for="inputDelegado">Es Delegado</label>
                    <asp:CheckBox runat="server" ID="chbkDelegado" CssClass="form-control"/>
                </div>  
                <div class="form-group col-md-2">
                    <label for="inputInvestigador">Es Investigador</label>
                    <asp:CheckBox runat="server" ID="chbkInvestigador" CssClass="form-control"/>                    
                </div>
                <div class="form-group col-md-2">
                    <label for="inputRevisor">Es Revisor</label>
                    <asp:CheckBox runat="server" ID="chbkRevisor" CssClass="form-control"/>                    
                </div>
                <div class="form-group col-md-2">
                    <label for="inputEnterado">Es Enterado</label>
                    <asp:CheckBox runat="server" ID="chbkEnterado" CssClass="form-control"/>
                </div>
                 <div class="form-group col-md-2">
                    <label for="inputAdmin">Administrador Quejas</label>
                    <asp:CheckBox runat="server" ID="chbkAdmin" CssClass="form-control"/>
                </div>
                <div class="form-group col-md-2">
                    <label for="inputActivo">Activo</label>
                    <asp:CheckBox runat="server" ID="chbkActivo" CssClass="form-control"/>
                </div>
                <asp:Panel ID="panelSubtema" runat="server" Visible="false">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                      <asp:Label runat="server" ID="lbl" />
                      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                </asp:Panel>
                <div class="col-md-12">
                    <div style="overflow-y:scroll; height:200px">
                        <asp:GridView HeaderStyle-CssClass="thead-light" ShowHeaderWhenEmpty="true" CssClass="table-bordered table" runat="server" ID="usuariosGV" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="descripcion" HeaderText="Buzón" />                                
                                <asp:CheckBoxField DataField="BQEsVobo" HeaderText="Es Vobo" />
                                <asp:CheckBoxField DataField="EsInvestigador" HeaderText="Es Investigador" />
                                <asp:CheckBoxField DataField="EsDelegado" HeaderText="Es Delegado" />
                                <asp:CheckBoxField DataField="EsRevisor" HeaderText="Es Revisor" />
                                <asp:CheckBoxField DataField="EsEnterado" HeaderText="Es Enterado" />
                                <asp:CheckBoxField DataField="AdminQuejas" HeaderText="Administrador Quejas" />
                                <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                            </Columns>                          
                        </asp:GridView>
                    </div>
                </div>
                <div class="form-group col-md-4 offset-md-4">
                    <asp:Button runat="server" ID="btnCancel" Text="regresar" CssClass="btn btn-secondary" />
                </div>
            </div>

            <div runat="server" class="row" id="divRelaciones" style="margin-top:21px;display:none;">
                <div class="table-header"> Relaciones</div>


                <div class="form-group col-md-4" id="divSelDelegados" style="display:none;">
                        <label for="inputSitio">Selecciona Delegados</label>
                        <asp:DropDownList ID="ddlDelegados" runat="server" CssClass="form-control" AutoPostBack="false">
                                        <%--<asp:ListItem Text="Selecciona un Resultado" Value="0" />--%>
                        </asp:DropDownList>

                        <button id="agregarDelegado" type="button" style="margin-top: 10px;" class="btn btn-primary" onclick="return addDelegado();">Agregar</button>  

                        <div id="tableDelegados" style="display:none;     margin-top: 20px;" class="table-editable">
                                <table class="table table-bordered table-responsive-md table-striped text-center tblSoporte">  <%--style="width: 50%; margin-left: 24%;"--%>
                                    <thead>
                                        <tr>
                                            <th class="text-left">Delegados</th>
                                            <th class="text-left" style="width:85px;">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                    </div>

            </div>


        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>
