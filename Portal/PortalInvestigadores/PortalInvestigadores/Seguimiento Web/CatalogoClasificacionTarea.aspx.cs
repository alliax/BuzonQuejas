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

namespace Portal_Investigadores
{
    public partial class CatalogoClasificacionTarea : Page
    {
        DBHelper DBHelper = new DBHelper();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            error.Visible = false;
            if (!Page.IsPostBack)
            {
                cargarClasificacionTarea();
            }
        }

        protected void cargarClasificacionTarea()
        {
            DataTable clasificacionesTarea = DBHelper.getClasificacionTarea("SELECT", 1);
            ViewState["clasificacionesTarea"] = clasificacionesTarea;
            clasificacionTareaGV.DataSource = clasificacionesTarea;
            clasificacionTareaGV.DataBind();
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
            string output = "";
            string usuario = Session["username"].ToString();
            if (txtTarea.Text != "" && txtDesc.Text != "")
            {
                output = DBHelper.saveClasificacionTarea("INSERT", 0, 1, txtTarea.Text, txtDesc.Text, cbAct.Checked, usuario);
                if(output == "OK")
                {
                    cargarClasificacionTarea();
                    txtTarea.Text = string.Empty;
                    txtDesc.Text = string.Empty;
                    cbAct.Checked = false;
                }
                else
                {
                    error.Visible = true;
                    msgError.InnerText = output;
                }
            }else
            {
                error.Visible = true;
                msgError.InnerText = "Campos Obligatorios";
            }
        }

        protected void clasificacionTareaGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAdd.Enabled = false;
            btnCancel.Enabled = true;
            btnEdit.Enabled = true;
            txtTarea.Text = HttpUtility.HtmlDecode(clasificacionTareaGV.SelectedRow.Cells[1].Text);
            txtDesc.Text = clasificacionTareaGV.SelectedRow.Cells[2].Text;
            cbAct.Checked = (clasificacionTareaGV.SelectedRow.Cells[3].Controls[0] as CheckBox).Checked;
        }
        protected void limpiarForm()
        {
            btnAdd.Enabled = true;
            btnEdit.Enabled = false;
            btnCancel.Enabled = false;
            txtTarea.Text = string.Empty;
            txtDesc.Text = string.Empty;
            cbAct.Checked = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            limpiarForm();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string output = "";
            string usuario = Session["username"].ToString();
            DataTable clasificacionesTarea = (DataTable)ViewState["clasificacionesTarea"];
            int id = Convert.ToInt32(clasificacionesTarea.Rows[clasificacionTareaGV.SelectedIndex]["id"].ToString());
            if (txtTarea.Text != "" && txtDesc.Text != "")
            {
                output = DBHelper.saveClasificacionTarea("UPDATE", id, 1, txtTarea.Text, txtDesc.Text, cbAct.Checked, usuario);
                if (output == "OK")
                {
                    cargarClasificacionTarea();
                    limpiarForm();
                }
                else
                {
                    error.Visible = true;
                    msgError.InnerText = output;
                }
            }
            else
            {
                error.Visible = true;
                msgError.InnerText = "Campos Obligatorios";
            }
        }
    }
}