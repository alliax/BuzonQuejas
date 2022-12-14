<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GestionBuzones.aspx.cs" Inherits="Seguimiento_Web.PortalQuejas" %>


<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<style>
    .hidden-field
    {
        display: none;
    }
</style>
<script type="text/javascript">
$(document).ready(function () {
    var Idioma = '<%=HttpContext.Current.Session["idioma"]%>'
    $.ajax({
        type: "GET",
        url: "CatalogoTipos.aspx/BQ_Etiquetas",
        data: $.param({ iId: 1, iIdioma: Idioma }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {

            Json = createJson(r);
            for (i = 0; i <= Json.length - 1; i++) {
                if (Json[i].Id == 29) { $("#lbl1").html(Json[i].Texto) }
                if (Json[i].Id == 30) { $("#lbl2").html(Json[i].Texto) }
                if (Json[i].Id == 31) { $("#lbl3").html(Json[i].Texto) }
                if (Json[i].Id == 32) { $("#lbl4").html(Json[i].Texto) }
                if (Json[i].Id == 33) { $("#lbl5").html(Json[i].Texto) }
                if (Json[i].Id == 34) { $("#lbl6").html(Json[i].Texto); $("#lbl14").html(Json[i].Texto); $("#lbl15").html(Json[i].Texto);}
                if (Json[i].Id == 42) { $("#lbl7").html(Json[i].Texto); $("#lbl17").html(Json[i].Texto); }     
                if (Json[i].Id == 10) { $("#lbl8").html(Json[i].Texto) }  
                if (Json[i].Id == 36) { $("#lbl9").html(Json[i].Texto) }
                if (Json[i].Id == 35) { $("#lbl10").html(Json[i].Texto); $("#lbl12").html(Json[i].Texto); $("#lbl15").html(Json[i].Texto); $("#lbl18").html(Json[i].Texto); }
                if (Json[i].Id == 37) { $("#lbl11").html(Json[i].Texto) }
                if (Json[i].Id == 38) { $("#lbl13").html(Json[i].Texto) }
                if (Json[i].Id == 39) { $("#lbl16").html(Json[i].Texto); }
                


                if (Json[i].Id == 1) { $("#<%=btnAdd.ClientID%>").val(Json[i].Texto); $("#<%=btnAgregarInv.ClientID%>").val(Json[i].Texto); $("#<%=btnAgregarVobo.ClientID%>").val(Json[i].Texto); $("#<%=btnAgregarCierreUsr.ClientID%>").val(Json[i].Texto); $("#<%=btnAgregarComiteUsr.ClientID%>").val(Json[i].Texto); }
                if (Json[i].Id == 2) { $("#<%=btnEdit.ClientID%>").val(Json[i].Texto);  }
                if (Json[i].Id == 3) { $("#<%=btnEliminarInv.ClientID%>").val(Json[i].Texto); $("#<%=btnEliminarVobo.ClientID%>").val(Json[i].Texto); $("#<%=btnEliminarCierreUsr.ClientID%>").val(Json[i].Texto); $("#<%=btnEliminarComiteUsr.ClientID%>").val(Json[i].Texto); }
                if (Json[i].Id == 40) { $("#<%=btnSubirCierreUsr.ClientID%>").val(Json[i].Texto); $("#<%=btnSubirComiteUsr.ClientID%>").val(Json[i].Texto); }
                if (Json[i].Id == 41) { $("#<%=btnBajarCierreUsr.ClientID%>").val(Json[i].Texto); $("#<%=btnBajarComiteUsr.ClientID%>").val(Json[i].Texto); }
            }


            },
            error: function (r) {
                alert(r);
            }
        }); 



    }); // Document Ready
           
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


 <form runat="server">
    <link href="css/especiales.css" rel="stylesheet" />
        <div class="container">
            <div class="table-header" style="padding-bottom: 27px; text-align: center;" id ="lbl1">Gestion de Buzones</div>
            <div class="row justify-content-start" style="padding-bottom:2%">               

                                <div class="col-4 ">
                                    <label id ="lbl2">Grupo</label>
                                    <asp:DropDownList  AutoPostBack="True" OnSelectedIndexChanged="Sel_Change_Grupo" runat="server" ID="dlGrupo" CssClass="form-control" ></asp:DropDownList>
                                </div>
                                <div class="col-4 ">
                                    <label id ="lbl3">Empresa</label>
                                    <asp:DropDownList  AutoPostBack="True" OnSelectedIndexChanged="Sel_Change_Empresa" runat="server" ID="dlEmpresa" CssClass="form-control" ></asp:DropDownList>
                                </div>
                                <div  class="col-4 ">
                                  <label id ="lbl4">Buzon</label>
                                    <asp:DropDownList  AutoPostBack="True" OnSelectedIndexChanged="Sel_Change_Buzon"  runat="server" ID="dlBuzon" CssClass="form-control" ></asp:DropDownList>
                                </div>
                                <div class="col-4 ">
                                    <label id ="lbl5">Logo</label>
                                    <asp:FileUpload id="flLogo"  runat="server"> </asp:FileUpload>
                                </div>

                                <div class="col-2 ">
                                     <label id ="lbl6">Proceso Cierre</label>
                                    <asp:CheckBox runat="server" ID="cbCierre" CssClass="form-control"/>
                                </div>
                               <div class="col-2 ">
                                     <label id ="lbl7">Proceso Comite</label>
                                    <asp:CheckBox runat="server" ID="cbComite" CssClass="form-control"/>
                                </div>
                                <div class="col-2 ">
                                     <label id ="lbl8">Activo</label>
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
            <div class="row" style="padding-bottom:5%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
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

              
               <div class="row"> 
                    <div class="table-header" style="padding-bottom: 27px; text-align: center;" id ="lbl9">Usuarios Investigador</div>
             </div>
            <div class="row justify-content-start" style="padding-bottom:2%" >
                <div class="col-3 ">
                    <div><label id ="lbl10">Usuarios</label></div>
                    <div><asp:DropDownList  runat="server" ID="dlInvestigador" CssClass="form-control"></asp:DropDownList></div>
                </div>
                <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarInv"  CssClass="btn btn-primary" Text="Agregar" OnClick="agregarUsrInv" /></div>
                  </div>
                   <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnEliminarInv"  CssClass="btn btn-danger" Text="Eliminar" OnClick="eliminarUsrInv" /></div>
                  </div>
            </div>
            <div class="row" style="padding-bottom:5%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvInv" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField>  
                                        <EditItemTemplate>  
                                            <asp:CheckBox ID="Chk1" runat="server" />  
                                        </EditItemTemplate>  
                                        <ItemTemplate>  
                                            <asp:CheckBox ID="Chk1" runat="server" />  
                                        </ItemTemplate>  
                                        </asp:TemplateField>  
                                        <asp:BoundField DataField="IdUsuarioBQ" HeaderText="Id"  ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"/>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia"  ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"/>
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field" />   
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>

              <div class="row"> 
                    <div id ="lbl11" class="table-header" style="padding-bottom: 27px; text-align: center;">Usuarios Vobo</div>
             </div>
            <div class="row justify-content-start" style="padding-bottom:2%" >
                <div class="col-3 ">
                    <div><label id ="lbl12">Usuarios</label></div>
                    <div><asp:DropDownList   runat="server" ID="dlVobo" CssClass="form-control"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarVobo"  CssClass="btn btn-primary" Text="Agregar" OnClick="agregarUsrVobo" /></div>
                  </div>
                   <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnEliminarVobo"  CssClass="btn btn-danger" Text="Eliminar" OnClick="eliminarUsrVobo" /></div>
                  </div>
            </div>

                      <div class="row" style="padding-bottom:5%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView   CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvVobo" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField>  
                                        <EditItemTemplate>  
                                            <asp:CheckBox ID="Chk2" runat="server" />  
                                        </EditItemTemplate>  
                                        <ItemTemplate>  
                                            <asp:CheckBox ID="Chk2" runat="server" />  
                                        </ItemTemplate>  
                                        </asp:TemplateField>  
                                        <asp:BoundField DataField="IdUsuarioBQ" HeaderText="Id"  ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"/>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia"  ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"/>
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field" /> 
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>

               <div class="row"> 
                    <div id ="lbl13" class="table-header" style="padding-bottom: 27px; text-align: center;">Usuarios Proceso Cierre</div>
             </div>
             
            <div class="row justify-content-start" style="padding-bottom:2%" >
                <div class="col-2 ">
                      <label id ="lbl14">Proceso Cierre</label>
                      <asp:CheckBox  AutoPostBack="true" runat="server" ID="cbCierreUsr" CssClass="form-control" OnCheckedChanged="ChkChangedCierre" Enabled="false"/>
                  </div>
                <div class="col-3">
                    <div><label id ="lbl15">Usuarios</label></div>
                    <div><asp:DropDownList  runat="server" ID="dlCierreUsr" CssClass="form-control" Enabled="false"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarCierreUsr"  CssClass="btn btn-primary"  Text="Agregar" Enabled="false" OnClick="agregarUsrCierre" /></div>
                  </div>
                   <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnEliminarCierreUsr"  CssClass="btn btn-danger" Text="Eliminar" OnClick="eliminarUsrCierre"  Enabled="false" /></div>
                  </div>
                  <div class="col-1">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnSubirCierreUsr"  CssClass="btn btn-info" Text="Subir" OnClick="SubirSecCierre"  Enabled="false" /></div>
                  </div>
                  <div class="col-1">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnBajarCierreUsr"  CssClass="btn btn-info" Text="Bajar" OnClick="BajarSecCierre"  Enabled="false" /></div>
                  </div>
            </div>

                      <div class="row" style="padding-bottom:5%">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView  CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvCierre" AutoGenerateColumns="false" >
                                    <Columns>
                                        <asp:TemplateField>  
                                        <EditItemTemplate>  
                                            <asp:CheckBox ID="Chk3" runat="server" />  
                                        </EditItemTemplate>  
                                        <ItemTemplate>  
                                            <asp:CheckBox ID="Chk3" runat="server" />  
                                        </ItemTemplate>  
                                        </asp:TemplateField>  
                                        <asp:BoundField DataField="IdUsuarioBQ" HeaderText="Id"  ReadOnly="true"   ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"/>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre"  ReadOnly="true"  />     
                                       <asp:CheckBoxField DataField="Activo" HeaderText="Activo"  ReadOnly="true"  ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field" />
                                    </Columns>                          
                                   </asp:GridView>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>

             <div class="row"> 
                    <div id ="lbl16" class="table-header" style="padding-bottom: 27px; text-align: center;">Usuarios Comite</div>
             </div>
             <div class="row justify-content-start" style="padding-bottom:2%" >
                 <div class="col-2 ">
                     <label id ="lbl17" >Proceso Comite</label>
                     <asp:CheckBox AutoPostBack="true"  runat="server" ID="cbComiteUsr" CssClass="form-control" OnCheckedChanged="ChkChangedComite" Enabled="false"/>
                 </div>
                <div class="col-3 ">
                    <div><label id ="lbl18">Usuarios</label></div>
                    <div><asp:DropDownList  runat="server" ID="dlComiteUsr" CssClass="form-control" Enabled="false"></asp:DropDownList></div>
                </div>
                 <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnAgregarComiteUsr"  CssClass="btn btn-primary" Text="Agregar"  Enabled="false" OnClick="agregarUsrComite"  /></div>
                  </div>
                  <div class="col-2 ">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnEliminarComiteUsr"  CssClass="btn btn-danger" Text="Eliminar" OnClick="eliminarUsrComite"  Enabled="false" /></div>
                  </div>
                  <div class="col-1">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnSubirComiteUsr"  CssClass="btn btn-info" Text="Subir" OnClick="SubirSecCom"  Enabled="false" /></div>
                  </div>
                  <div class="col-1">
                     <div><label></label></div>
                    <div><asp:Button runat="server" ID="btnBajarComiteUsr"  CssClass="btn btn-info" Text="Bajar" OnClick="BajarSecCom"  Enabled="false" /></div>
                  </div>
            </div>

                 <div class="row">
                      <div class="col-md-12 col-lg-12">
                         <div class="card">
                            <div class="card-header text-white" style="background:#4E8ABE">
                                <p style="text-align: center;"></p>
                            </div>
                            <div class="card-body">
                               <div style="overflow-y:scroll; height:150px">
                                 <asp:GridView  CssClass="table table-hover" RowStyle-CssClass="tdtable" HeaderStyle-CssClass="thead-light" runat="server" ID="gvComite" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField>  
                                        <EditItemTemplate>  
                                            <asp:CheckBox ID="Chk4" runat="server" />  
                                        </EditItemTemplate>  
                                        <ItemTemplate>  
                                            <asp:CheckBox ID="Chk4" runat="server" />  
                                        </ItemTemplate>  
                                        </asp:TemplateField>  
                                        <asp:BoundField DataField="IdUsuarioBQ" HeaderText="Id"  ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"/>
                                        <asp:BoundField DataField="Secuencia" HeaderText="Secuencia" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />     
                                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field" />   
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


