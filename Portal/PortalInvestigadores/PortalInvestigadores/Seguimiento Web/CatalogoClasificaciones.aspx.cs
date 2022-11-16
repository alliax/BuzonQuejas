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
    public partial class CatalogoClasificaciones : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();


        protected void Page_Load(object sender, EventArgs e)
        {
            divActive.Visible = false;
            divError.Visible = false;
            if (!Page.IsPostBack)
            {
                bindGridClasificacion();
            }
        }

        private void bindGridClasificacion()
        {
            DataTable dt = DBHelper.getClasificacionesBQ(1);
            ViewState["datatable"] = dt;
            clasificacionGV.DataSource = dt;
            clasificacionGV.DataBind();
        
        }

        protected void agregarClasificacion(object sender, EventArgs e)
        {
            DataTable dttable = new DataTable();
            string usuario = Session["username"].ToString();           
            if (txtClas.Text != "" && txtDesc.Text != "")
            {

                DBHelper.saveClasificacion(txtClas.Text, txtDesc.Text, "", cbQueja.Checked, cbCorreo.Checked, true, 1, usuario);
                dttable = DBHelper.getClasificacionesBQ(1);
                ViewState["datatable"] = dttable;
                clasificacionGV.DataSource = dttable;
                clasificacionGV.DataBind();
                txtClas.Text = string.Empty;
                txtDesc.Text = string.Empty;
                cbQueja.Checked = false;
                cbCorreo.Checked = false;
            } else
            {
                divError.Visible = true;
                msgError.InnerText = "Favor de verificar los campos.";
            }
        }

        protected void clasificacionGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dttable = (DataTable)ViewState["datatable"];
            divActive.Visible = true;
            btnAgregarClas.Enabled = false;
            btnEdit.Enabled = true;
            btnCancel.Enabled = true;
            txtClas.Text = clasificacionGV.SelectedRow.Cells[1].Text;
            txtDesc.Text = clasificacionGV.SelectedRow.Cells[2].Text;
            cbQueja.Checked = (clasificacionGV.SelectedRow.Cells[3].Controls[0] as CheckBox).Checked;
            cbCorreo.Checked = (clasificacionGV.SelectedRow.Cells[4].Controls[0] as CheckBox).Checked;
            cbActive.Checked = (clasificacionGV.SelectedRow.Cells[5].Controls[0] as CheckBox).Checked;
            ViewState["index"] = clasificacionGV.SelectedIndex;


        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            divActive.Visible = false;
            btnAgregarClas.Enabled = true;
            btnEdit.Enabled = false;
            btnCancel.Enabled = false;
            txtClas.Text = string.Empty;
            txtDesc.Text = string.Empty;
            cbQueja.Checked = false;
            cbCorreo.Checked = false;
            cbActive.Checked = false;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            DataTable dtt = (DataTable)ViewState["datatable"];
            int id = (int)ViewState["index"];
            string usuario = Session["username"].ToString();
            if(txtClas.Text != "" && txtDesc.Text != "")
            {
                DBHelper.updateClasificacion(int.Parse(dtt.Rows[id]["id"].ToString()), txtClas.Text, 
                    txtDesc.Text, cbQueja.Checked, cbCorreo.Checked, cbActive.Checked, usuario, 1);

                btnAgregarClas.Enabled = true;
                btnCancel.Enabled = false;
                btnEdit.Enabled = false;
                divActive.Visible = false;
                DataTable dtUp = DBHelper.getClasificacionesBQ(1);
                ViewState["datatable"] = dtUp;
                clasificacionGV.DataSource = dtUp;
                clasificacionGV.DataBind();

                txtDesc.Text = string.Empty;
                txtClas.Text = string.Empty;
                cbQueja.Checked = false;
                cbCorreo.Checked = false;
                cbActive.Checked = false;
                divActive.Visible = false;
            }
        }
    }
}