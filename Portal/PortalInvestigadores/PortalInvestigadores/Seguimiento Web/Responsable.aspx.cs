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
using System.Xml.Linq;


namespace Portal_Investigadores
{
    public partial class Responsable : Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["user"] != null)
            {

                DataTable user = DBHelper.getUserInfoBuzon(Request.QueryString["user"]);

                if (user.Rows.Count > 0)
                {
                    Session["idUsuario"] = user.Rows[0][0].ToString();
                    Session["nomUsuario"] = user.Rows[0][1].ToString();
                    Session["username"] = Request.QueryString["user"];
                    Session["esInvestigador"] = "0";
                    Session["esDelegado"] = "0";
                    Session["esRevisor"] = "0";
                    Session["esEnterado"] = "0";

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
                CargarUsuario(id);
            }
            else {
                txtIdUsuario.Text = "0";
                CargarGrupos(0.ToString());
                chbkActivo.Checked = true;
                //divRelaciones.Visible = false;
                //CargarEmpresas(0);
                //CargarSitios(0);
                //CargarDepartamentos(0);
            }
        }

        protected void CargarUsuario(int idUsuario)
        {
            DataTable usuario = DBHelper.getUsuario(idUsuario);

            //int den = int.Parse(infoDenuncia.Rows[0][0].ToString());

            if (usuario.Rows.Count > 0)
            {

                txtIdUsuario.Text = usuario.Rows[0][0].ToString();
                txtUsuario.Text = usuario.Rows[0][1].ToString();
                txtNombre.Text = usuario.Rows[0][2].ToString();
                txtCorreo.Text = usuario.Rows[0][3].ToString();

                string grupo = usuario.Rows[0][4].ToString();
                CargarGrupos(grupo);

                string empresa = usuario.Rows[0][5].ToString();
                CargarEmpresas(grupo, empresa);
                CargarEmpresasAsigDen(grupo, empresa);

                string sitio = usuario.Rows[0][6].ToString();
                CargarSitios(grupo, empresa, sitio);
                CargarSitiosAsigDen(grupo, empresa, sitio);
                CargarAreasAsigDen();

                string departamento = usuario.Rows[0][7].ToString();
                CargarDepartamentos(grupo, departamento);

                CargarDelegados(grupo, empresa, idUsuario);
                CargarRevisados(grupo, empresa, idUsuario);
                CargarEnterados(grupo, empresa, idUsuario);

                chbkInvestigador.Checked = bool.Parse(usuario.Rows[0][8].ToString());
                txtDenunciasInvestigador.Text = usuario.Rows[0][9].ToString();
                chbkDelegado.Checked = bool.Parse(usuario.Rows[0][10].ToString());
                chbkRevisor.Checked = bool.Parse(usuario.Rows[0][11].ToString());
                txtDenunciasRevisor.Text = usuario.Rows[0][12].ToString();
                chbkEnterado.Checked = bool.Parse(usuario.Rows[0][13].ToString());
                chbkAdmin.Checked = bool.Parse(usuario.Rows[0][14].ToString());
                chbkActivo.Checked = bool.Parse(usuario.Rows[0][15].ToString());

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

            ddlGrupo2.DataSource = grupos;
            ddlGrupo2.DataTextField = grupos.Columns["Descripcion"].ToString();
            ddlGrupo2.DataValueField = grupos.Columns["Grupo"].ToString();
            ddlGrupo2.DataBind();

            ddlGrupo2.SelectedValue = grupo;

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

        protected void CargarEmpresasAsigDen(string grupo, string empresa)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable empresas = DBHelper.getEmpresas(grupo);
            DataTable empresasPerm = DBHelper.getEmpresasPermUsuario(txtIdUsuario.Text);

            lBxEmpresa.DataSource = empresas;
            lBxEmpresa.DataTextField = empresas.Columns["Descripcion"].ToString();
            lBxEmpresa.DataValueField = empresas.Columns["Empresa"].ToString();
            lBxEmpresa.DataBind();

            int contador = 0;

            if (empresasPerm.Rows.Count > 0)
            {

                foreach (ListItem item in lBxEmpresa.Items)
                {

                    for (int i = 0; i < empresasPerm.Rows.Count; i++)
                    {
                        string empAsig = empresasPerm.Rows[i][0].ToString();

                        if (empAsig == lBxEmpresa.Items[contador].Value)
                        {
                            lBxEmpresa.Items[contador].Selected = true;
                        }
                    }

                    contador++;
                }
            }
        }

        protected void CargarSitios(string grupo, string empresa, string sitio)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable sitios = DBHelper.getSitios(grupo, empresa);

            DataRow dr = sitios.NewRow();
            dr["Sitio"] = "0";
            dr["Descripcion"] = "Selecciona un Sitio";
            sitios.Rows.Add(dr);

            ddlSitio.DataSource = sitios;
            ddlSitio.DataTextField = sitios.Columns["Descripcion"].ToString();
            ddlSitio.DataValueField = sitios.Columns["Sitio"].ToString();
            ddlSitio.DataBind();

            ddlSitio.SelectedValue = sitio;

        }

        protected void CargarSitiosAsigDen(string grupo, string empresa, string sitio)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable sitiosAsig = DBHelper.getSitiosAdmDen(txtIdUsuario.Text);
            DataTable sitiosPerm = DBHelper.getSitiosPermUsuario(txtIdUsuario.Text);

            lBxSitio.DataSource = sitiosAsig;
            lBxSitio.DataTextField = sitiosAsig.Columns["Descripcion"].ToString();
            lBxSitio.DataValueField = sitiosAsig.Columns["Sitio"].ToString();
            lBxSitio.DataBind();

            int contador = 0;

            if (sitiosPerm.Rows.Count > 0)
            {

                foreach (ListItem item in lBxSitio.Items)
                {

                    for (int i = 0; i < sitiosPerm.Rows.Count; i++)
                    {
                        string empAsig = sitiosPerm.Rows[i][0].ToString();

                        if (empAsig == lBxSitio.Items[contador].Value)
                        {
                            lBxSitio.Items[contador].Selected = true;
                        }
                    }

                    contador++;
                }
            }
        }

        protected void CargarAreasAsigDen()
        {
            DBHelper DBHelper = new DBHelper();
            DataTable areasAsig = DBHelper.getAreasAdmDen(txtIdUsuario.Text);
            DataTable areasPerm = DBHelper.getAreasPermUsuario(txtIdUsuario.Text);

            lBxArea.DataSource = areasAsig;
            lBxArea.DataTextField = areasAsig.Columns["Descripcion"].ToString();
            lBxArea.DataValueField = areasAsig.Columns["ClasificacionT"].ToString();
            lBxArea.DataBind();

            int contador = 0;

            if (areasPerm.Rows.Count > 0)
            {

                foreach (ListItem item in lBxArea.Items)
                {

                    for (int i = 0; i < areasPerm.Rows.Count; i++)
                    {
                        string areaAsig = areasPerm.Rows[i][0].ToString();

                        if (areaAsig == lBxArea.Items[contador].Value)
                        {
                            lBxArea.Items[contador].Selected = true;
                        }
                    }

                    contador++;
                }
            }
        }

        protected void CargarDepartamentos(string grupo, string departamento)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable departamentos = DBHelper.getDepartamentos(grupo);

            DataRow dr = departamentos.NewRow();
            dr["Departamento"] = "0";
            dr["Descripcion"] = "Selecciona un Departamento";
            departamentos.Rows.Add(dr);

            ddlDepartamento.DataSource = departamentos;
            ddlDepartamento.DataTextField = departamentos.Columns["Descripcion"].ToString();
            ddlDepartamento.DataValueField = departamentos.Columns["Departamento"].ToString();
            ddlDepartamento.DataBind();

            ddlDepartamento.SelectedValue = departamento;

        }

        protected void CargarDelegados(string grupo, string empresa, int idUsuario)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable delegados = DBHelper.getDelegadosCatalogo(grupo,empresa,idUsuario);

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

        protected void CargarRevisados(string grupo, string empresa, int idUsuario)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable revisados = DBHelper.getRevisados(grupo, empresa, idUsuario);

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

        protected void CargarEnterados(string grupo, string empresa, int idUsuario)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable enterados = DBHelper.getEnterados(grupo, empresa, idUsuario);

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

        [WebMethod]
        public static string AgregarDelegado(int idResponsable, int idDelegado, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.agregarDelegado(idResponsable, idDelegado, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string AgregarRevisado(int idResponsable, int idRevisado, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.agregarRevisado(idResponsable, idRevisado, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string AgregarEnterado(int idResponsable, int idEnterado, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.agregarEnterado(idResponsable, idEnterado, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string CargarDelegadosAsignados(int idResponsable)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable delegados = DBHelper.getDelegadosAsignados(idResponsable);

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
        public static string CargarEnteradosAsignados(int idResponsable)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable enterados = DBHelper.getEnteradosAsignados(idResponsable);

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

        [WebMethod]
        public static string CargarRevisadosAsignados(int idResponsable)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable revisados = DBHelper.getRevisadosAsignados(idResponsable);

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
        public static string DeleteDelegado(int idResponsable,int idDelegado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteDelegado(idResponsable, idDelegado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string DeleteRevisado(int idResponsable,int idRevisado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteRevisado(idResponsable, idRevisado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string DeleteEnterado(int idResponsable, int idEnterado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteEnterado(idResponsable, idEnterado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SaveUsuario(int idUsuario, string usuario, string nombre, string correo, string grupo, string empresa, string sitio, string departamento, Int16 investigador, Int16 delegado, Int16 revisor,Int16 enterado, Int16 activo, int usuarioAlta, Int16 adminDen)
        {
                       
           DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.saveUsuario(idUsuario, usuario, nombre, correo, grupo, empresa, sitio, departamento, investigador, delegado, revisor, enterado, activo, usuarioAlta, adminDen);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SaveAdminDen(string empresas, int idUsuario, int usuarioAlta)
        {

            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.saveAdminDen(empresas, idUsuario, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SaveSitiosAdminDen(string sitios, int idUsuario, int usuarioAlta)
        {

            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.saveSitiosAdminDen(sitios, idUsuario, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string SaveAreasAdminDen(string areas, int idUsuario, int usuarioAlta)
        {

            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.saveAreasAdminDen(areas, idUsuario, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        [WebMethod]
        public static string CargarEmpresasAdd(string grupo)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable empresas = DBHelper.getEmpresas(grupo);

            DataRow dr = empresas.NewRow();
            dr["Empresa"] = "0";
            dr["Descripcion"] = "Selecciona una Empresa";
            empresas.Rows.Add(dr);

            DataSet ds = new DataSet();
            ds.Tables.Add(empresas);

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
        public static string CargarSitiosAdd(string grupo, string empresa)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable sitios = DBHelper.getSitios(grupo, empresa);

            DataRow dr = sitios.NewRow();
            dr["Sitio"] = "0";
            dr["Descripcion"] = "Selecciona un Sitio";
            sitios.Rows.Add(dr);

            DataSet ds = new DataSet();
            ds.Tables.Add(sitios);

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
        public static string CargarDepartamentosAdd(string grupo)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable departamentos = DBHelper.getDepartamentos(grupo);

            DataRow dr = departamentos.NewRow();
            dr["Departamento"] = "0";
            dr["Descripcion"] = "Selecciona un Departamento";
            departamentos.Rows.Add(dr);

            DataSet ds = new DataSet();
            ds.Tables.Add(departamentos);

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
        public static string DeleteAdminDen(int idResponsable)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteAdminDen(idResponsable);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

        protected void test_Click(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["id"]);
            string usuario = txtUsuario.Text;
            string nombre = txtNombre.Text;
            string grupo = ddlGrupo.SelectedValue;
            string empresa = ddlEmpresa.SelectedValue;
            Response.Redirect(string.Format("~/UsuarioBuzon.aspx?id={0}&usuario={1}&nombre={2}&grupo={3}&empresa={4}", 
                id, usuario, nombre, grupo, empresa));
        }
    }
}