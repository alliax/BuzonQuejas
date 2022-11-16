using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.Services;
using Portal_Investigadores.clases;

namespace Portal_Investigadores
{
    public partial class Denunciados : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        public DataTable tags { get; set; }

        public DataRow[] row { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["username"] == null)
            //{
            //    //Si no esta activa se redirecciona al Login
            //    Response.Redirect("Login");
            //}

            //if (Session["adminDen"].ToString() != "1")
            //{
            //    Response.Redirect("Dashboard.aspx", true);
            //}

            if (Request.QueryString["id"] != null  && Request.QueryString["tipo"] != null)
            {
                Session["tipoUsuario"] = "2";
                Session["esInvestigador"] = "0";
                Session["esDelegado"] = "0";
                Session["esRevisor"] = "0";
                Session["esEnterado"] = "0";
                Session["idioma"] = "1";
                Session["adminDen"] = "0";

                int id = int.Parse(Request.QueryString["id"]);
                int tipo = int.Parse(Request.QueryString["tipo"]);
                string usuario = Request.QueryString["usuario"];
                string grupo = Request.QueryString["grupo"];
                txtFolio.Text = id.ToString();
                txtTipo.Text = tipo.ToString();
                txtUsuario.Text = usuario;

                //int acceso = ValidarAcceso(id, int.Parse(Session["idUsuario"].ToString()));

                //cargarTags(idioma);
                BindGridDenunciados(id,tipo, grupo);

            }

        }

        protected void cargarTags(int idioma)
        {
            this.tags = DBHelper.getTags(4, idioma);
        }

        public void BindGridDenunciados(int id, int tipo, string grupo)
        {
            DataTable denunciados = DBHelper.loadDenunciados(id, tipo, grupo);

            if (denunciados.Rows.Count > 0)
            {
                gvDenunciados.DataSource = denunciados;
                gvDenunciados.DataBind();

            }
            else
            {
                gvDenunciados.Visible = false;
                gvDenunciados.Visible = false;
            }

        }

        protected void gvDenunciados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            TableCell cell = e.Row.Cells[0];
            TableCell cell1 = e.Row.Cells[1];
            TableCell cell2 = new TableCell();

            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);
            if (e.Row.Cells[10].Text == "1")
            {                
                e.Row.Cells.Add(cell1);
            }
            else 
            {
                e.Row.Cells.Add(cell2);
            }

            if (e.Row.Cells[9].Text == "1")
            {
                e.Row.Style.Add("Display", "none");
                
            }

            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
            
                //if (e.Row.Cells[2].Text == "")
                //    e.Row.Visible = false;


        }

        [WebMethod]
        public static string CargarDenunciasAntecedentes(string idDenuncia, int tipo)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable invDenuncia = DBHelper.getDenAnt(Int64.Parse(idDenuncia), tipo);

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

        //[WebMethod]
        //public static string CargarBusqueda(string idDenuncia)
        //{
        //    var serializer = new JavaScriptSerializer();

        //    // For simplicity just use Int32's max value.
        //    // You could always read the value from the config section mentioned above.
        //    serializer.MaxJsonLength = Int32.MaxValue;

        //    DBHelper DBHelper = new DBHelper();

        //    DataTable invDenuncia = DBHelper.loadDenunciados(int.Parse(idDenuncia), 1);

        //    DataSet ds = new DataSet();
        //    ds.Tables.Add(invDenuncia);

        //    Dictionary<string, object> dict = new Dictionary<string, object>();
        //    foreach (DataTable dt in ds.Tables)
        //    {
        //        object[] arr = new object[dt.Rows.Count + 1];

        //        for (int i = 0; i <= dt.Rows.Count - 1; i++)
        //        {
        //            arr[i] = dt.Rows[i].ItemArray;
        //        }

        //        dict.Add(dt.TableName, arr);
        //    }

        //    JavaScriptSerializer json = new JavaScriptSerializer();
        //    return json.Serialize(dict);

        //}

        [WebMethod]
        public static string SaveDenunciado(int id, int idDenuncia, int tipo, string usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveDenunciado(id, idDenuncia, tipo, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string delDenunciado(int id, int idDenuncia, int tipo, string usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.delDenunciado(id, idDenuncia, tipo, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

    }
}