<%@ Page Title="Log Out | Seguimiento" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SignOut.aspx.cs" Inherits="Portal_Investigadores.SignOut" %>
 <asp:Content id="id1" ContentPlaceHolderID="menu" runat="server">
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container-fluid" id="hola">
                <div class="navbar-header">
                    <img src="img/ALFA_logo.svg.png" width="90" />
                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#"><span class="glyphicon glyphicon-user"></span><%=Session["username"]%></a></li>
                    <li><a href="PlanAccion.aspx">Plan Acción</a></li>
                    <li><a href="Agrupada.aspx">Agrupados</a></li>
                    <li  class="active"><a href="SignOut.aspx"><span class="glyphicon glyphicon-log-out"></span>Sign Out</a></li>
                </ul>
            </div>
        </nav>
    </asp:Content>

