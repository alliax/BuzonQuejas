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
using Seguimiento_Web;
using System.Web.Script.Services;
using Newtonsoft.Json;
using System.Web.Hosting;

namespace Portal_Investigadores
{
    public partial class CatalogoAcciones : Page
    {
        DBHelper DBHelper = new DBHelper();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            error.Visible = false;
            if (!Page.IsPostBack)
            {
                cargarAcciones(1);
            }
        }

        protected void cargarAcciones(int idBQ)
        {
            DataTable acciones = DBHelper.getCatalogoAcciones("SELECT", idBQ);
            accionesGV.DataSource = acciones;
            accionesGV.DataBind();
            ViewState["acciones"] = acciones;
        }

        

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_Etiquetas(int iId, int iIdioma)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dtEtiquetas = DBHelper.getBQEtiquetas(iId, iIdioma);
            string str = JsonConvert.SerializeObject(dtEtiquetas);
            return (str);

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string output;
            string user = Session["nomUsuario"].ToString();
            if (txtAccion.Text != "" && txtDesc.Text != "")
            {
                output = DBHelper.saveAccion("INSERT", user, 1, txtAccion.Text, txtDesc.Text, cbAct.Checked, 0);
                if (output == "OK")
                {
                    cargarAcciones(1);
                    limpiarForm();
                } else
                {
                    error.Visible = true;
                    msgError.InnerText = output;
                }
            } else
            {
                error.Visible = true;
                msgError.InnerText = "Campos Obligatorios";
            }
        }

        protected void accionesGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtAccion.Text = accionesGV.SelectedRow.Cells[1].Text;
            txtDesc.Text = accionesGV.SelectedRow.Cells[2].Text;
            cbAct.Checked = (accionesGV.SelectedRow.Cells[3].Controls[0] as CheckBox).Checked;
            btnAdd.Enabled = false;
            btnEdit.Enabled = true;
            btnCancel.Enabled = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = true;
            btnEdit.Enabled = false;
            btnCancel.Enabled = false;
        }
        protected void limpiarForm()
        {
            txtAccion.Text = string.Empty;
            txtDesc.Text = string.Empty;
            cbAct.Checked = false;
            btnAdd.Enabled = true;
            btnEdit.Enabled = false;
            btnCancel.Enabled = false;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string output;
            string user = Session["nomUsuario"].ToString();
            DataTable acciones = (DataTable)ViewState["acciones"];
            int idAccion = Convert.ToInt32(acciones.Rows[accionesGV.SelectedIndex]["IdAccion"].ToString());
            if (txtAccion.Text != "" && txtDesc.Text != "")
            {
                output = DBHelper.saveAccion("UPDATE", user, 1, txtAccion.Text, txtDesc.Text, cbAct.Checked, idAccion);
                if (output == "OK")
                {
                    cargarAcciones(1);
                    limpiarForm();
                } else
                {
                    error.Visible = true;
                    msgError.InnerText = output;
                }
            } else
            {
                error.Visible = true;
                msgError.InnerText = "Campos Obligatorios";
            }
        }
    }
}