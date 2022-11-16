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

namespace Seguimiento_Web
{
    public partial class CasosAsociados : Page
    {
        DBHelper DBHelper = new DBHelper();

        public DataTable tags { get; set; }

        public DataRow[] row { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && Request.QueryString["denuncia"] != null)
            {

                int id = int.Parse(Request.QueryString["id"]);
                int idDenuncia = int.Parse(Request.QueryString["denuncia"]);

                int acceso = 0;

                acceso = ValidarAcceso(idDenuncia, int.Parse(Session["idUsuario"].ToString()));

                if (acceso == 0)
                {
                    if (Request.QueryString["origen"] != null)
                    {
                        acceso = 4;
                    }
                }

                if (acceso > 0)
                {
                    CargarDenuncia(id);
                }
                else
                {
                    Response.Redirect("Dashboard");
                }

                int idioma = int.Parse(Session["idioma"].ToString());

                cargarTags(idioma);

            }
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

        protected void CargarDenuncia(int idDenuncia)
        {
            int idioma = int.Parse(Session["idioma"].ToString());
            DataTable denuncia = DBHelper.getDenunciaAsociada(idDenuncia, idioma);

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
        public static string validarTema(int idTema)
        {
            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.validarTema(idTema);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
    }
}