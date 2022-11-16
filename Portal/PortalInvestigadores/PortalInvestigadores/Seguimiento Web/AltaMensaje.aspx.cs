using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal_Investigadores.clases;
using System.Web.Http;
using System.Net;
using System.Text.RegularExpressions;

namespace Portal_Investigadores
{
    public partial class AltaMensaje : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();


        protected void Page_Load(object sender, EventArgs e)
        {
            fechaRegistro.Text = DateTime.Now.ToString("yyyy-MM-dd");
            //
            fechaClasificacion.Text = DateTime.Now.ToString("yyyy-MM-dd hh:mm tt");
            cargarClasificacciones();
            cargarResponsables();
            btnAddInv_Click(sender, e);
        }

        protected void cargarClasificacciones()
        {
            DBHelper DBHelper = new DBHelper();
           
        }

        protected void cargarResponsables()
        {
            DBHelper DBHelper = new DBHelper();
        }

        protected void btnAddInv_Click(object sender, EventArgs e)
        {
           
        }
    }
}