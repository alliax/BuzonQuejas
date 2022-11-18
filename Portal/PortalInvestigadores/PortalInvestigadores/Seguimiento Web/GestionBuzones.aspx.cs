using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Seguimiento_Web
{
    
    public partial class PortalQuejas : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // 1 Alliax
                //cargarBuzon(1);
                DataTable dtGrupo = DBHelper.getBQId("Grupo", "");
                dlGrupo.DataSource = dtGrupo;
                dlGrupo.DataValueField = "Id";
                dlGrupo.DataTextField = "Descripcion";
                dlGrupo.DataBind();

            }
        }
        protected void agregarBuzon(object sender, EventArgs e)
        {
            int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                Byte[] Archivo = null;
                string nombreArchivo = string.Empty;
                string extensionArchivo = string.Empty;
                if (flLogo.HasFile == true)
                {
                    using (BinaryReader reader = new
                    BinaryReader(flLogo.PostedFile.InputStream))
                    {
                        Archivo = reader.ReadBytes(flLogo.PostedFile.ContentLength);
                    }
                    nombreArchivo = Path.GetFileNameWithoutExtension(flLogo.FileName);
                    extensionArchivo = Path.GetExtension(flLogo.FileName);

                    // 1 Alliax
                    string sOutput = DBHelper.postBQ("NEW",iIdBQ,cbCierre.Checked,cbComite.Checked,Archivo, cbActivo.Checked, Session["idUsuario"].ToString());               
                    cargarBuzon(iIdBQ);
           
            }
        }
        protected void editarBuzon(object sender, EventArgs e)
        {
            int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
            Byte[] Archivo = null;
            string nombreArchivo = string.Empty;
            string extensionArchivo = string.Empty;
            if (flLogo.HasFile == true)
            {
                using (BinaryReader reader = new
                BinaryReader(flLogo.PostedFile.InputStream))
                {
                    Archivo = reader.ReadBytes(flLogo.PostedFile.ContentLength);
                }
                nombreArchivo = Path.GetFileNameWithoutExtension(flLogo.FileName);
                extensionArchivo = Path.GetExtension(flLogo.FileName);

                // 1 Alliax
                string sOutput = DBHelper.postBQ("UPD", iIdBQ, cbCierre.Checked, cbComite.Checked, Archivo, cbActivo.Checked, Session["idUsuario"].ToString());
                cargarBuzon(iIdBQ);
               
            }
            else
            {
                string sOutput = DBHelper.postBQ("UPD",iIdBQ, cbCierre.Checked, cbComite.Checked, Archivo, cbActivo.Checked, Session["idUsuario"].ToString());
                cargarBuzon(iIdBQ);
               
            }
        }
        protected void Sel_Change_Grupo(Object sender, EventArgs e)
        {
            string sGrupo = dlGrupo.SelectedValue.ToString();

            DataTable dt = DBHelper.getBQId("Empresa", sGrupo);
            dlEmpresa.DataSource = dt;
            dlEmpresa.DataValueField = "Id";
            dlEmpresa.DataTextField = "Descripcion";
            dlEmpresa.DataBind();

        }
        protected void Sel_Change_Empresa(Object sender, EventArgs e)
        {
            string sEmpresa = dlEmpresa.SelectedValue.ToString();

            DataTable dt = DBHelper.getBQId("Buzon",sEmpresa );
            dlBuzon.DataSource = dt;
            dlBuzon.DataValueField = "Id";
            dlBuzon.DataTextField = "Descripcion";
            dlBuzon.DataBind();

        }

        protected void Sel_Change_Buzon(Object sender, EventArgs e)
        {
          int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());         
          cargarUsr(iIdBQ);
          cargarBuzon(iIdBQ);
        }

        protected void agregarUsrInv(object sender, EventArgs e)
        {

            if (dlInvestigador.SelectedIndex > 0)
            {

                int iSelId = Convert.ToInt32(dlInvestigador.SelectedValue.ToString());
                int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                string sOutput = DBHelper.postBQUser("NEW", "Investigador", iSelId, Session["idUsuario"].ToString());
                DataTable dtUsr = DBHelper.getBQUser("SEL", "Investigador", iIdBQ);
                gvInv.DataSource = dtUsr;
                gvInv.DataBind();
            }
        }

        protected void agregarUsrVobo(object sender, EventArgs e)
        {

            if (dlVobo.SelectedIndex > 0)
            {

                int iSelId = Convert.ToInt32(dlVobo.SelectedValue.ToString());
                int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                string sOutput = DBHelper.postBQUser("NEW", "Vobo", iSelId, Session["idUsuario"].ToString());
                DataTable dtUsr = DBHelper.getBQUser("SEL", "Vobo", iIdBQ);
                gvVobo.DataSource = dtUsr;
                gvVobo.DataBind();
            }
        }

        protected void agregarUsrCierre(object sender, EventArgs e)
        {

            if (dlCierreUsr.SelectedIndex > 0)
            {

                int iSelId = Convert.ToInt32(dlCierreUsr.SelectedValue.ToString());
                int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                string sOutput = DBHelper.postBQUser("NEW", "Cierre", iSelId, Session["idUsuario"].ToString());
                DataTable dtUsr = DBHelper.getBQUser("SEL", "Cierre", iIdBQ);
                gvCierre.DataSource = dtUsr;
                gvCierre.DataBind();
            }
        }
        protected void agregarUsrComite(object sender, EventArgs e)
        {

            if (dlComiteUsr.SelectedIndex > 0)
            {

                int iSelId = Convert.ToInt32(dlComiteUsr.SelectedValue.ToString());
                int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                string sOutput = DBHelper.postBQUser("NEW", "Comite", iSelId, Session["idUsuario"].ToString());
                DataTable dtUsr = DBHelper.getBQUser("SEL", "Comite", iIdBQ);
                gvComite.DataSource = dtUsr;
                gvComite.DataBind();
            }
        }

        protected void ChkChangedComite(object sender, EventArgs e)
        {
            dlComiteUsr.Enabled = true;
            btnAgregarComiteUsr.Enabled = true;
            btnActivarComiteUsr.Enabled=true;
        }
        protected void ChkChangedCierre(object sender, EventArgs e)
        {
            dlCierreUsr.Enabled = true;
            btnAgregarCierreUsr.Enabled = true;
            btnActivarCierreUsr.Enabled=true;
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dr = (DataRowView)e.Row.DataItem;
                string sImg = dr["Logo"].ToString();


                if (sImg != "")
                {
                    string imageUrl = "data:image/jpg;base64," + Convert.ToBase64String((byte[])dr["Logo"]);
                    (e.Row.FindControl("Img") as Image).ImageUrl = imageUrl;
                }
            }
        }

        private void cargarUsr(int iIdBQ)
        {

            DataTable dtInv = DBHelper.getBQUser("CATSEL", "Investigador",iIdBQ);
            dlInvestigador.DataSource = dtInv;
            dlInvestigador.DataValueField = "IdUsuariobq";
            dlInvestigador.DataTextField = "Nombre";
            dlInvestigador.DataBind();

            DataTable dtVobo = DBHelper.getBQUser("CATSEL", "Vobo", iIdBQ);
            dlVobo.DataSource = dtVobo;
            dlVobo.DataValueField = "IdUsuariobq";
            dlVobo.DataTextField = "Nombre";
            dlVobo.DataBind();

            DataTable dtCierre = DBHelper.getBQUser("CATSEL", "Activo", iIdBQ);
            dlCierreUsr.DataSource = dtCierre;
            dlCierreUsr.DataValueField = "IdUsuariobq";
            dlCierreUsr.DataTextField = "Nombre";
            dlCierreUsr.DataBind();

            DataTable dtComite = DBHelper.getBQUser("CATSEL", "Activo", iIdBQ);
            dlComiteUsr.DataSource = dtComite;
            dlComiteUsr.DataValueField = "IdUsuariobq";
            dlComiteUsr.DataTextField = "Nombre";
            dlComiteUsr.DataBind();

            DataTable dtInvUsr= DBHelper.getBQUser("SEL", "Investigador", iIdBQ);
            gvInv.DataSource = dtInvUsr;
            gvInv.DataBind();

            DataTable dtVoboUsr = DBHelper.getBQUser("SEL", "Vobo", iIdBQ);
            gvVobo.DataSource = dtVoboUsr;
            gvVobo.DataBind();

            DataTable dtCierreUsr = DBHelper.getBQUser("SEL", "Cierre", iIdBQ);
            gvCierre.DataSource = dtCierreUsr;
            gvCierre.DataBind();

            DataTable dtComiteUsr = DBHelper.getBQUser("SEL", "Comite", iIdBQ);
            gvComite.DataSource = dtComiteUsr;
            gvComite.DataBind();

        }

        private void cargarBuzon(int iIdBQ)
        {
            DataTable dt = DBHelper.getBQ("SELMNT", iIdBQ);

            if (dt.Rows[0]["ProcesoCierre"].ToString() == "True")
            {
                cbCierreUsr.Enabled = true;
                cbCierreUsr.Checked = false;
                dlCierreUsr.Enabled = false;
                btnAgregarCierreUsr.Enabled=false;
                btnActivarCierreUsr.Enabled = false;
            }
            else
            {
                cbCierreUsr.Enabled = false;
                cbCierreUsr.Checked = false;
                dlCierreUsr.Enabled = false;
                btnAgregarCierreUsr.Enabled=false;
                btnActivarCierreUsr.Enabled = false;
            }
            if (dt.Rows[0]["ProcesoComite"].ToString() == "True")
            {
                cbComiteUsr.Enabled = true;
                cbComiteUsr.Checked = false;
                dlComiteUsr.Enabled = false;
                btnAgregarComiteUsr.Enabled = false;
                btnActivarComiteUsr.Enabled = false;

            }
            else
            {
                cbComiteUsr.Enabled = false;
                cbComiteUsr.Checked = false;
                dlComiteUsr.Enabled = false;
                btnAgregarComiteUsr.Enabled = false;
                btnActivarComiteUsr.Enabled = false;
            }

            ViewState["datatable"] = dt;
            gvBuzon.DataSource = dt;
            gvBuzon.DataBind();
        }

    }
}