using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using Portal_Investigadores.clases;


namespace Portal_Investigadores
{
    public partial class UsuarioBuzon : Page
    {
        DBHelper DBHelper = new DBHelper();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int id = int.Parse(Request.QueryString["id"]);
                txtNombre.Text = Request.QueryString["nombre"];
                txtIdUsuario.Text = id.ToString();
                txtUsuario.Text = Request.QueryString["usuario"];
                ddlGrupo.SelectedItem.Text = Request.QueryString["grupo"];
                ddlEmpresa.SelectedValue = Request.QueryString["empresa"];

            }
        }

 

 
    }
}