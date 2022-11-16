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

namespace Portal_Investigadores
{
    public partial class Detalle : Page
    {
        DBHelper DBHelper = new DBHelper();

        public DataTable tags { get; set; }

        public DataRow[] row { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.QueryString["user"] != null) {

                DataTable user = DBHelper.getUserInfoBuzon(Request.QueryString["user"]);

                if (user.Rows.Count > 0)
                {
                    Session["idUsuario"] = user.Rows[0][0].ToString();
                    Session["nomUsuario"] = user.Rows[0][1].ToString();
                    Session["username"] = Request.QueryString["user"];
                    Session["tipoUsuario"] = "2";
                    Session["esInvestigador"] = "0";
                    Session["esDelegado"] = "0";
                    Session["esRevisor"] = "0";
                    Session["esEnterado"] = "0";
                    Session["idioma"] = "1";
                    Session["adminDen"] = "0";


                    if (Request.QueryString["tipo"] != null)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "hideMenu()", true);
                    }

                }
            }

            if (Session["username"] == null)
            {
                //Si no esta activa se redirecciona al Login
                Response.Redirect("Login");
            }

            if (Request.QueryString["id"] != null)
            {

                int id = int.Parse(Request.QueryString["id"]);

                int acceso = ValidarAcceso(id, int.Parse(Session["idUsuario"].ToString()));

                if (acceso > 0)
                {
                    CargarDenuncia(id, acceso);
                }
                else
                {
                    Response.Redirect("Dashboard");
                }
                
            }

            int idioma = int.Parse(Session["idioma"].ToString());

            cargarTags(idioma);

            //BindGridInvolucrados(id);
        }

        protected void cargarTags(int idioma)
        {
            //int idioma = int.Parse(Session["idioma"].ToString());
            this.tags = DBHelper.getTags(3, idioma);

            JavaScriptSerializer oSerializer = new JavaScriptSerializer();

            var Result = (from c in tags.AsEnumerable()
                          select new
                          {
                              id = c.Field<int>("id"),
                              tag = c.Field<string>("tag")
                          }).ToList();
            tagsJS.Value = oSerializer.Serialize(Result);
        }

        protected int ValidarAcceso(int idDenuncia, int idUsuario)
        {
            int tipoAsignacion = DBHelper.getAcceso(idDenuncia, idUsuario);

            Session["tipoAsignacion"] = tipoAsignacion;

            return tipoAsignacion;
        }

        protected void CargarDenuncia(int idDenuncia, int acceso)
        {
            int idioma = int.Parse(Session["idioma"].ToString());
            DataTable denuncia = DBHelper.getDenuncia(idDenuncia,idioma);
            //int den = int.Parse(infoDenuncia.Rows[0][0].ToString());

            if (denuncia.Rows.Count > 0)
            {

                txtFolio.Text = denuncia.Rows[0][0].ToString();
                txtGrupo.Text = denuncia.Rows[0][1].ToString();
                txtEmpresa.Text = denuncia.Rows[0][2].ToString();
                txtSitio.Text = denuncia.Rows[0][3].ToString();
                txtDepartamento.Text = denuncia.Rows[0][4].ToString();
                txtTema.Text = denuncia.Rows[0][5].ToString();
                txtSubtema.Text = denuncia.Rows[0][6].ToString();
                txtTitulo.Text = denuncia.Rows[0][7].ToString();
                txtDenuncia.Text = denuncia.Rows[0][8].ToString();
                txtResumen.Text = denuncia.Rows[0][9].ToString();
                txtResponsable.Text = denuncia.Rows[0][11].ToString();
                int idDelegado = int.Parse(denuncia.Rows[0][12].ToString());
                txtConclusion.Text = denuncia.Rows[0][13].ToString();
                int estatus = int.Parse(denuncia.Rows[0][14].ToString());
                int idRevisor = int.Parse(denuncia.Rows[0][15].ToString());
                int visto = int.Parse(denuncia.Rows[0][16].ToString());
                Session["estatusDenuncia"] = estatus;
                if (estatus == 4 && acceso < 5) {
                    Response.Redirect("Dashboard");
                }
                CargarDelegados(idDenuncia, idDelegado, acceso, estatus);
                CargarResultados();
                CargarBeneficios();
                CargarComentarios(idDenuncia);
                MostrarBotones(acceso, estatus, idRevisor);

                //visto == 0
                if (acceso == 1) {
                    if (visto == 0)
                    {
                        btnRInv.Visible = true;
                    }
                    DBHelper.updateVisto(idDenuncia, int.Parse(Session["idUsuario"].ToString()));
                }

                //txtNomInvolucrado.Text = denuncia.Rows[0][9].ToString();
                //txtMensaje.Text= denuncia.Rows[0][10].ToString();
            }

        }

        protected void MostrarBotones(int acceso, int estatus, int idRevisor)
        {

            //Si es Responsable(1) y la denuncia esta asignada(2), puede guardar, enviar a Auditoría 
            if (acceso == 1 &&  estatus == 2  )
            {
                //Si se tiene un Revisor, se puede mandar a revision y guardar, sino, se puede enviar a Auditoria y Guardar
                if (idRevisor > 0)
                {
                    btnGuardar.Visible = true;
                    btnRevision.Visible = true;
                }
                else
                {
                    btnGuardar.Visible = true;
                    btnAuditoria.Visible = true;
                }
            }

            //Si es Delegado(2) y la denuncia esta asignada(2), puede guardar, enviar a VoBo 
            if (acceso == 2 && estatus == 2)
            {
                btnGuardar.Visible = true;
                btnVoBo.Visible = true;
            }

            //Si es Revisor(3) y la denuncia esta asignada(2) o esta pendiente de VoBo(3), puede guardar, enviar a Auditoría 
            if (acceso == 3 && (estatus == 2 || estatus == 3 ))
            {
                btnGuardar.Visible = true;
                btnAuditoria.Visible = true;
            }

            //Si es Responsable(1) y la denuncia esta pend VoBo(3), puede guardar, enviar a Auditoría, rechazar
            if (acceso == 1 && estatus == 3 )
            {
                if (idRevisor > 0)
                {
                    btnGuardar.Visible = true;
                    btnRevision.Visible = true;
                    btnRechazo.Visible = true;
                }
                else
                {
                    btnGuardar.Visible = true;
                    btnAuditoria.Visible = true;
                    btnRechazo.Visible = true;
                }
            }

            //Si es Revisor (3) y la deenuncia esta pend de revision (5), puede guardar, enviar a Auditoria y Rechazar
            if (acceso == 3 && estatus == 5)
            {
                btnGuardar.Visible = true;
                btnAuditoria.Visible = true;
                btnRechazo.Visible = true;
            }

            //Si es usuario de Auditoria y la denuncia esta en pendiente de revisión por Auditoría, muestra los botones de aceptar(mandar a GTE) y rechazar la denuncia
            if (acceso == 5 && estatus == 4)
            {
                btnAceptarOBT.Visible = true;
                btnRechazo.Visible = true;
            }

            //Si es Gte de Auditoria y la denuncia esta en pendiente por Gte
            if (acceso == 6 && estatus == 7)
            {
                btnAceptar.Visible = true;
                btnRechazo.Visible = true;
            }

            //if (estatus == 4)
            //{
            //    btnRechazo.Visible = false;
            //    btnVoBo.Visible = false;
            //    btnRevision.Visible = false;
            //    btnGuardar.Visible = false;
            //    btnAuditoria.Visible = false;
            //    btnDelegar.Disabled = true;
            //    delegadoDDL.Enabled = false;
            //}
            //else
            //{
            //    //Si es Responsable(1) y la denuncia esta asignada(2), puede guardar, enviar a Auditoría 
            //    if (estatus == 2 && acceso == 1)
            //    {

            //        if (idRevisor > 0)
            //        {
            //            btnAuditoria.Visible = false;
            //            btnVoBo.Visible = false;
            //            btnRechazo.Visible = false;
            //        }
            //        else
            //        {
            //            btnVoBo.Visible = false;
            //            btnRevision.Visible = false;
            //            btnRechazo.Visible = false;
            //        }

            //        //btnRechazo.Visible = false;
            //        //btnVoBo.Visible = false;
            //        //btnRevision.Visible = false;
            //    }

            //    //Si es Delegado(2) y la denuncia esta asignada(2), puede guardar, enviar a VoBo 
            //    if (estatus == 2 && acceso == 2)
            //    {
            //        btnAuditoria.Visible = false;
            //        btnRechazo.Visible = false;
            //        btnRevision.Visible = false;
            //    }

            //    //Si es Revisor(3) y la denuncia esta asignada(2), puede guardar, enviar a Auditoría 
            //    if (estatus == 2 && acceso == 3)
            //    {
            //        btnRechazo.Visible = false;
            //        btnVoBo.Visible = false;
            //        btnRevision.Visible = false;
            //    }

            //    //Si es Revisor(3) y la denuncia esta pendienteVoBo(3), puede guardar, enviar a Auditoría 
            //    if (estatus == 3 && acceso == 3)
            //    {
            //        //btnRechazo.Visible = false;
            //        btnVoBo.Visible = false;
            //        btnRevision.Visible = false;
            //    }

            //    //Si es Responsable(1) y la denuncia esta pend VoBo(3), puede guardar, enviar a Auditoría, rechazar
            //    if (estatus == 3 && acceso == 1)
            //    {
            //        if (idRevisor > 0)
            //        {
            //            btnAuditoria.Visible = false;
            //            btnVoBo.Visible = false;
            //        }
            //        else
            //        {
            //            btnVoBo.Visible = false;
            //            btnRevision.Visible = false;
            //        }
            //    }
            //    if (estatus == 5 && acceso == 3)
            //    {
            //        btnVoBo.Visible = false;
            //        btnRevision.Visible = false;
            //    }
            //}

        }

        protected void CargarDelegados(int idDenuncia, int idDelegado, int acceso, int estatus )
        {
            DBHelper DBHelper = new DBHelper();
            DataTable delegados = DBHelper.getDelegados(idDenuncia);

            int idioma = int.Parse(Session["idioma"].ToString());
            DataRow dr = delegados.NewRow();
            dr["idUsuario"] = 0;
            if (idioma == 1) {
                dr["nombre"] = "Selecciona un Delegado";
            }
            else {
                dr["nombre"] = "Select Delegate";
            }
            delegados.Rows.Add(dr);

            delegadoDDL.DataSource = delegados;
            delegadoDDL.DataTextField = delegados.Columns["nombre"].ToString();
            delegadoDDL.DataValueField = delegados.Columns["idUsuario"].ToString();
            delegadoDDL.DataBind();

            delegadoDDL.SelectedValue = idDelegado.ToString();

            if (acceso == 1 && estatus == 2) {
                delegadoDDL.Enabled = true;
                btnDelegar.Disabled = false;
            }
            else {
                delegadoDDL.Enabled = false;
                btnDelegar.Disabled = true;
            }

        }

        protected void CargarResultados()
        {
            int idioma = int.Parse(Session["idioma"].ToString());

            DBHelper DBHelper = new DBHelper();
            DataTable resultados = DBHelper.getResultados(idioma);

            DataRow dr = resultados.NewRow();
            dr["idResultado"] = 0;
            if (idioma == 1)
            {
                dr["nombre"] = "Selecciona un Resultado";
            }
            else {
                dr["nombre"] = "Select Veracity Level";
            }
            
            resultados.Rows.Add(dr);

            resultadoDDL.DataSource = resultados;
            resultadoDDL.DataTextField = resultados.Columns["nombre"].ToString();
            resultadoDDL.DataValueField = resultados.Columns["idResultado"].ToString();
            resultadoDDL.DataBind();

            resultadoDDL.SelectedValue = 0.ToString();

        }

        protected void CargarBeneficios()
        {
            int idioma = int.Parse(Session["idioma"].ToString());

            DBHelper DBHelper = new DBHelper();
            DataTable beneficios = DBHelper.getBeneficios(idioma);

            DataRow dr = beneficios.NewRow();
            dr["idBeneficio"] = 0;
            if (idioma == 1)
            {
                dr["nombre"] = "Selecciona un Beneficio";
            }
            else {
                dr["nombre"] = "Select Benefit";
            }
            
            beneficios.Rows.Add(dr);

            beneficioDDL.DataSource = beneficios;
            beneficioDDL.DataTextField = beneficios.Columns["nombre"].ToString();
            beneficioDDL.DataValueField = beneficios.Columns["idBeneficio"].ToString();
            beneficioDDL.DataBind();

            beneficioDDL.SelectedValue = 0.ToString();

        }

        protected void CargarComentarios(int idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable comentarios = DBHelper.getComentarios(idDenuncia);
            string comment;
            string salto;

            if (comentarios.Rows.Count > 0) {

                for (int i = 0; i < comentarios.Rows.Count; i++) {

                    comment = comentarios.Rows[i][0].ToString();

                    if (txtDisplayComentario.Text != "")
                        salto = "\n";
                    else
                        salto = "";

                    txtDisplayComentario.Text = txtDisplayComentario.Text + salto + comment;

                }

            }

            //txtDisplayComentario.SelectionStart = txtDisplayComentario.Text.Length;
            //txtDisplayComentario.ScrollToCaret();
            //txtDisplayComentario.Refresh();

        }

        public void BindGridInvolucrados(int idDenuncia)
        {
            DataTable involucrados = DBHelper.loadInvInvestigacion(idDenuncia);

            if (involucrados.Rows.Count > 0)
            {

                //gvInvolucrados.DataSource = involucrados;
               
                //gvInvolucrados.DataBind();

                //row = tags.Select("id = '6'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[0].Text = row[0][1].ToString();
                //}

                //row = tags.Select("id = '7'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[1].Text = row[0][1].ToString();
                //}

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                //row = tags.Select("id = '9'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[3].Text = row[0][1].ToString();
                //}

                //row = tags.Select("id = '10'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[4].Text = row[0][1].ToString();
                //}

                //row = tags.Select("id = '11'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[5].Text = row[0][1].ToString();
                //}

                //row = tags.Select("id = '12'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[6].Text = row[0][1].ToString();
                //}
            }
            else
            {
                //gvInvolucrados.Visible = false;
                //gvInvolucrados.Visible = false;
            }
        }

        protected void gvInvolucrados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        [WebMethod]
        public static string CargarInvolucradosDenuncia(string idDenuncia, int idioma)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable invDenuncia = DBHelper.getInvDenuncia(Int64.Parse(idDenuncia), idioma);

            DataSet ds = new DataSet();
            ds.Tables.Add(invDenuncia);

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
        public static string CargarInvolucradosInvestigacion(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable invDenuncia = DBHelper.getInvInvestigacion(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(invDenuncia);

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
        public static string SaveInvolucrado(int idDenuncia, int idInvolucrado, string nombre, string puesto, int tipo, string fechaIngreso, int acciones, string fechaCompromiso, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveInvolucrado(idDenuncia, idInvolucrado, nombre, puesto, tipo, fechaIngreso, acciones, fechaCompromiso, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string CargarDenunciasAsociadas(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable invDenuncia = DBHelper.getDenunciasAsociadas(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(invDenuncia);

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
        public static string CargarDocumentos(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable invDenuncia = DBHelper.getDocumentos(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(invDenuncia);

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
        public static string CargarAcciones(int idioma)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable acciones = DBHelper.getAcciones(idioma);

            DataSet ds = new DataSet();
            ds.Tables.Add(acciones);

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
        public static string CargarTipos(int idioma)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable tipos = DBHelper.getTipos(idioma);

            DataSet ds = new DataSet();
            ds.Tables.Add(tipos);

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
        public static string CargarEntrevistados(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable entrevistados = DBHelper.getEntrevistados(Int64.Parse(idDenuncia));

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
        public static string SaveEntrevistado(int idDenuncia,int idEntrevistado, string nombre, string puesto, string entrevistador, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveEntrevistado(idDenuncia, idEntrevistado, nombre, puesto, entrevistador, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string DeleteEntrevistado(int idEntrevistado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteEntrevistado( idEntrevistado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string DeleteInvolucrado(int idInvolucrado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteInvolucrado(idInvolucrado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string DelegarDenuncia(string idDenuncia, string delegado, string usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.delegarDenuncia(Int64.Parse(idDenuncia), Int64.Parse(delegado), Int64.Parse(usuarioAlta));

            return resp.ToString();

        }

        [WebMethod]
        public static string CargarTemas(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable temas = DBHelper.getTemas(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(temas);

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
        public static string CargarModalTema(string idTema)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable tema = DBHelper.getTemaModal(Int64.Parse(idTema));

            DataSet ds = new DataSet();
            ds.Tables.Add(tema);

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
        public static string SaveTema(int idDenuncia,int idTema, string tema, string asunto, string actividades, string detalleActividades,string planAccion, string conclusiones, int resultado, int beneficio, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveTema(idDenuncia, idTema, tema, asunto, actividades,detalleActividades, planAccion, conclusiones, resultado, beneficio, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string DeleteTema(int idTema, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteTema(idTema, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SaveComentario(int idDenuncia, string comentario, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveComentario(idDenuncia, comentario, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SaveConclusion(int idDenuncia, string conclusion, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveConclusion(idDenuncia, conclusion, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SendAuditoria(int idDenuncia, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendAuditoria(idDenuncia, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SendVoBo(int idDenuncia, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendVoBo(idDenuncia, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SendRevision(int idDenuncia, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendRevision(idDenuncia, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SendRechazar(int idDenuncia, string comentarioRechazo, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendRechazar(idDenuncia, comentarioRechazo, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SendRechazarInv(int idDenuncia, string comentarioRechazo, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendRechazarInv(idDenuncia, comentarioRechazo, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SendGerente(int idDenuncia, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendGerente(idDenuncia, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string sendMadurez(int idDenuncia, int madurez, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.sendMadurez(idDenuncia, madurez, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string CargarSoporte(int tipo, int id)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable soportes = DBHelper.getSoportes(tipo,id);

            DataSet ds = new DataSet();
            ds.Tables.Add(soportes);

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
        public static string DeleteSoporte(int idSoporte, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteSoporte(idSoporte, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string validarTema(int idTema)
        {
            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.validarTema(idTema);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string CargarDenunciasAntecedentes(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable invDenuncia = DBHelper.getDenunciasAntecedentes(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(invDenuncia);

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

    }
}