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
using Seguimiento_Web;
using System.Security.Cryptography;
using Newtonsoft.Json;
using System.Web.Script.Services;

namespace Portal_Investigadores
{
    public partial class CatalogoConducto : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();


        protected void Page_Load(object sender, EventArgs e)
        {
            divActive.Visible = false;
            if (!Page.IsPostBack)
            {
                string sIdioma = Session["idioma"].ToString();
                if (sIdioma == "2")
                {
                    this.conductoGV.Columns[0].HeaderText = "Conduit";
                    this.conductoGV.Columns[1].HeaderText = "Description";
                    this.conductoGV.Columns[2].HeaderText = "Active";
                    this.formaGV.Columns[0].HeaderText = "Form";
                    this.formaGV.Columns[1].HeaderText = "Description";
                    this.formaGV.Columns[2].HeaderText = "Active";

                }
                bindGridConducto();

            }
        }

        private void bindGridConducto()
        {
            DataTable dt = DBHelper.getConductosBQ(1);
            ViewState["datatable"] = dt;
            conductoGV.DataSource = dt;
            conductoGV.DataBind();
        }
        protected void bindGridFormasByConducto(int idConducto, int idBQ)
        {

            DataTable formas = DBHelper.getFormasBQ(idConducto, idBQ);
            ViewState["formas"] = formas;
            formaGV.DataSource = formas;
            formaGV.DataBind();


        }

        protected void agregarConducto(object sender, EventArgs e)
        {
            DataTable dttable = new DataTable();            
            string usuario = Session["username"].ToString();
            if (txtConducto.Text != "" && txtDescr.Text != "")
            {
                DBHelper.saveConducto(txtConducto.Text, txtDescr.Text, true, usuario, 1);
                dttable = DBHelper.getConductosBQ(1);
                ViewState["datatable"] = dttable;
                conductoGV.DataSource = dttable;
                conductoGV.DataBind();
                
                txtConducto.Text = string.Empty;
                txtDescr.Text = string.Empty;
            }
        }

        protected void conductoGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            //GridViewRow row = conductoGV.SelectedRow;
            DataTable dttable = (DataTable)ViewState["datatable"];
            bindGridFormasByConducto(int.Parse(dttable.Rows[conductoGV.SelectedIndex]["id"].ToString()),1);
            ViewState["index"] = conductoGV.SelectedIndex;
            ViewState["idConducto"] = int.Parse(dttable.Rows[conductoGV.SelectedIndex]["id"].ToString());
            btnAdd.Enabled = false;
            btnEdit.Enabled = true;
            btnCancel.Enabled = true;
            divActive.Visible = true;
            txtConducto.Text = conductoGV.SelectedRow.Cells[1].Text;
            txtDescr.Text = conductoGV.SelectedRow.Cells[2].Text;
            cbActive.Checked = (conductoGV.SelectedRow.Cells[3].Controls[0] as CheckBox).Checked;
            txtCond.Text = conductoGV.SelectedRow.Cells[1].Text;


        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtConducto.Text = string.Empty;
            txtDescr.Text = string.Empty;
            txtCond.Text = string.Empty;
            cbActive.Checked = false;
            divActive.Visible = false; 
            btnAdd.Enabled = true;
            btnCancel.Enabled = false;
            btnEdit.Enabled = false;
           
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            DataTable dtt = (DataTable)ViewState["datatable"];
            int id = (int)ViewState["index"];

            string usuario = Session["username"].ToString();
            if (txtConducto.Text != "" && txtDescr.Text != "")
            {
                DBHelper.updateConducto(int.Parse(dtt.Rows[id]["id"].ToString()), txtConducto.Text, txtDescr.Text, 
                    cbActive.Checked, usuario, 1);

                dtt = DBHelper.getConductosBQ(1);
                ViewState["datatable"] = dtt;
                conductoGV.DataSource = dtt;
                conductoGV.DataBind();
                txtConducto.Text = string.Empty;
                txtDescr.Text = string.Empty;
                txtCond.Text = string.Empty;
                btnAdd.Enabled = true;
                btnCancel.Enabled = false;
                btnEdit.Enabled = false;
                divActive.Visible = false;
            }
            
            
        }

        protected void addForma(object sender, EventArgs e)
        {
            string output = "";
            int idConducto = (int)ViewState["idConducto"];
            string usuario = Session["username"].ToString();
            if (txtForma.Text != "" && desc.Text != "")
            {
                output = DBHelper.saveForma(idConducto, txtForma.Text, desc.Text, true, usuario, 1);

            }
            else
            {
                panelSubtema.Visible = true;
                lblSubtema.Text = "Verifica los campos";
            }
            if (output != "OK")
            {
                panelSubtema.Visible = true;
                lblSubtema.Text = output;
            }
            
        }

        protected void formaGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAddForma.Enabled = false;
            btnEditForma.Enabled = true;
            btnCancelForma.Enabled = true;
            divFormaActivo.Visible = true;
            txtForma.Text = formaGV.SelectedRow.Cells[1].Text;
            desc.Text = formaGV.SelectedRow.Cells[2].Text;
            chActive.Checked = (formaGV.SelectedRow.Cells[3].Controls[0] as CheckBox).Checked;
            ViewState["indexForma"] = formaGV.SelectedIndex;

        }

        protected void btnCancelForma_Click(object sender, EventArgs e)
        {
            cancelBtns();
        }

        protected void cancelBtns()
        {
            btnAddForma.Enabled = true;
            btnEditForma.Enabled = false;
            btnCancelForma.Enabled = false;
            divFormaActivo.Visible = false;
            txtForma.Text = string.Empty;
            desc.Text = string.Empty;
            chActive.Checked = false;
        }

        protected void btnEditForma_Click(object sender, EventArgs e)
        {
            DataTable dtt = (DataTable)ViewState["formas"];
            string usuario = Session["username"].ToString();
            string output = "";
            int id = (int)ViewState["indexForma"];
            int idConducto = (int)ViewState["idConducto"];
            if (txtForma.Text != "" && desc.Text != "")
            {
               output =  DBHelper.updateForma(int.Parse(dtt.Rows[id]["id"].ToString()), idConducto, 1,txtForma.Text, desc.Text, chActive.Checked, usuario);

                if (output == "OK")
                {
                    cancelBtns();
                    bindGridFormasByConducto(idConducto, 1);
                }
            }
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