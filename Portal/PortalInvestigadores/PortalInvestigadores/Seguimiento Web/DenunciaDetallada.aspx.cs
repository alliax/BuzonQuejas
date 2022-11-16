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
    public partial class DenunciaDetallada : Page
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


                    if (Request.QueryString["tipo"] != null)
                    {
                       // Master.menu.Visible = false;
                      
                        //Master.menuLine.Visible = false;

                        //Session["tipoLectura"] = "1";

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

                //int acceso = ValidarAcceso(id, int.Parse(Session["idUsuario"].ToString()));

                int acceso = 1;

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
               
                CargarComentarios(idDenuncia);

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
               
            }
            else {
                delegadoDDL.Enabled = false;
                
            }

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

            DataTable invDenuncia = DBHelper.getInvInvestigacionDetalle(Int64.Parse(idDenuncia));

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
        public static string CargarTemasDetallado(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable temas = DBHelper.getTemasDetallado(Int64.Parse(idDenuncia));

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

       

    }
}