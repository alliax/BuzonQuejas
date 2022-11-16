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


namespace Portal_Investigadores
{
    public partial class CatalogoImportancia : Page
    {
        DBHelper DBHelper = new DBHelper();
        

        protected void Page_Load(object sender, EventArgs e)
        {                              
            divActive.Visible = false;
            if (!Page.IsPostBack)
            {
                bindGridImportancia();
                bindUsuariosEscalacion();
            }
        }

        private void bindGridImportancia()
        {
            DataTable dt = DBHelper.getImportancia(1);
            ViewState["datatable"] = dt;
            importanciaGV.DataSource = dt;
            importanciaGV.DataBind();
        }

        private void bindUsuariosEscalacion()
        {
            DataTable usuarios = DBHelper.getUsuariosEscalacion(1);

            int idioma = int.Parse(Session["idioma"].ToString());
            DataRow dr = usuarios.NewRow();
            dr["Usuario"] = 0;
            if (idioma == 1)
            {
                dr["nombre"] = "Selecciona un Usuario";
            }
            else
            {
                dr["nombre"] = "Select Delegate";
            }
            usuarios.Rows.Add(dr);

            usuarioDDL.DataSource = usuarios;
            usuarioDDL.DataTextField = usuarios.Columns["Nombre"].ToString();
            usuarioDDL.DataValueField = usuarios.Columns["Usuario"].ToString();
            usuarioDDL.DataBind();

            usuarioDDL.SelectedValue = dr["Usuario"].ToString();

        }

        protected void agregarImportancia(object sender, EventArgs e)
        {
            string usuario = Session["username"].ToString();
            DataTable dt = new DataTable();            
            if(txtImpo.Text != "" && txtDesc.Text != "" && txtRec.Text != "" && txtRecAteEsc.Text != "")
            {       
                DBHelper.saveImportancia(
                            txtImpo.Text, txtDesc.Text, int.Parse(txtRec.Text),
                            int.Parse(txtRecAteEsc.Text), int.Parse(txtRecRes.Text),
                            int.Parse(txtRecEsc.Text), usuarioDDL.SelectedValue.ToString(), 1, true, usuario);
                dt = DBHelper.getImportancia(1);
                ViewState["datatable"] = dt;
                importanciaGV.DataSource = dt;
                importanciaGV.DataBind();

                txtImpo.Text = string.Empty;
                txtDesc.Text = string.Empty;
                txtRec.Text = string.Empty;
                txtRecAteEsc.Text = string.Empty;
                txtRecRes.Text = string.Empty;
                txtRecEsc.Text = string.Empty;
                usuarioDDL.ClearSelection();               
                

            }

            
        }

        protected void importanciaGV_SelectedIndexChanged(object sender, EventArgs e)
        {

            DataTable dttable = (DataTable)ViewState["datatable"];
            DataRow dr = dttable.Rows[importanciaGV.SelectedIndex];
            
            txtImpo.Text = importanciaGV.SelectedRow.Cells[1].Text;
            txtDesc.Text = importanciaGV.SelectedRow.Cells[2].Text;
            txtRec.Text = importanciaGV.SelectedRow.Cells[3].Text;
            txtRecAteEsc.Text = importanciaGV.SelectedRow.Cells[4].Text;
            txtRecRes.Text = importanciaGV.SelectedRow.Cells[5].Text;
            txtRecEsc.Text = importanciaGV.SelectedRow.Cells[6].Text;
            usuarioDDL.SelectedItem.Text = importanciaGV.SelectedRow.Cells[7].Text;
            cbAct.Checked = (importanciaGV.SelectedRow.Cells[8].Controls[0] as CheckBox).Checked;
            ViewState["index"] = importanciaGV.SelectedIndex;
            cbAct.Visible = true;
            btnEdit.Enabled = true;
            btnCancel.Enabled = true;
            btnAdd.Enabled = false;
            divActive.Visible = true;            
            
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            DataTable dtt = (DataTable)ViewState["datatable"];
            int id = (int)ViewState["index"];
            string usuario = Session["username"].ToString();
            if (txtImpo.Text != "" && txtDesc.Text != "" && txtRec.Text != "" && txtRecAteEsc.Text != "")
            {
                DBHelper.updateImportancia(int.Parse(dtt.Rows[id]["idImportancia"].ToString()), txtImpo.Text, txtDesc.Text
                    , int.Parse(txtRec.Text), int.Parse(txtRecAteEsc.Text), int.Parse(txtRecRes.Text), int.Parse(txtRecEsc.Text), usuarioDDL.SelectedItem.Text, 1, cbAct.Checked, usuario);

                btnAdd.Enabled = true;
                btnCancel.Enabled = false;
                btnEdit.Enabled = false;
                divActive.Visible = false;
                DataTable dtUp = DBHelper.getImportancia(1);
                ViewState["datatable"] = dtUp;
                importanciaGV.DataSource = dtUp;
                importanciaGV.DataBind();

                divActive.Visible = false;
                txtImpo.Text = string.Empty;
                txtDesc.Text = string.Empty;
                txtRec.Text = string.Empty;
                txtRecAteEsc.Text = string.Empty;
                txtRecRes.Text = string.Empty;
                txtRecEsc.Text = string.Empty;
                usuarioDDL.Items.Insert(0, new ListItem("Selecciona un Usuario", "0"));
                usuarioDDL.SelectedValue = usuarioDDL.Items.FindByValue("0").Value;
                cbAct.Checked = false;

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            divActive.Visible = false;
            txtImpo.Text = string.Empty;
            txtDesc.Text = string.Empty;
            txtRec.Text = string.Empty;
            txtRecAteEsc.Text = string.Empty;
            txtRecRes.Text = string.Empty;
            txtRecEsc.Text = string.Empty;
            usuarioDDL.Items.Insert(0, new ListItem("Selecciona un Usuario", "0"));
            usuarioDDL.SelectedValue = usuarioDDL.Items.FindByValue("0").Value;            
            cbAct.Checked = false;
        }
    }
}