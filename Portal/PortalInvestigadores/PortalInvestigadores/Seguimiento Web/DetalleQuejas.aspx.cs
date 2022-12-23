using Newtonsoft.Json;
using Portal_Investigadores;
using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
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

                int idBQ = int.Parse(Session["idBq"].ToString());
                CargarComentariosBQ(iIdQueja);

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

                // Tipo
                DataTable tipos = DBHelper.getTiposMensaje(idBQ);
                DataRow dr = tipos.NewRow();

                if (sIdioma == "2")
                {
                    dr["Descripcion"] = "Select Value";
                    dr["IdTipo"] = "0";
                    tipos.Rows.Add(dr);

                }
                else
                {
                    dr["Descripcion"] = "Selecciona un Valor";
                    dr["IdTipo"] = "0";
                    tipos.Rows.Add(dr);
                }
                tipos.DefaultView.Sort = "IdTipo";
                ddlTipo.DataSource = tipos;
                ddlTipo.DataTextField = "Descripcion";
                ddlTipo.DataValueField = "IdTipo";
                ddlTipo.DataBind();


                // Investigacion Analisis
                Cargar_InvestigacionTemas(iIdQueja, Convert.ToInt32(sIdioma));
                //Investigacion Involucrados
                Cargar_InvestigacionInv(iIdQueja, Convert.ToInt32(sIdioma));




            }
        }
        protected void btnCom_Click(object sender, EventArgs e)
        {
            int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
            string sConclusion = txtConclusion.Text;
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
            string sDetalle = mTxtDetalle.Text;
            string sPlan = mTxtPlan.Text;
            string sCon = mTxtConclusiones.Text;

            if (beneficioDDL.SelectedIndex != 0 && resultadoDDL.SelectedIndex != 0)
            {
                int iBeneficio = Convert.ToInt32(beneficioDDL.SelectedValue);
                int iResultado = Convert.ToInt32(resultadoDDL.SelectedValue);
                DBHelper.postBQInvTema("NEW", iIdQueja, sTema, sAsunto, sActividades, sDetalle, sPlan, sCon, iResultado, iBeneficio, iUsr, iIdBQ, iIdioma, 0);
                Cargar_InvestigacionTemas(iIdQueja, iIdioma);
            }

        }
        protected void delTemas_Click(object sender, EventArgs e)
        {

            int iUsr = int.Parse(Session["idUsuario"].ToString());
            int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
            int iIdBQ = int.Parse(Session["idBQ"].ToString());
            int iIdioma = int.Parse(Session["idioma"].ToString());

            foreach (GridViewRow gvRow in gvTemas.Rows)
            {
                var chk = gvRow.FindControl("Chk1") as CheckBox;
                if (chk.Checked == true)
                {
                    int iTemaId = Convert.ToInt32(gvRow.Cells[1].Text);
                    DBHelper.postBQInvTema("CAN", iIdQueja, "", "", "", "", "", "", 0, 0, iUsr, iIdBQ, 0, iTemaId);
                }
            }

            Cargar_InvestigacionTemas(iIdQueja, iIdioma);
        }
        protected void btnInvGuardar_Click(object sender, EventArgs e)
        {
            int iIdioma = int.Parse(Session["idioma"].ToString());
            int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
            int iIdBQ = int.Parse(Session["idBq"].ToString());
            int iUsr = int.Parse(Session["idUsuario"].ToString());
            string sNombre = txtInvNombre.Text;
            string sPuesto = txtInvPuesto.Text;
            int iTipo = Convert.ToInt32(ddlTipo.SelectedValue);
            DateTime dFechaIng = Convert.ToDateTime(fechaIngreso.Text);
            DateTime dFechaCom = Convert.ToDateTime(fechaCom.Text);

            DBHelper.postBQInvInvolucrados("NEW",iIdQueja, sNombre, sPuesto, iTipo, dFechaIng, dFechaCom, iUsr, iIdBQ,0);
            Cargar_InvestigacionInv(iIdQueja, iIdioma);

        }

        protected void delInv_Click(object sender, EventArgs e)
        {

            int iUsr = int.Parse(Session["idUsuario"].ToString());
            int iIdQueja = int.Parse(Request.QueryString["idQueja"]);
            int iIdBQ = int.Parse(Session["idBQ"].ToString());
            int iIdioma = int.Parse(Session["idioma"].ToString());

            foreach (GridViewRow gvRow in gvInv.Rows)
            {
                var chk = gvRow.FindControl("Chk2") as CheckBox;
                if (chk.Checked == true)
                {
                    int iIdInv = Convert.ToInt32(gvRow.Cells[1].Text);
                    DBHelper.postBQInvInvolucrados("CAN", iIdQueja,"","",0, DateTime.Now,DateTime.Now, iUsr, iIdBQ, iIdInv);
                }
            }

            Cargar_InvestigacionInv(iIdQueja, iIdioma);
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
        [WebMethod]
        public static string SaveEntrevistadoBQ(int idQueja, int idEntrevistado, string nombre, string puesto, string entrevistador, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveEntrevistadoBQ(idQueja, idEntrevistado, nombre, puesto, entrevistador, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        [WebMethod]
        public static string CargarEntrevistadosBQ(string idQueja)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable entrevistados = DBHelper.getEntrevistadosBQ(Int64.Parse(idQueja));

            DataSet ds = new DataSet();
            ds.Tables.Add(entrevistados);

            Dictionary<string, object> dict = new Dictionary<string, object>();
            foreach (DataTable dt in ds.Tables)
            {
                object[] arr = new object[dt.Rows.Count + 1];

                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    arr[i] = dt.Rows[i].ItemArray;
                }

                dict.Add(dt.TableName, arr);
            }

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(dict);

        }
        [WebMethod]
        public static string DeleteEntrevistadoBQ(int idEntrevistado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteEntrevistadoBQ(idEntrevistado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        [WebMethod]
        public static string SaveComentarioBQ(int idQueja, string comentario, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveComentarioBQ(idQueja, comentario, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        protected void CargarComentariosBQ(int idQueja)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable comentarios = DBHelper.getComentariosBQ(idQueja);
            string comment;
            string salto;

            if (comentarios.Rows.Count > 0)
            {

                for (int i = 0; i < comentarios.Rows.Count; i++)
                {

                    comment = comentarios.Rows[i][0].ToString();

                    if (txtDisplayComentario.Text != "")
                        salto = "\n";
                    else
                        salto = "";

                    txtDisplayComentario.Text = txtDisplayComentario.Text + salto + comment;

                }

            }

        }

        public void Cargar_InvestigacionTemas(int iIdQueja, int iIdioma)
        {
            DataTable dtAnalisis = DBHelper.getBQInvTema(iIdQueja, iIdioma);
            gvTemas.DataSource = dtAnalisis;
            gvTemas.DataBind();

            if (dtAnalisis.Rows.Count > 0)
            {
                if (iIdioma == 2)
                {
                    GridViewRow header = gvTemas.HeaderRow;
                    header.Cells[0].Text = "Select";
                    header.Cells[1].Text = "Topic Id";
                    header.Cells[2].Text = "Investigation Topic";
                    header.Cells[3].Text = "Investigation Case";
                    header.Cells[4].Text = "Investigation Activities";
                    header.Cells[5].Text = "Accion Plan";
                    header.Cells[6].Text = "Conclutions";
                    header.Cells[7].Text = "Benefit";
                    header.Cells[8].Text = "Result";
                }
                else
                {
                    GridViewRow header = gvTemas.HeaderRow;
                    header.Cells[0].Text = "Seleccionar";
                    header.Cells[1].Text = "Id Tema";
                    header.Cells[2].Text = "Tema Investigacion";
                    header.Cells[3].Text = "Asunto Investigacion";
                    header.Cells[4].Text = "Actividades Investigacion";
                    header.Cells[5].Text = "Plan Accion";
                    header.Cells[6].Text = "Conclusiones";
                    header.Cells[7].Text = "Beneficio";
                    header.Cells[8].Text = "Resultado";
                }
            }
        }
        public void Cargar_InvestigacionInv(int iIdQueja, int iIdioma)
        {
            DataTable dtInvolucrados = DBHelper.getBQInvInvolucrados(iIdQueja);
            gvInv.DataSource = dtInvolucrados;
            gvInv.DataBind();
            if (dtInvolucrados.Rows.Count > 0)
            {
                if (iIdioma == 2)
                {
                    GridViewRow header = gvInv.HeaderRow;
                    header.Cells[0].Text = "Select";
                    header.Cells[1].Text = "Involved Id";
                    header.Cells[2].Text = "Name";
                    header.Cells[3].Text = "Position";
                    header.Cells[4].Text = "Type";
                    header.Cells[5].Text = "Create Date";
                    header.Cells[6].Text = "Due Date";
                }
                else
                {
                    GridViewRow header = gvInv.HeaderRow;
                    header.Cells[0].Text = "Seleccionar";
                    header.Cells[1].Text = "Id Involucrado";
                    header.Cells[2].Text = "Nombre";
                    header.Cells[3].Text = "Puesto";
                    header.Cells[4].Text = "Tipo";
                    header.Cells[5].Text = "Fecha Registro";
                    header.Cells[6].Text = "Fecha Compromiso";
                }
            }

        }
    }
 }