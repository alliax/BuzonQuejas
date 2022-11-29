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
using System.Security.Policy;
using System.Linq.Expressions;

namespace Portal_Investigadores
{
    public partial class CatalogoTemas : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();


        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                // 1 Grupo (Alliax)
                cargarTemas(1);
                // 1 Grupo (Alliax)
                cargarSubtemas(1);
            }
        }

        private void cargarTemas(int iIdBQ)
        {
            //cargar temas por id de catalogo
            DataTable dt = DBHelper.getTemas("SEL",iIdBQ,0);
            ViewState["datatable"] = dt;
            temaGV.DataSource = dt;
            temaGV.DataBind();
        }
        private void cargarSubtemas(int iIdBQ) 
        {
            //cargar subtemas por id de tema en bd
            //DataTable dtSub = DBHelper.cargarSubtema();
            DataTable dt = DBHelper.getSubtemas("SEL",0);
            ViewState["datatable"] = dt;
            subtemaGV.DataSource = dt;
            subtemaGV.DataBind();

        }

        protected void agregarTema(object sender, EventArgs e)
        {
            string sOutput = "";
            if (txtTema.Text != "" && txtDesc.Text != "")
            {
                double dbRetNum;
                bool bIsNum = Double.TryParse(Convert.ToString(txtTema.Text), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out  dbRetNum);
                if (bIsNum)
                {
                    // 1 Grupo (Alliax)
                    DataTable dt = DBHelper.getTemas("VAL_ID", 1, Convert.ToInt32(txtTema.Text));

                    if (dt.Rows.Count == 0)
                    {
                        //Post
                        sOutput = DBHelper.postTemas("NEW", Convert.ToInt32(txtTema.Text), txtDesc.Text,true,Session["idUsuario"].ToString(), 1);
                        if (sOutput == "Ok")
                        {
                            // 1 Grupo (Alliax)
                            cargarTemas(1);
                            txtTema.Text = string.Empty;
                            txtDesc.Text = string.Empty;
                        }
                        //Post
                        panelTema.Visible = false;
                    }
                    else
                    {
                        panelTema.Visible = true;
                        lblTema.Text = "Tema Id ya existe ,agrega uno diferente";
                    }
                    
                }
                else
                {
                    panelTema.Visible = true;
                    lblTema.Text = "Tema Id debe ser numerico";
                }
               
            }
            else {
                panelTema.Visible = true;
                lblTema.Text = "Favor de Ingresar todos los campos";
            }

            
        }

        protected void editarTema(object sender, EventArgs e)
        {
            string sOutput = "";
            if (txtTema.Text != "" && txtDesc.Text != "")
            {
                // 1 Grupo (Alliax)
                sOutput = DBHelper.postTemas("UPD", Convert.ToInt32(txtTema.Text), txtDesc.Text,cbActivo.Checked,Session["idUsuario"].ToString(), 1);
            }
            else
            {
                panelTema.Visible = true;
                lblTema.Text = "Favor de Ingresar todos los campos";
            }
            if (sOutput == "Ok")
            {
                // 1 Grupo (Alliax)
                cargarTemas(1);
                txtTema.Text = string.Empty;
                txtDesc.Text = string.Empty;
                btnAdd.Enabled = true;
                btnCancel.Enabled = false;
                btnEdit.Enabled = false;
                txtTema.Enabled = true;
                cbActivo.Checked = false;
            }
        }

        protected void temaGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            //DataTable dttable = (DataTable)ViewState["datatable"];
            txtTema.Text = temaGV.SelectedRow.Cells[1].Text;
            tbTema.Text = temaGV.SelectedRow.Cells[1].Text;
            txtDesc.Text = temaGV.SelectedRow.Cells[2].Text;


            string sActivo = temaGV.SelectedRow.Cells[3].Text;
            int iIdx = temaGV.SelectedRow.RowIndex;
            if (sActivo == "True")
            {
                cbActivo.Checked = true;
            }
            else
            {
                cbActivo.Checked = false;
            }

            ViewState["index"] = temaGV.SelectedIndex;
            //lbTxt.Text =  temaGV.SelectedIndex.ToString();
            btnEdit.Enabled = true;
            btnCancel.Enabled = true;
            btnAdd.Enabled = false;
            txtTema.Enabled= false;
            //if(dttable!=null)
            //{
            //    if(dttable.Rows.Count > 0)
            //    {
            //        tbTema.Text = temaGV.SelectedRow.Cells[1].Text;
            //    }
            //}
            btnAddSb.Enabled = true;
        }
        protected void subtemaGV_SelectedIndexChanged(object sender, EventArgs e)
        {

            tbTema.Text = subtemaGV.SelectedRow.Cells[1].Text;
            txtSubtema.Text = subtemaGV.SelectedRow.Cells[2].Text;
            txtSubTemaDesc.Text = subtemaGV.SelectedRow.Cells[3].Text;

            string sActivo = subtemaGV.SelectedRow.Cells[4].Text;
            int iIdx = subtemaGV.SelectedRow.RowIndex;


            if (sActivo == "True")
            {
                cbSubActivo.Checked = true;
            }
            else
            {
                cbSubActivo.Checked = false;
            }

            ViewState["index"] = subtemaGV.SelectedIndex;
    
            btnEdiSb.Enabled = true;
            btnCanSb.Enabled = true;
            btnAddSb.Enabled = false;
            txtSubtema.Enabled = false;

        }

        protected void btnCancel_Tema(object sender, EventArgs e)
        {
            txtTema.Text = string.Empty;
            tbTema.Text = string.Empty;
            txtTema.Enabled = true; 
            txtDesc.Text = string.Empty;
            btnAdd.Enabled = true;
            btnCancel.Enabled = false;
            btnEdit.Enabled = false;
        }

        protected void agregarSubtema(object sender, EventArgs e)
        {
            string sOutput = "";
 
            if (txtSubtema.Text != "" && txtSubTemaDesc.Text != "" && tbTema.Text!="")
            {
                double dbRetNum;
                bool bIsNum = Double.TryParse(Convert.ToString(txtSubtema.Text), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out dbRetNum);
                if (bIsNum)
                {
                    // 1 Grupo (Alliax)
                    DataTable dt = DBHelper.getSubtemas("VAL_ID",Convert.ToInt32(txtSubtema.Text));

                    if (dt.Rows.Count == 0)
                    {
                        //Post
                        // 1 Grupo (Alliax)
                        sOutput = DBHelper.postSubtemas("NEW", Convert.ToInt32(tbTema.Text), Convert.ToInt32(txtSubtema.Text), txtSubTemaDesc.Text,true ,Session["idUsuario"].ToString());
                        if (sOutput == "Ok")
                        {
                            // 1 Grupo (Alliax)
                            cargarSubtemas(1);
                            txtSubtema.Text = string.Empty;
                            txtSubTemaDesc.Text = string.Empty;
                            tbTema.Text = string.Empty;
                        }
                        //Post
                        panelSubtema.Visible = false;
                    }
                    else
                    {
                        panelSubtema.Visible = true;
                        lblSubtema.Text = "Subtema Id ya existe ,agrega uno diferente";
                    }
                }
                else
                {
                    panelSubtema.Visible = true;
                    lblSubtema.Text = "Subtema Id debe ser numerico";
                }
            }
            else
            {
                panelSubtema.Visible = true;
                lblSubtema.Text = "Favor de Ingresar todos los campos";
            }
        }

        protected void editarSubtema(object sender, EventArgs e)
        {
            string sOutput = "";
            if (txtSubtema.Text != "" && txtSubTemaDesc.Text != "" && tbTema.Text != "")
            {
                // 1 Grupo (Alliax)
                sOutput = DBHelper.postSubtemas("UPD",Convert.ToInt32(tbTema.Text), Convert.ToInt32(txtSubtema.Text), txtSubTemaDesc.Text, cbSubActivo.Checked,Session["idUsuario"].ToString());
            }
            else
            {
                panelSubtema.Visible = true;
                lblSubtema.Text = "Favor de Ingresar todos los campos";
            }
            if (sOutput == "Ok")
            {
                // 1 Grupo (Alliax)
                cargarSubtemas(1);
                txtSubtema.Text = string.Empty;
                txtSubTemaDesc.Text = string.Empty;
                btnAddSb.Enabled = true;
                btnCanSb.Enabled = false;
                btnEdiSb.Enabled = false;
                txtTema.Enabled = true;
                cbSubActivo.Checked = false;
            }

        }

        protected void cancelSubtema(object sender, EventArgs e)
        {
            txtSubtema.Text = string.Empty;
            tbTema.Text = string.Empty;
            txtSubtema.Enabled = true;
            txtSubTemaDesc.Text = string.Empty;
            btnAddSb.Enabled = true;
            btnCanSb.Enabled = false;
            btnEdiSb.Enabled = false;
        }


    }
}