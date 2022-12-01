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
using Newtonsoft.Json;
using System.Web.Script.Services;

namespace Portal_Investigadores
{
    public partial class CatalogoBuzones : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();


        protected void Page_Load(object sender, EventArgs e)
        {
            error.Visible = false;
            divActive.Visible = false;
            if (!Page.IsPostBack)
            {
                bindGrupos("");
                cargarbuzones();
                string sIdioma = Session["idioma"].ToString();
                if (sIdioma == "2")
                {
                    this.buzonesGV.HeaderRow.Cells[1].Text = "Group";
                    this.buzonesGV.HeaderRow.Cells[2].Text = "Company";
                    this.buzonesGV.HeaderRow.Cells[3].Text = "Box Name";
                    this.buzonesGV.HeaderRow.Cells[4].Text = "Description";
                    this.buzonesGV.HeaderRow.Cells[5].Text = "Active";
                }
            }
        }

        protected void cargarbuzones()
        {
            DataTable buzones = DBHelper.getBuzones();
            ViewState["buzones"] = buzones;
            buzonesGV.DataSource = buzones;
            buzonesGV.DataBind();
        }

        protected void bindGrupos(string grupo)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable grupos = DBHelper.getGrupos();

            DataRow dr = grupos.NewRow();
            dr["Grupo"] = "0";
            dr["Descripcion"] = "Selecciona un Grupo";
            grupos.Rows.Add(dr);

            ddlGrupo.DataSource = grupos;
            ddlGrupo.DataTextField = grupos.Columns["Descripcion"].ToString();
            ddlGrupo.DataValueField = grupos.Columns["Grupo"].ToString();
            ddlGrupo.DataBind();

            ddlGrupo.SelectedValue = grupo;

        }
        protected void CargarEmpresas(string grupo, string empresa)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable empresas = DBHelper.getEmpresas(grupo);

            //DataRow dr = empresas.NewRow();
            //dr["Empresa"] = "0";
            //dr["Descripcion"] = "Selecciona una Empresa";
            //empresas.Rows.Add(dr);

            ddlEmpresa.DataSource = empresas;
            ddlEmpresa.DataTextField = empresas.Columns["Descripcion"].ToString();
            ddlEmpresa.DataValueField = empresas.Columns["Empresa"].ToString();
            ddlEmpresa.DataBind();
            if (empresa != "")
            {
                ddlEmpresa.SelectedValue = empresa;
            }
            

        }

        protected void ddlGrupo_SelectedIndexChanged(object sender, EventArgs e)
        {          
            CargarEmpresas(ddlGrupo.SelectedValue.ToString(), "");
        }

        protected void agregarBuzon(object sender, EventArgs e)
        {
            string usuario = Session["username"].ToString();
            string output = "";
            if (txtNombre.Text != "" && txtDesc.Text != "" && ddlEmpresa.SelectedValue.ToString() != "")
            {
                output = DBHelper.saveBuzon(ddlGrupo.SelectedValue.ToString(), ddlEmpresa.SelectedValue.ToString(), txtNombre.Text, txtDesc.Text, true, usuario);
                if(output == "OK")
                {
                    cargarbuzones();
                    txtNombre.Text = string.Empty;
                    txtDesc.Text = string.Empty;
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
                msgError.InnerText = "Campos vacíos";
            }
            
        }

        protected void buzonesGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable buzones = (DataTable)ViewState["buzones"];
            btnAdd.Enabled = false;
            btnCancel.Enabled = true;
            btnEdit.Enabled = true;
            ddlGrupo.Enabled = false;
            ddlEmpresa.Enabled = false;
            txtNombre.Text = buzonesGV.SelectedRow.Cells[3].Text;
            txtDesc.Text = buzonesGV.SelectedRow.Cells[4].Text;
            bindGrupos(buzonesGV.SelectedRow.Cells[1].Text);
            CargarEmpresas(buzonesGV.SelectedRow.Cells[1].Text, buzonesGV.SelectedRow.Cells[2].Text);
            //lbl.Text = buzones.Rows[buzonesGV.SelectedIndex]["idBQ"].ToString();
            activeCH.Checked = (buzonesGV.SelectedRow.Cells[5].Controls[0] as CheckBox).Checked;
            divActive.Visible = true;
        }

        protected void clearForm()
        {
            
            //ddlEmpresa.Items.Clear();
            txtNombre.Text = string.Empty;
            txtDesc.Text = string.Empty;
            ddlEmpresa.Enabled = true;
            ddlGrupo.Enabled = true;
            divActive.Visible = false;
        }

        protected void editarBuzon(object sender, EventArgs e)
        {
            string output = "";
            string usuario = Session["username"].ToString();
            DataTable buzones = (DataTable)ViewState["buzones"];
            int idBq = int.Parse(buzones.Rows[buzonesGV.SelectedIndex]["idBQ"].ToString());
            if (txtNombre.Text != "" && txtDesc.Text != "")
            {
                output = DBHelper.updateBuzon(idBq, txtNombre.Text, txtDesc.Text, activeCH.Checked, usuario);
                if (output == "OK")
                {
                    cargarbuzones();
                    clearForm();
                    btnAdd.Enabled = true;
                    btnCancel.Enabled = false;
                    btnEdit.Enabled = false;
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
                msgError.InnerText = "Verifica los campos";
            }
        }

        protected void cancelarBuzon(object sender, EventArgs e)
        {
            clearForm();
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
    }
}