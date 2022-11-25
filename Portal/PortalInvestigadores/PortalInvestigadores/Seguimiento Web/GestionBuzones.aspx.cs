using Newtonsoft.Json;
using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
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

        protected void eliminarUsrInv(object sender, EventArgs e)
        {
            foreach (GridViewRow gvRow in gvInv.Rows)
            {
                var chk = gvRow.FindControl("Chk1") as CheckBox;
                if (chk.Checked == true)
                {
                    int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                    int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                    string sOutput = DBHelper.postBQUser("CAN", "Investigador", iUsrId, Session["idUsuario"].ToString());
                    DataTable dtUsr = DBHelper.getBQUser("SEL", "Investigador", iIdBQ);
                    gvInv.DataSource = dtUsr;
                    gvInv.DataBind();

                }
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string addUsrInv(int iIdBQ, int iBQUsr, string sUsr)
        {
            DBHelper DBHelper = new DBHelper();
            string sOutput = DBHelper.postBQUser("NEW", "Investigador", iBQUsr, sUsr);
            DataTable dtUsr = DBHelper.getBQUser("SEL", "Investigador", iIdBQ);
            ; string str = JsonConvert.SerializeObject(dtUsr);
            return (str);

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static void delUsrInv(int iBQUsr, string sUsr)
        {
            DBHelper DBHelper = new DBHelper();
            string sOutput = DBHelper.postBQUser("CAN", "Investigador", iBQUsr, sUsr);
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string selUsrInv(int iIdBQ)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dtUsr = DBHelper.getBQUser("SEL", "Investigador", iIdBQ);
            ; string str = JsonConvert.SerializeObject(dtUsr);
            return (str);

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

        protected void eliminarUsrVobo(object sender, EventArgs e)
        {
            foreach (GridViewRow gvRow in gvVobo.Rows)
            {
                var chk = gvRow.FindControl("Chk2") as CheckBox;
                if (chk.Checked == true)
                {
                    int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                    int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                    string sOutput = DBHelper.postBQUser("CAN", "Vobo", iUsrId, Session["idUsuario"].ToString());
                    DataTable dtUsr = DBHelper.getBQUser("SEL", "Vobo", iIdBQ);
                    gvVobo.DataSource = dtUsr;
                    gvVobo.DataBind();

                }
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
        protected void eliminarUsrCierre(object sender, EventArgs e)
        {
            foreach (GridViewRow gvRow in gvCierre.Rows)
            {
                var chk = gvRow.FindControl("Chk3") as CheckBox;
                if (chk.Checked == true)
                {
                    int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                    int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                    string sOutput = DBHelper.postBQUser("CAN", "Cierre", iUsrId, Session["idUsuario"].ToString());
                    DataTable dtUsr = DBHelper.getBQUser("SEL", "Cierre", iIdBQ);
                    gvCierre.DataSource = dtUsr;
                    gvCierre.DataBind();

                }
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
        protected void eliminarUsrComite(object sender, EventArgs e)
        {
            foreach (GridViewRow gvRow in gvComite.Rows)
            {
                var chk = gvRow.FindControl("Chk4") as CheckBox;
                if (chk.Checked == true)
                {
                    int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                    int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                    string sOutput = DBHelper.postBQUser("CAN", "Comite", iUsrId, Session["idUsuario"].ToString());
                    DataTable dtUsr = DBHelper.getBQUser("SEL", "Comite", iIdBQ);
                    gvComite.DataSource = dtUsr;
                    gvComite.DataBind();

                }
            }
        }

        protected void ChkChangedComite(object sender, EventArgs e)
        {

            if (cbComiteUsr.Checked == true)
            {
                dlComiteUsr.Enabled = true;
                btnAgregarComiteUsr.Enabled = true;
                btnEliminarComiteUsr.Enabled = true;
                btnSubirComiteUsr.Enabled= true;
                btnBajarComiteUsr.Enabled= true;
            }
            else
            {
                dlComiteUsr.Enabled = false;
                btnAgregarComiteUsr.Enabled = false;
                btnEliminarComiteUsr.Enabled = false;
                btnSubirComiteUsr.Enabled = false;
                btnBajarComiteUsr.Enabled = false;
            }
        }
        protected void ChkChangedCierre(object sender, EventArgs e)
        {
            if (cbCierreUsr.Checked == true)
            {
                dlCierreUsr.Enabled = true;
                btnAgregarCierreUsr.Enabled = true;
                btnEliminarCierreUsr.Enabled = true;
                btnSubirCierreUsr.Enabled = true;
                btnBajarCierreUsr.Enabled = true;
            }
            else
            {
                dlCierreUsr.Enabled = false;
                btnAgregarCierreUsr.Enabled = false;
                btnEliminarCierreUsr.Enabled = false;
                btnSubirCierreUsr.Enabled = false;
                btnBajarCierreUsr.Enabled = false;
            }
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

            if (dt.Rows.Count > 0)
            {

                if (dt.Rows[0]["ProcesoCierre"].ToString() == "True")
                {
                    cbCierreUsr.Enabled = true;
                    cbCierreUsr.Checked = false;
                    dlCierreUsr.Enabled = false;
                    btnAgregarCierreUsr.Enabled = false;
                    btnEliminarCierreUsr.Enabled = false;
                    btnSubirCierreUsr.Enabled = false;
                    btnBajarCierreUsr.Enabled = false;
                }
                else
                {
                    cbCierreUsr.Enabled = false;
                    cbCierreUsr.Checked = false;
                    dlCierreUsr.Enabled = false;
                    btnAgregarCierreUsr.Enabled = false;
                    btnEliminarCierreUsr.Enabled = false;
                    btnSubirCierreUsr.Enabled = false;
                    btnBajarCierreUsr.Enabled = false;
                }
                if (dt.Rows[0]["ProcesoComite"].ToString() == "True")
                {
                    cbComiteUsr.Enabled = true;
                    cbComiteUsr.Checked = false;
                    dlComiteUsr.Enabled = false;
                    btnAgregarComiteUsr.Enabled = false;
                    btnEliminarComiteUsr.Enabled = false;
                    btnSubirComiteUsr.Enabled = false;
                    btnBajarComiteUsr.Enabled = false;

                }
                else
                {
                    cbComiteUsr.Enabled = false;
                    cbComiteUsr.Checked = false;
                    dlComiteUsr.Enabled = false;
                    btnAgregarComiteUsr.Enabled = false;
                    btnEliminarComiteUsr.Enabled = false;
                    btnSubirComiteUsr.Enabled = false;
                    btnBajarComiteUsr.Enabled = false;
                }

                ViewState["datatable"] = dt;
                gvBuzon.DataSource = dt;
                gvBuzon.DataBind();
            }
        }


        protected void SubirSecCierre(object sender, EventArgs e)
        {

            int iCont = 0;
            foreach (GridViewRow gvRow in gvCierre.Rows)
            {
                var chk = gvRow.FindControl("Chk3") as CheckBox;
                if (chk.Checked == true)
                {
                    iCont = iCont + 1;
                }
            }

            if (iCont == 1)
            {
                foreach (GridViewRow gvRow in gvCierre.Rows)
                {
                    var chk = gvRow.FindControl("Chk3") as CheckBox;
                    if (chk.Checked == true)
                    {
                        int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                        int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                        string sOutput = DBHelper.postBQUser("UP", "Cierre", iUsrId, Session["idUsuario"].ToString());
                        DataTable dtUsr = DBHelper.getBQUser("SEL", "Cierre", iIdBQ);
                        gvCierre.DataSource = dtUsr;
                        gvCierre.DataBind();

                    }
                }
            }

        }
        protected void BajarSecCierre(object sender, EventArgs e)
        {
            int iCont = 0;
            foreach (GridViewRow gvRow in gvCierre.Rows)
            {
                var chk = gvRow.FindControl("Chk3") as CheckBox;
                if (chk.Checked == true)
                {
                    iCont = iCont + 1;
                }
            }

            if (iCont == 1)
            {
                foreach (GridViewRow gvRow in gvCierre.Rows)
                {
                    var chk = gvRow.FindControl("Chk3") as CheckBox;
                    if (chk.Checked == true)
                    {
                        int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                        int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                        string sOutput = DBHelper.postBQUser("DOWN", "Cierre", iUsrId, Session["idUsuario"].ToString());
                        DataTable dtUsr = DBHelper.getBQUser("SEL", "Cierre", iIdBQ);
                        gvCierre.DataSource = dtUsr;
                        gvCierre.DataBind();

                    }
                }
            }
        }



        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
      protected void SubirSecCom(object sender, EventArgs e)
        {

            int iCont = 0;
            foreach (GridViewRow gvRow in gvComite.Rows)
            {
                var chk = gvRow.FindControl("Chk4") as CheckBox;
                if (chk.Checked == true)
                { 
                   iCont=iCont+1;
                }
            }

            if (iCont == 1)
            {
                foreach (GridViewRow gvRow in gvComite.Rows)
                {
                    var chk = gvRow.FindControl("Chk4") as CheckBox;
                    if (chk.Checked == true)
                    {
                        int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                        int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                        string sOutput = DBHelper.postBQUser("UP", "Comite", iUsrId, Session["idUsuario"].ToString());
                        DataTable dtUsr = DBHelper.getBQUser("SEL", "Comite", iIdBQ);
                        gvComite.DataSource = dtUsr;
                        gvComite.DataBind();

                    }
                }
            }

        }
        protected void BajarSecCom(object sender, EventArgs e)
        {
            int iCont = 0;
            foreach (GridViewRow gvRow in gvComite.Rows)
            {
                var chk = gvRow.FindControl("Chk4") as CheckBox;
                if (chk.Checked == true)
                {
                    iCont = iCont + 1;
                }
            }

            if (iCont == 1)
            {
                foreach (GridViewRow gvRow in gvComite.Rows)
                {
                    var chk = gvRow.FindControl("Chk4") as CheckBox;
                    if (chk.Checked == true)
                    {
                        int iUsrId = Convert.ToInt32(gvRow.Cells[1].Text);
                        int iIdBQ = Convert.ToInt32(dlBuzon.SelectedValue.ToString());
                        string sOutput = DBHelper.postBQUser("DOWN", "Comite", iUsrId, Session["idUsuario"].ToString());
                        DataTable dtUsr = DBHelper.getBQUser("SEL", "Comite", iIdBQ);
                        gvComite.DataSource = dtUsr;
                        gvComite.DataBind();

                    }
                }
            }
        }

    }
}