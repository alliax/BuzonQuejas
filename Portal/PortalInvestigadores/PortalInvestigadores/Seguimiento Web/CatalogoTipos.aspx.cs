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
using System.Web.Script.Services;
using Newtonsoft.Json;
using System.Reflection;

namespace Portal_Investigadores
{
  
    public partial class CatalogoTipos : Page
    {
        DBHelper DBHelper = new DBHelper();
        DataTable dtTipo ;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // 1 Grupo (Alliax)
                cargarTipo(1);
                string sIdioma = Session["idioma"].ToString();
                if (sIdioma == "2")
                {
                    this.gvTipo.Columns[0].HeaderText = "Type Id";
                    this.gvTipo.Columns[1].HeaderText = "Description";
                    this.gvTipo.Columns[2].HeaderText = "Active";

                }
            }
        }

        private void cargarTipo(int iIdBQ)
        {
            //cargar temas por id de catalogo
            DataTable dt = DBHelper.getTipo("SEL", iIdBQ, 0);
            dtTipo = DBHelper.getTipo("SEL", iIdBQ, 0);
            ViewState["datatable"] = dt;
            gvTipo.DataSource = dt;
            gvTipo.DataBind();
        }

        protected void agregarTipo(object sender, EventArgs e)
        {
            string sOutput = "";
            if (txtTipo.Text != "" && txtDesc.Text != "")
            {
                double dbRetNum;
                bool bIsNum = Double.TryParse(Convert.ToString(txtTipo.Text), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out dbRetNum);
                if (bIsNum)
                {
                    // 1 Grupo (Alliax)
                    DataTable dt = DBHelper.getTipo("VAL_ID", 1, Convert.ToInt32(txtTipo.Text));

                    if (dt.Rows.Count == 0)
                    {
                        //Post
                        sOutput = DBHelper.postTipo("NEW", Convert.ToInt32(txtTipo.Text), txtDesc.Text, true,Session["idUsuario"].ToString(), 1);
                        if (sOutput == "Ok")
                        {
                            // 1 Grupo (Alliax)
                            cargarTipo(1);
                            txtTipo.Text = string.Empty;
                            txtDesc.Text = string.Empty;
                        }
                        //Post
                        panelTipo.Visible = false;
                    }
                    else
                    {
                        panelTipo.Visible = true;
                        lblTipo.Text = "Tipo Id ya existe ,agrega uno diferente";
                    }

                }
                else
                {
                    panelTipo.Visible = true;
                    lblTipo.Text = "Tipo Id debe ser numerico";
                }

            }
            else
            {
                panelTipo.Visible = true;
                lblTipo.Text = "Favor de Ingresar todos los campos";
            }


        }

        protected void editarTipo(object sender, EventArgs e)
        {
            string sOutput = "";
            if (txtTipo.Text != "" && txtDesc.Text != "")
            {
                // 1 Grupo (Alliax)
                sOutput = DBHelper.postTipo("UPD", Convert.ToInt32(txtTipo.Text), txtDesc.Text, cbActive.Checked,Session["idUsuario"].ToString(), 1);
            }
            else
            {
                panelTipo.Visible = true;
                lblTipo.Text = "Favor de Ingresar todos los campos";
            }
            if (sOutput == "Ok")
            {
                // 1 Grupo (Alliax)
                cargarTipo(1);
                txtTipo.Text = string.Empty;
                txtDesc.Text = string.Empty;
                btnAdd.Enabled = true;
                btnCancel.Enabled = false;
                btnEdit.Enabled = false;
                txtTipo.Enabled = true;
                cbActive.Checked = false;
            }
        }

        protected void cancelTipo(object sender, EventArgs e)
        {
            txtTipo.Text = string.Empty;;
            txtTipo.Enabled = true;
            txtDesc.Text = string.Empty;
            btnAdd.Enabled = true;
            btnCancel.Enabled = false;
            btnEdit.Enabled = false;
        }

        protected void gvTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtTipo.Text = gvTipo.SelectedRow.Cells[1].Text;
            txtDesc.Text = gvTipo.SelectedRow.Cells[2].Text;
            string sActivo = gvTipo.SelectedRow.Cells[3].Text;
            int iIdx = gvTipo.SelectedRow.RowIndex;


            if (sActivo == "True")
            {
                cbActive.Checked = true;
            }
            else
            {
                cbActive.Checked = false;
            }

            ViewState["index"] = gvTipo.SelectedIndex;

            btnEdit.Enabled = true;
            btnCancel.Enabled = true;
            btnAdd.Enabled = false;
            txtTipo.Enabled = false;

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_Etiquetas(int iId,int iIdioma)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dtEtiquetas = DBHelper.getBQEtiquetas(iId,iIdioma);
            string str = JsonConvert.SerializeObject(dtEtiquetas);
            return (str);

        }

    }
}