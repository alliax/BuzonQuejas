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
using System.Text.RegularExpressions;


namespace Portal_Investigadores
{
    public partial class UsuarioBuzon : Page
    {
        DBHelper DBHelper = new DBHelper();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            panelSubtema.Visible = false;
            if (!Page.IsPostBack)
            {
                int id = int.Parse(Request.QueryString["id"]);
                string grupo = Request.QueryString["grupo"];
                string empresa = Request.QueryString["empresa"];
                txtNombre.Text = Request.QueryString["nombre"];
                txtIdUsuario.Text = id.ToString();
                txtUsuario.Text = Request.QueryString["usuario"];
                CargarGrupos(grupo);
                CargarEmpresas(grupo, empresa);
                CargarBuzones(empresa, grupo);
                CargarUsuariosBuzones(id);                

            }
        }
        protected void CargarGrupos(string grupo)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable grupos = DBHelper.getGrupos();

            DataRow dr = grupos.NewRow();
            dr["Grupo"] = "0";
            dr["Descripcion"] = "Selecciona un Grupo";
            grupos.Rows.Add(dr);

            ddlGrupo.DataSource = grupos;
            ddlGrupo.DataTextField = grupos.Columns["Descripcion"].ToString();
            ddlGrupo.DataValueField = grupos.Columns["Grupo"].ToString();
            ddlGrupo.DataBind();

