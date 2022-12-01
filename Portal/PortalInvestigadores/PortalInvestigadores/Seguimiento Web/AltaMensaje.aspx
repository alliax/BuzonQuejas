<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AltaMensaje.aspx.cs" Inherits="Portal_Investigadores.AltaMensaje" %>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <form id="form" runat="server">
        <link href="css/especiales.css" rel="stylesheet" />
    <div class="container">
        <div class="row"style="margin-top:21px;">
            <div class="table-header" runat="server" id="msgId" style="padding-bottom: 27px; text-align: center;">Nuevo Mensaje</div>                                
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                Información General
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label for="inputTitulo">Título</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtTitulo"/>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label for="inputClasificacion">Clasificación</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlClasificacion">
                                        <asp:ListItem Selected="True" Value="White"> White </asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="inputResponsable">Responsable</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlResponsable">
                                        <asp:ListItem Selected="True" Value="White"> White </asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                Fechas
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label for="fechaRegistro">Registro</label>
                                <asp:TextBox Width="100%" runat="server" CssClass="form-control" ID="fechaRegistro" Enabled="false" TextMode="DateTime"/>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="fechaClasificacion">Clasificación</label>
                                <asp:TextBox Width="100%" runat="server" CssClass="form-control" ID="fechaClasificacion" Enabled="false" TextMode="DateTime" />
                            </div>
                            <div class="form-group col-md-12">
                                <label for="ultimaAct">Última Actualización</label>
                                <asp:TextBox Width="100%" runat="server" CssClass="form-control" ID="ultimaActualizacion" Enabled="false" TextMode="DateTime"/>
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-3 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                                Ubicación
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label for="selGrupo">Grupo</label>
                                <asp:DropDownList Enabled="false" runat="server" CssClass="form-control" ID="ddlGrupo" />                                                                    
                            </div>
                            <div class="form-group col-md-12">
                                <label for="selEmpresa">Empresa</label>
                                <asp:DropDownList Enabled="false" runat="server" CssClass="form-control" ID="ddlEmpresa" />                                                                    
                            </div>
                            <div class="form-group col-md-12">
                                <label for="selSitio">Sitio</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlSitio">
                                    <asp:ListItem Selected="True">Sitio</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                             <div class="form-group col-md-12">
                                <label for="selDepartamento">Departamento</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlDepartamento">
                                    <asp:ListItem Selected="True">Departamento</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                 <!---->
                <div class="col-md-6 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                Denunciante
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label for="inputNombre">Nombre</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtNombre" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="inputGrupo">Correo</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtCorreo" placeholder="info@example.com"/>
                                </div>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label for="inputGrupo">Apellido Paterno</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtPaterno" />
                                </div>
                                    <div class="form-group col-md-6">
                                    <label for="inputGrupo">Apellido Materno</label>
                                    <asp:TextBox runat="server"  CssClass="form-control" ID="txtMaterno" />
                                </div>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6">
                                    <label for="inputTelefono">Teléfono</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtTelefono" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="inputTipo">Tipo</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlTipo" />                                                                    
                                </div>
                            </div>
                            <div class="col-md-12 form-row">
                                <div class="form-group col-md-6 col-xs-6">
                                    <label for="checkAnonimo">Anónimo</label>
                                    <asp:CheckBox runat="server" ID="chbkAnonimo" />
                                </div>
                                <div class="form-group col-md-6 col-xs-6">
                                    <label for="chbkSolAnonimo">Solicitud Anónimo</label>
                                    <asp:CheckBox runat="server" ID="chbkSolAnonimo" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-inbox" aria-hidden="true"></span>
                                Mensaje
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label for="selImportancia">Importancia</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlImportancia" />                                                                    
                            </div>
                            <div class="form-group col-md-12">
                                <label for="selConducto">Conducto</label>
                                <asp:DropDownList OnSelectedIndexChanged="ddlConducto_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control" ID="ddlConducto" />                                                                    
                            </div>                            
                            <div class="form-group col-md-12">
                                <label for="selForma">Forma</label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlForma" />
                            </div>
                        </div>
                    </div>
                </div>
                <!---->
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-text-color" aria-hidden="true"></span>
                                Mensaje
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label>Nuevo: Visible para auditoría</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtMensaje2"/>
                            </div>
                            <div class="form-group col-md-12">
                                <label>Detalle </label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtDetalle" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Resumen</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtResumen" />
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
                                Tema y Subtema
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="selTema">Tema</label>
                                    <asp:DropDownList OnSelectedIndexChanged="ddlTema_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control" ID="ddlTema" />                                
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="selSubtema">Subtema</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlSubtema" />                                
                                </div>
                                <div class="form-group col-md-4">
                                    <label>Documentos</label>
                                    <button type="button" class="btnFile btn-primary">
                                        <span class="glyphicon glyphicon-file" aria-hidden="true">Subir documentos</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                 <div class="col-md-7">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                Involucrados
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <asp:TextBox runat="server" CssClass="form-control" ID="invNombre" placeholder="Nombre"/>
                            </div>
                            <div class="form-group col-md-12">
                                <asp:TextBox runat="server" CssClass="form-control" ID="invApellido" placeholder="Apellido" />
                            </div>
                            <div class="form-group col-md-12">
                                <asp:TextBox runat="server" CssClass="form-control" ID="invPuesto" placeholder="Puesto" />
                            </div>
                            <div class="form-group col-md-12">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlPosicion" />                                
                            </div>
                            <div class="form-group col-md-4">
                                <asp:Button runat="server" CssClass="btn btn-primary" ID="btnAddInv" Text="Guardar" />
                            </div>    
                            <div class="col-md-12" id="divInvolucrados">
                                <asp:GridView ID="gvResponsables" runat="server" OnRowDataBound="gvResponsables_RowDataBound" CssClass="strip table table-hover table-dashboard">
                                    <Columns>
                                        
                                        <asp:HyperLinkField Text ="Editar"
                                            DataNavigateUrlFields="idusuario"
                                            DataNavigateUrlFormatString="Responsable.aspx?id={0}"  ControlStyle-CssClass ="btn-detail"  />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>                
                    </div>
                </div>
            <!---->
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span>
                                Asociar
                            </p>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-6 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p> 
                                <span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
                                Comentarios Internos
                            </p>
                        </div>
                        <div class="card-body">
                            <h1>Mensajes Usuarios y Sistema</h1>
                        </div>
                        <div class="card-footer">
                            <div class="input-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtMsg" max-length="400" placeholder="Escribe tu mensaje.."/>
                                <span class="input-group-btn">
                                    <asp:TextBox runat="server" onclick="addMessage()" Text="Enviar" CssClass="form-control btn btn-warning" type="submit"/>
                                </span>                                    
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
                <div class="col-md-6 col-xs-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <p>
                                <span class="glyphicon glyphicon-send" aria-hidden="true"></span>
                                Asignación de Responsable y Area
                            </p>
                        </div>
                        <div class="card-body">
                            <div class="form-group col-md-12">
                                <label>Área Asignada</label>
                                <div class="inputGroupContainer">
                                    <div class="input-group">
                                        <span class="input-group-addon" aria-hidden="true" style="max-width: 100%;">
                                            <i class="glyphicon glyphicon-list"></i>
                                        </span>
                                        <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control" />                                         
                                    </div>
                                </div>
                            </div>
                            <div class="form-row" style="padding-bottom: 10px;">
                                <p>Responsable</p>
                            </div>
                            <div class="col-md-12">
                                <div class="form-row form-group">
                                    <label class="col-sm-4 ">Grupo</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList Enabled="false" runat="server" CssClass="form-control" ID="ddlGrupo2" />                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-row form-group">
                                    <label class="col-sm-4">Responsable</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList OnSelectedIndexChanged="ddlResponsable2_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control form-control-sm" ID="ddlResponsable2" />                                            
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <div class="input-group mb-3">
                                  <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">@</span>
                                  </div>
                                  <asp:TextBox runat="server" CssClass="form-control" ID="txtEmail" Enabled="false"/>
                                </div>
                            </div>                            
                            <div class="form-group form-row col-md-12">
                                <label class="col-sm-2 col-form-label">Revisor</label>
                                <div class="form-group col-sm-5">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtRevisor" Enabled="false"/>
                                </div>
                                <div class="form-group col-sm-5">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="revisorEmail" Enabled="false" />
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <asp:CheckBox runat="server" ID="revisorInc" />
                                <label for="chbkRevisor">Deseas incluir al revisor?</label>
                            </div>
                            <div class="col-md-12">
                                <label>Enterados</label>
                                <asp:TextBox runat="server" ID="enterados" Width="100%" TextMode="MultiLine" Wrap="true" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
            <!---->
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contenido2" runat="server">
</asp:Content>