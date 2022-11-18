<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GestionBuzones.aspx.cs" Inherits="Seguimiento_Web.PortalQuejas" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
 <form runat="server">
    <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="table-header" style="padding-bottom: 27px; text-align: center;">Gestion de Buzones</div>
            <div class="row justify-content-start" style="padding-bottom:2%">               

                                <div class="col-4 ">
                                    <label>Grupo</label>
                                    <asp:DropDownList  AutoPostBack="True" OnSelectedIndexChanged="Sel_Change_Grupo" runat="server" ID="dlGrupo" CssClass="form-control" ></asp:DropDownList>
                                </div>
                                <div class="col-4 ">
                                    <label>Empresa</label>
                                    <asp:DropDownList  AutoPostBack="True" OnSelectedIndexChanged="Sel_Change_Empresa" runat="server" ID="dlEmpresa" CssClass="form-control" ></asp:DropDownList>
                                </div>
                                <div  class="col-4 ">
                                  <label>Buzon</label>
                                    <asp:DropDownList  AutoPostBack="True" OnSelectedIndexChanged="Sel_Change_Buzon"  runat="server" ID="dlBuzon" CssClass="form-control" ></asp:DropDownList>
                                </div>
                                <div class="col-4 ">
                                    <label>Logo</label>
                                    <asp:FileUpload id="flLogo"  runat="server"> </asp:FileUpload>
                                </div>

                                <div class="col-2 ">
                                     <label>Proceso Cierre</label>
                                    <asp:CheckBox runat="server" ID="cbCierre" CssClass="form-control"/>
                                </div>
                               <div class="col-2 ">
                                     <label>Proceso Comite</label>
                                    <asp:CheckBox runat="server" ID="cbComite" CssClass="form-control"/>
                                </div>
                                <div class="col-2 ">
                                     <label>Activo</label>
                                    <asp:CheckBox runat="server" ID="cbActivo" CssClass="form-control"/>
                                </div>                              
                </div>
            <div class="row justify-content-start"  style="padding-bottom:2%">

                                    <div class=" col-3">
                                        <asp:Button runat="server" ID="btnAdd"  CssClass="btn btn-primary" Text="Agregar" OnClick="agregarBuzon" />                                                            
                                    </div>
                                     <div class=" col-6">
         
                                    </div>
                                    <div class=" col-3">
                                        <asp:Button runat="server" ID="btnEdit"  CssClass="btn btn-success" Text="Editar" OnClick="editarBuzon" />
                                    </div>
            </div>
            <div class="row" style="padding-bottom:2%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvBuzon" AutoGenerateColumns="false" OnRowDataBound="OnRowDataBound">
                                    <Columns>
                                      <asp:TemplateField HeaderText="Logo">
                                        <ItemTemplate>
                                            <asp:Image ID="Img" runat="server" Width="80px" Height="80px" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        <asp:CheckBoxField DataField="ProcesoCierre" HeaderText="ProcesoCierre" />
                                        <asp:CheckBoxField DataField="ProcesoComite" HeaderText="ProcesoComite" />
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>

              
               <div class="row" style="padding-bottom:2%"> 
                    <div class="table-header" style="padding-bottom: 27px; text-align: center;">Usuarios</div>
             </div>
            <div class="row justify-content-start" style="padding-bottom:2%" >
                <div class="col-3 ">
                    <div><label>Usuarios Investigador</label></div>
                    <div><asp:DropDownList  runat="server" ID="dlInvestigador" CssClass="form-control"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarInv"  CssClass="btn btn-primary" Text="Agregar" OnClick="agregarUsrInv" /></div>
                  </div>
                   <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnActivarInv"  CssClass="btn btn-info" Text="Activar/Desactivar" /></div>
                  </div>
            </div>
            <div class="row" style="padding-bottom:2%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView AutoGenerateSelectButton="true" CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvInv" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />   
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>


            <div class="row justify-content-start" style="padding-bottom:2%" >
                <div class="col-3 ">
                    <div><label>Usuarios Vobo</label></div>
                    <div><asp:DropDownList   runat="server" ID="dlVobo" CssClass="form-control"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarVobo"  CssClass="btn btn-primary" Text="Agregar" OnClick="agregarUsrVobo" /></div>
                  </div>
                   <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnActivarVobo"  CssClass="btn btn-info" Text="Activar/Desactivar" /></div>
                  </div>
            </div>

                      <div class="row" style="padding-bottom:2%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView AutoGenerateSelectButton="true"  CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvVobo" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />   
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>
             
            <div class="row justify-content-start" style="padding-bottom:2%" >
                <div class="col-2 ">
                      <label>Proceso Cierre</label>
                      <asp:CheckBox  AutoPostBack="true" runat="server" ID="cbCierreUsr" CssClass="form-control" OnCheckedChanged="ChkChangedCierre" Enabled="false"/>
                  </div>
                <div class="col-3 ">
                    <div><label>Usuarios</label></div>
                    <div><asp:DropDownList  runat="server" ID="dlCierreUsr" CssClass="form-control" Enabled="false"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarCierreUsr"  CssClass="btn btn-primary"  Text="Agregar" Enabled="false" OnClick="agregarUsrCierre" /></div>
                  </div>
                   <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnActivarCierreUsr"  CssClass="btn btn-info" Text="Activar/Desactivar" /></div>
                  </div>
            </div>

                      <div class="row" style="padding-bottom:2%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView AutoGenerateSelectButton="true"  CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvCierre" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />   
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>


             <div class="row justify-content-start" style="padding-bottom:2%" >
                 <div class="col-2 ">
                     <label>Proceso Comite</label>
                     <asp:CheckBox  AutoPostBack="true" runat="server" ID="cbComiteUsr" CssClass="form-control" OnCheckedChanged="ChkChangedComite" Enabled="false"/>
                 </div>
                <div class="col-3 ">
                    <div><label>Usuarios</label></div>
                    <div><asp:DropDownList  runat="server" ID="dlComiteUsr" CssClass="form-control" Enabled="false"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarComiteUsr"  CssClass="btn btn-primary" Text="Agregar"  Enabled="false" OnClick="agregarUsrComite"  /></div>
                  </div>
                  <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnActivarComiteUsr"  CssClass="btn btn-info" Text="Activar/Desactivar" /></div>
                  </div>
            </div>

                      <div class="row" style="padding-bottom:2%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header bg-primary text-white">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView AutoGenerateSelectButton="true" CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvComite" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />   
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