            ddlGrupo.SelectedValue = grupo;
        }
        protected void CargarEmpresas(string grupo, string empresa)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable empresas = DBHelper.getEmpresas(grupo);

            DataRow dr = empresas.NewRow();
            dr["Empresa"] = "0";
            dr["Descripcion"] = "Selecciona una Empresa";
            empresas.Rows.Add(dr);

            ddlEmpresa.DataSource = empresas;
            ddlEmpresa.DataTextField = empresas.Columns["Descripcion"].ToString();
            ddlEmpresa.DataValueField = empresas.Columns["Empresa"].ToString();
            ddlEmpresa.DataBind();

            ddlEmpresa.SelectedValue = empresa;

        }
        protected void CargarBuzones(string empresa, string grupo)
        {
            DataTable buzones = DBHelper.getBuzonesByGrupoEmpresa(empresa, grupo);
            DataRow dr = buzones.NewRow();
            dr["idBQ"] = 0;
            dr["nombreBQ"] = "";
            dr["descripcion"] = "Selecciona un Buzon";
            buzones.Rows.Add(dr);

            ddlBuzon.DataSource = buzones;
            ddlBuzon.DataTextField = buzones.Columns["descripcion"].ToString();
            ddlBuzon.DataValueField = buzones.Columns["idBQ"].ToString();
            ddlBuzon.DataBind();

            ddlBuzon.SelectedValue = 0.ToString();
        }

        protected void CargarUsuariosBuzones(int idUsuario)
        {
            DataTable usuariosBuzones = DBHelper.getUsuariosBuzon(idUsuario);
            usuariosGV.DataSource = usuariosBuzones;
            usuariosGV.DataBind();
            ViewState["usuariosDt"] = usuariosBuzones;

        }

        protected void agregarUsuarioBuzon(object sender, EventArgs e)
        {
            
            int idBuzon = int.Parse(ddlBuzon.SelectedValue);
            int idUsuario = int.Parse(Request.QueryString["id"]);
            string usuario = Session["username"].ToString();
            DataTable dt = DBHelper.checarRegistroUsuariosBuzones(idUsuario, idBuzon);

            if(dt.Rows.Count > 0)
            {
                panelSubtema.Visible = true;
                lbl.Text = "Ya hay registro en ese buzon";
            }
            else
            {
                DBHelper.saveUsuariosBuzones(idUsuario, idBuzon,usuario, chbkVobo.Checked, 
                    chbkInvestigador.Checked, chbkDelegado.Checked, chbkRevisor.Checked, chbkEnterado.Checked, chbkAdmin.Checked
                    ,chbkActivo.Checked);
                CargarUsuariosBuzones(idUsuario);
            }
        }

        protected void ddlBuzon_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["usuariosDt"];
            string buzon = ddlBuzon.SelectedItem.Text;
            int idUsuario = int.Parse(Session["idUsuario"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["descripcion"].ToString() == buzon)
                {
                    chbkActivo.Checked = bool.Parse(dr["Activo"].ToString());
                    chbkVobo.Checked = bool.Parse(dr["BQEsVobo"].ToString());
                    chbkInvestigador.Checked = bool.Parse(dr["EsInvestigador"].ToString());
                    chbkDelegado.Checked = bool.Parse(dr["EsDelegado"].ToString());
                    chbkRevisor.Checked = bool.Parse(dr["EsRevisor"].ToString());
                    chbkEnterado.Checked = bool.Parse(dr["EsEnterado"].ToString());
                    chbkAdmin.Checked = bool.Parse(dr["AdminQuejas"].ToString());
                    cargarDelegadosCatalogo(int.Parse(dr["idBQ"].ToString()), idUsuario);
                    cargarRevisadosCatalogo(int.Parse(dr["idBQ"].ToString()), idUsuario);
                    cargarEnteradosCatalogo(int.Parse(dr["idBQ"].ToString()), idUsuario);

                }
            }
            
        }

        protected void cargarDelegadosCatalogo(int idBQ, int idUsuario)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable delegados = DBHelper.getDelegadosCatalogoBQ(idBQ, idUsuario);

            DataRow dr = delegados.NewRow();
            dr["idUsuario"] = "0";
            dr["nombre"] = "Selecciona un Delegado";
            delegados.Rows.Add(dr);

            ddlDelegados.DataSource = delegados;
            ddlDelegados.DataTextField = delegados.Columns["nombre"].ToString();
            ddlDelegados.DataValueField = delegados.Columns["idUsuario"].ToString();
            ddlDelegados.DataBind();

            ddlDelegados.SelectedValue = "0";
        }

        protected void cargarRevisadosCatalogo(int idBQ, int idUsuario)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable revisados = DBHelper.getRevisadosCatalogoBQ(idBQ, idUsuario);

            DataRow dr = revisados.NewRow();
            dr["idUsuario"] = "0";
            dr["nombre"] = "Selecciona a quien Revisa";
            revisados.Rows.Add(dr);

            ddlRevisados.DataSource = revisados;
            ddlRevisados.DataTextField = revisados.Columns["nombre"].ToString();
            ddlRevisados.DataValueField = revisados.Columns["idUsuario"].ToString();
            ddlRevisados.DataBind();

            ddlRevisados.SelectedValue = "0";
        }
        protected void cargarEnteradosCatalogo(int idBQ, int idUsuario)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable enterados = DBHelper.getEnteradoCatalogoBQ(idBQ, idUsuario);

            DataRow dr = enterados.NewRow();
            dr["idUsuario"] = "0";
            dr["nombre"] = "Selecciona de quien es Enterado";
            enterados.Rows.Add(dr);

            ddlEnterados.DataSource = enterados;
            ddlEnterados.DataTextField = enterados.Columns["nombre"].ToString();
            ddlEnterados.DataValueField = enterados.Columns["idUsuario"].ToString();
            ddlEnterados.DataBind();

            ddlEnterados.SelectedValue = "0";
        }
        protected void editarUsuarioBuzon(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["usuariosDt"];
            string buzon = ddlBuzon.SelectedItem.Text;
            int idBuzon = int.Parse(ddlBuzon.SelectedValue);
            int idUsuario = int.Parse(Request.QueryString["id"]);
            //string usuario = Session["username"].ToString();
            string output = "";
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["descripcion"].ToString() == buzon)
                {
                    output = DBHelper.updateUsuarioBuzon(idUsuario,idBuzon, chbkVobo.Checked
                        ,chbkInvestigador.Checked, chbkDelegado.Checked, chbkRevisor.Checked, chbkEnterado.Checked
                        ,chbkAdmin.Checked, chbkActivo.Checked);
                    if(output == "OK")
                    {
                        CargarUsuariosBuzones(idUsuario);
                    }
                }
            }
        }
        [WebMethod]
        public static string AgregarDelegadoBQ(int idResponsable, int idDelegado, int usuarioAlta, int idBQ)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.agregarDelegadoBQ(idResponsable, idDelegado, usuarioAlta, idBQ);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        [WebMethod]
        public static string CargarDelegadosAsignadosBQ(int idResponsable, int idBQ)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable delegados = DBHelper.getDelegadosAsignadosBQ(idResponsable, idBQ);

            DataSet ds = new DataSet();
            ds.Tables.Add(delegados);

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
        public static string AgregarRevisadoBQ(int idResponsable, int idRevisado, int usuarioAlta, int idBQ)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.agregarRevisadoBQ(idResponsable, idRevisado, usuarioAlta, idBQ);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        [WebMethod]
        public static string CargarRevisadosAsignadosBQ(int idResponsable, int idBQ)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable revisados = DBHelper.getRevisadosAsignadosBQ(idResponsable, idBQ);

            DataSet ds = new DataSet();
            ds.Tables.Add(revisados);

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
        public static string AgregarEnteradoBQ(int idResponsable, int idEnterado, int usuarioAlta, int idBQ)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.agregarEnteradoBQ(idResponsable, idEnterado, usuarioAlta, idBQ);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        [WebMethod]
        public static string CargarEnteradosAsignadosBQ(int idResponsable, int idBQ)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable enterados = DBHelper.getEnteradosAsignadosBQ(idResponsable, idBQ);

            DataSet ds = new DataSet();
            ds.Tables.Add(enterados);

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