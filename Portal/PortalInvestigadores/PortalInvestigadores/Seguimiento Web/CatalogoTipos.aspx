<%@ Page  Language="C#" AutoEventWireup="true" CodeBehind="CatalogoTipos.aspx.cs" Inherits="Portal_Investigadores.CatalogoTipos" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Configuracion catalogo tipos | Portal Responsables</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css' />
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"/>
    <link rel="shortcut icon" href="favicon.ico" />
    <link href="css/especiales.css" rel="stylesheet" />
    <link href="css/altaMensaje.css" rel="stylesheet"/>
    <script src="scripts/events.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
        <script type="text/javascript">

        </script>

    <form id="form" runat="server">
        <div class="container">
            <div runat="server" class="row" style="margin-top:21px;">
                <div class="table-header" style="padding-bottom: 27px; text-align: center;">Configuracion de tipos</div>
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p style="text-align: center;">Agregar Tipo</p>
                        </div>
                        <div class="panel-body">
                            <div class="form-group col-md-12">
                                <label>Tipo</label>
                                <asp:TextBox runat="server" ID="txtTipo" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-12">
                                <label>Descripcion</label>
                                <asp:TextBox runat="server" ID="txtDesc" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="panel-footer" style="height: 60px;">
                            <asp:Button runat="server" ID="btnAdd" CssClass="btn btn-primary btn-lg" Text="Agregar" OnClick="agregarTipo" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p style="text-align:center;">Lista de Tipos:</p>
                        </div>
                        <div class="panel-body">
                            <div style="overflow-y:scroll; height:200px">
                               <asp:GridView CssClass="table-responsive strip table-dashboard table-hover table-bordered table" runat="server" ID="tipoGV" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="tipo" HeaderText="Tipo" />
                                    <asp:BoundField DataField="desc" HeaderText="Descripcion" />
                                </Columns>                          
                             </asp:GridView>
                           </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</body>
</html>