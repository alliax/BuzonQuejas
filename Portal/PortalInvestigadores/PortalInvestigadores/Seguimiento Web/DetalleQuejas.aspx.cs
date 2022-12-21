using Newtonsoft.Json;
using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Seguimiento_Web
{
    public partial class DetalleMensaje : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string sIdioma = Session["idioma"].ToString();
                int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
                txtResponsable.Text = Session["nomUsuario"].ToString();


                //Quejas Asociadas
                DataTable dtAsociados = DBHelper.getQuejasAsociadas(iIdQueja);
                gvAsociados.DataSource = dtAsociados;
                gvAsociados.DataBind();
                if (dtAsociados.Rows.Count > 0)
                {
                    if (sIdioma == "2")
                    {
                        GridViewRow header = gvAsociados.HeaderRow;
                        header.Cells[0].Text = "Complaint Id";
                        header.Cells[1].Text = "Text";
                    }
                }

                //Delegados
                DataTable dtDelegados = DBHelper.getDelegados(Convert.ToInt32(sIdioma));
                delegadoDDL.DataSource = dtDelegados;
                delegadoDDL.DataTextField = "Nombre";
                delegadoDDL.DataValueField = "IdUsuarioBQ";
                delegadoDDL.DataBind();


                //Resultados
                DataTable resultados = DBHelper.getResultados(Convert.ToInt32(sIdioma));
                DataRow drRes = resultados.NewRow();
                if (sIdioma == "1")
                {
                    drRes["idResultado"] = 0;
                    drRes["nombre"] = "Selecciona un Resultado";
                }
                else
                {
                    drRes["idResultado"] = 0;
                    drRes["nombre"] = "Select Veracity Level";
                }
                resultados.Rows.Add(drRes);
                resultados.DefaultView.Sort = "idResultado";
                resultadoDDL.DataSource = resultados;
                resultadoDDL.DataTextField = "nombre";
                resultadoDDL.DataValueField = "idResultado";
                resultadoDDL.DataBind();
                resultadoDDL.EnableViewState = true;


                //Beneficios
                DataTable beneficios = DBHelper.getBeneficios(Convert.ToInt32(sIdioma));
                DataRow drBen = beneficios.NewRow();
                drBen["idBeneficio"] = 0;
                if (sIdioma == "1")
                {
                    drBen["nombre"] = "Selecciona un Beneficio";
                }
                else
                {
                    drBen["nombre"] = "Select Benefit";
                }
                beneficios.Rows.Add(drBen);
                beneficios.DefaultView.Sort = "idBeneficio";
                beneficioDDL.DataSource = beneficios;
                beneficioDDL.DataTextField = "nombre";
                beneficioDDL.DataValueField = "idBeneficio";
                beneficioDDL.DataBind();
                beneficioDDL.EnableViewState = true;

                DataTable dtAnalisis = DBHelper.getBQInvTema(iIdQueja, Convert.ToInt32(sIdioma));
                gvTemas.DataSource = dtAnalisis;
                gvTemas.DataBind();
                if (dtAnalisis.Rows.Count > 0)
                {
                    if (sIdioma == "2")
                    {
                        GridViewRow header = gvTemas.HeaderRow;
                        header.Cells[0].Text = "Investigation Id";
                        header.Cells[1].Text = "Investigation Topic";
                        header.Cells[2].Text = "Investigation Case";
                        header.Cells[3].Text = "Investigation Activities";
                        header.Cells[4].Text = "Accion Plan";
                        header.Cells[5].Text = "Conclutions";
                        header.Cells[6].Text = "Benefit";
                        header.Cells[7].Text = "Result";
                    }
                    else
                    {
                        GridViewRow header = gvTemas.HeaderRow;
                        header.Cells[0].Text = "Id Investigacion";
                        header.Cells[1].Text = "Tema Investigacion";
                        header.Cells[2].Text = "Asunto Investigacion";
                        header.Cells[3].Text = "Actividades Investigacion";
                        header.Cells[4].Text = "Plan Accion";
                        header.Cells[5].Text = "Conclusiones";
                        header.Cells[6].Text = "Beneficio";
                        header.Cells[7].Text = "Resultado";
                    }
                }
            }
        }
        protected void btnCom_Click(object sender, EventArgs e)
        {
            int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
            string sConclusion =txtConclusion.Text;
            DBHelper.postBQInvConclusion(iIdQueja, sConclusion);

        }
        protected void btnDelegar_Click(object sender, EventArgs e)
        { 
        
        }

        protected void btnTemaGuardar_Click(object sender, EventArgs e)
        {
            int iIdioma = int.Parse(Session["idioma"].ToString());
            int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
            int iIdBQ = int.Parse(Session["idBq"].ToString());
            int iUsr = int.Parse(Session["idUsuario"].ToString());
            string sTema = mTxtTema.Text;
            string sAsunto = mTxtAsunto.Text;
            string sActividades = mTxtActividades.Text;
            string sDetalle=mTxtDetalle.Text;
            string sPlan = mTxtPlan.Text;       
            string sCon = mTxtConclusiones.Text;

            if (beneficioDDL.SelectedIndex != 0 && resultadoDDL.SelectedIndex != 0)
            {
                int iBeneficio = Convert.ToInt32(beneficioDDL.SelectedValue);
                int iResultado = Convert.ToInt32(resultadoDDL.SelectedValue);
                DBHelper.postBQInvTema(iIdQueja, sTema, sAsunto, sActividades, sDetalle, sPlan, sCon, iResultado, iBeneficio, iUsr, iIdBQ ,iIdioma);

                DataTable dtAnalisis = DBHelper.getBQInvTema(iIdQueja, iIdioma);
                gvTemas.DataSource = dtAnalisis;
                gvTemas.DataBind();
                if (dtAnalisis.Rows.Count > 0)
                {
                    if (iIdioma == 2)
                    {
                        GridViewRow header = gvTemas.HeaderRow;
                        header.Cells[0].Text = "Investigation Id";
                        header.Cells[1].Text = "Investigation Topic";
                        header.Cells[2].Text = "Investigation Case";
                        header.Cells[3].Text = "Investigation Activities";
                        header.Cells[4].Text = "Accion Plan";
                        header.Cells[5].Text = "Conclutions";
                        header.Cells[6].Text = "Benefit";
                        header.Cells[7].Text = "Result";
                    }
                    else
                    {
                        GridViewRow header = gvTemas.HeaderRow;
                        header.Cells[0].Text = "Id Investigacion";
                        header.Cells[1].Text = "Tema Investigacion";
                        header.Cells[2].Text = "Asunto Investigacion";
                        header.Cells[3].Text = "Actividades Investigacion";
                        header.Cells[4].Text = "Plan Accion";
                        header.Cells[5].Text = "Conclusiones";
                        header.Cells[6].Text = "Beneficio";
                        header.Cells[7].Text = "Resultado";
                    }
                }

            }

        }


        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_DetalleMensaje(int iIdQueja)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dt = DBHelper.getDetalleMensaje(iIdQueja);
            string str = JsonConvert.SerializeObject(dt);
            return (str);

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