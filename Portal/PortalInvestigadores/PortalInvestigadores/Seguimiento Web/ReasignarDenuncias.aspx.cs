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


namespace Portal_Investigadores
{
    public partial class ReasignarDenuncias : Page
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


            //BindGridResponsables(1,1);
            if (!Page.IsPostBack)
            {
                cargaDropDownGrupo1();
                cargaDropDownGrupo2();
                cargaDropDownResponsables("", "", "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
                cargaDropDownResponsablesReasignar("", "", "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));

                //btnReasignar.Attributes.Add("disabled", "disabled"); //or try .Add("disabled","true");
                //btnReasignar.Enabled = false;

            }
            else {
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Las denuncias se reasignaron correctamente.');", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "crearTabla()", true);
            }

            if (gvDenuncias.Rows.Count > 0)
            {
                //Adds THEAD and TBODY Section.
                gvDenuncias.HeaderRow.TableSection = TableRowSection.TableHeader;

                //Adds TH element in Header Row.  
                gvDenuncias.UseAccessibleHeader = true;

            }
        }

        public void BindGridResponsables(int idioma, int idUsuario)
        {
            //DataTable responsables = DBHelper.loadResponsables(idUsuario);

            ////numberAsignadas.InnerText = responsables.Rows.Count.ToString();
            ////numberAsignadas2.InnerText = responsables.Rows.Count.ToString();

            //if (responsables.Rows.Count > 0)
            //{
            //    //gvResponsables.DataSource = responsables;
            //    //gvResponsables.DataBind();
                
            //}
            //else
            //{
            //    //gvResponsables.Visible = false;
            //    //divResponsables.Visible = false;
            //}
        }

        protected void gvResponsables_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            TableCell cell = e.Row.Cells[0];
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);


            e.Row.Cells[0].Visible = false;

            //gvEquipo.Columns[0].Visible = false;

            //TableCell cell2 = e.Row.Cells[6];

            //if (cell2.Text == "0")
            //{
            //    //e.Row.Font.Bold = true;
            //}

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }

        }

        //public void cargaDropDownGrupo()
        //{

        //    DBHelper DBHelper = new DBHelper();
        //    DataTable grupos = DBHelper.getGrupos();

        //    DataRow dr = grupos.NewRow();
        //    dr["Grupo"] = "0";
        //    dr["Descripcion"] = "Selecciona un Grupo";
        //    grupos.Rows.Add(dr);

        //    grupoDDL.DataSource = grupos;
        //    grupoDDL.DataTextField = grupos.Columns["Descripcion"].ToString();
        //    grupoDDL.DataValueField = grupos.Columns["Grupo"].ToString();
        //    grupoDDL.DataBind();

        //    grupoDDL.SelectedValue = 0.ToString();

        //}

        public void cargaDropDownGrupo1()
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

            ddlGrupo.SelectedValue = 0.ToString();

        }

        public void cargaDropDownGrupo2()
        {

            DBHelper DBHelper = new DBHelper();
            DataTable grupos = DBHelper.getGrupos();

            DataRow dr = grupos.NewRow();
            dr["Grupo"] = "0";
            dr["Descripcion"] = "Selecciona un Grupo";
            grupos.Rows.Add(dr);

            ddlGrupo2.DataSource = grupos;
            ddlGrupo2.DataTextField = grupos.Columns["Descripcion"].ToString();
            ddlGrupo2.DataValueField = grupos.Columns["Grupo"].ToString();
            ddlGrupo2.DataBind();

            ddlGrupo2.SelectedValue = 0.ToString();

        }

        public void cargaDropDownEmpresa(string grupo)
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

            ddlEmpresa.SelectedValue = 0.ToString();
        }

        public void cargaDropDownEmpresaReasignar(string grupo)
        {

            DBHelper DBHelper = new DBHelper();
            DataTable empresas = DBHelper.getEmpresas(grupo);

            DataRow dr = empresas.NewRow();
            dr["Empresa"] = "0";
            dr["Descripcion"] = "Selecciona una Empresa";
            empresas.Rows.Add(dr);

            ddlEmpresa2.DataSource = empresas;
            ddlEmpresa2.DataTextField = empresas.Columns["Descripcion"].ToString();
            ddlEmpresa2.DataValueField = empresas.Columns["Empresa"].ToString();
            ddlEmpresa2.DataBind();

            ddlEmpresa2.SelectedValue = 0.ToString();
        }

        public void cargaDropDownSitio(string grupo, string empresa)
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

            ddlSitio.SelectedValue = 0.ToString();
        }

        public void cargaDropDownSitioReasignar(string grupo, string empresa)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable sitios = DBHelper.getSitios(grupo, empresa);

            DataRow dr = sitios.NewRow();
            dr["Sitio"] = "0";
            dr["Descripcion"] = "Selecciona un Sitio";
            sitios.Rows.Add(dr);

            ddlSitio2.DataSource = sitios;
            ddlSitio2.DataTextField = sitios.Columns["Descripcion"].ToString();
            ddlSitio2.DataValueField = sitios.Columns["Sitio"].ToString();
            ddlSitio2.DataBind();

            ddlSitio2.SelectedValue = 0.ToString();
        }

        public void cargaDropDownResponsables(string grupo, string empresa, string sitio, int tipo)
        {
            DataTable dt = DBHelper.getResponsable(grupo,empresa,sitio, tipo);

            DataRow dr = dt.NewRow();
            dr["idUsuario"] = 0;
            dr["nombre"] = " Selecciona un Responsable";
            dt.Rows.Add(dr);

            ddlResponsable.DataTextField = dt.Columns["nombre"].ToString();
            ddlResponsable.DataValueField = dt.Columns["idUsuario"].ToString();
            ddlResponsable.DataSource = dt.DefaultView;      //assigning datasource to the dropdownlist
            ddlResponsable.DataBind();  //binding dropdownlist
            ddlResponsable.SelectedValue = 0.ToString();
        }

        public void cargaDropDownResponsablesReasignar(string grupo, string empresa, string sitio, int tipo)
        {
            DataTable dt = DBHelper.getResponsable(grupo, empresa, sitio, tipo);

            DataRow dr = dt.NewRow();
            dr["idUsuario"] = 0;
            dr["nombre"] = " Selecciona un Responsable";
            dt.Rows.Add(dr);

            ddlResponsable2.DataTextField = dt.Columns["nombre"].ToString();
            ddlResponsable2.DataValueField = dt.Columns["idUsuario"].ToString();
            ddlResponsable2.DataSource = dt.DefaultView;      //assigning datasource to the dropdownlist
            ddlResponsable2.DataBind();  //binding dropdownlist
            ddlResponsable2.SelectedValue = 0.ToString();
        }

        protected void grupoDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            string grupo = ddlGrupo.SelectedValue.ToString();

            cargaDropDownEmpresa(grupo);
            ddlGrupo2.SelectedValue = grupo;
            cargaDropDownEmpresaReasignar(grupo);
            cargaDropDownResponsables(grupo, "", "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
            cargaDropDownResponsablesReasignar(grupo, "", "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
        }

        protected void empresaDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //riesgo = int.Parse(grupoDDL.SelectedValue.ToString());

            string grupo = ddlGrupo.SelectedValue.ToString();
            string empresa = ddlEmpresa.SelectedValue.ToString();

            ddlEmpresa2.SelectedValue = empresa;

            cargaDropDownSitio(grupo, empresa);
            cargaDropDownSitioReasignar(grupo, empresa);
            cargaDropDownResponsables(grupo, empresa, "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
            cargaDropDownResponsablesReasignar(grupo, empresa,"", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
        }

        protected void sitioDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //riesgo = int.Parse(grupoDDL.SelectedValue.ToString());

            string grupo = ddlGrupo.SelectedValue.ToString();
            string empresa = ddlEmpresa.SelectedValue.ToString();
            string sitio = ddlSitio.SelectedValue.ToString();
            int tipoAsignacion = int.Parse(ddlTipoAsignacion.SelectedValue.ToString());

            ddlSitio2.SelectedValue = sitio;
            cargaDropDownResponsables(grupo, empresa, sitio, tipoAsignacion);
            cargaDropDownResponsablesReasignar(grupo, empresa, sitio, tipoAsignacion);
        }

        //protected void responsableDDL_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    //riesgo = int.Parse(grupoDDL.SelectedValue.ToString());

        //    int responsable = int.Parse(responsableDDL.SelectedValue.ToString());

        //    BindGrid(responsable);

        //    //cargaDropDownDirectoresGrupoNivel(director);
        //    //cargaDropDownDirectores(division);
        //}

        //protected void responsableReaDDL_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    //riesgo = int.Parse(grupoDDL.SelectedValue.ToString());

        //    int director = int.Parse(responsableDDL.SelectedValue.ToString());

        //    //BindGrid(director);

        //    //cargaDropDownDirectoresGrupoNivel(director);
        //    //cargaDropDownDirectores(division);
        //}

        protected void cbRea_CheckChanged(object sender, EventArgs e)
        {
            string idDenunciasAReasignar = "";

            foreach (GridViewRow row in gvDenuncias.Rows)
            {
                CheckBox cb = (CheckBox)row.FindControl("cbDen");

                if ((cb.Checked) && (cb != null))
                {
                    idDenunciasAReasignar = idDenunciasAReasignar + row.Cells[0].Text.ToString() + ", ";
                }
            }

            //if (ddlResponsable2.SelectedValue != "0" && idDenunciasAReasignar != "")
            //{
            //    btnReasignar.Attributes.Remove("disabled");
            //    btnReasignar.Enabled = true;
            //}
            //else
            //{
            //    btnReasignar.Attributes.Add("disabled", "disabled"); //or try .Add("disabled","true");
            //    btnReasignar.Enabled = false;
            //}
        }

        public void reasingar_denuncias(object sender, EventArgs e)
        {
            int responsableOriginal = int.Parse(ddlResponsable.SelectedValue);
            int responsableAReasignar = int.Parse(ddlResponsable2.SelectedValue);
            string idDenunciasAReasignar = "";

            foreach (GridViewRow row in gvDenuncias.Rows)
            {
                CheckBox cb = (CheckBox)row.FindControl("cbDen");

                if ((cb.Checked) && (cb != null))
                {
                    idDenunciasAReasignar = idDenunciasAReasignar + row.Cells[0].Text.ToString() + ", ";
                }
            }

            if (responsableOriginal == responsableAReasignar)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('El responsable a reasignar debe ser diferente al responsable original.');", true);
            }
            else
            {

                if (responsableOriginal != 0 && responsableAReasignar != 0 && idDenunciasAReasignar != "")
                {
                    int resp = DBHelper.reasignarDenuncias(responsableOriginal, responsableAReasignar, idDenunciasAReasignar);

                    if (resp == 1)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Las denuncias se reasignaron correctamente.');", true);
                        ddlResponsable2.SelectedValue = 0.ToString();

                        BindGrid(responsableOriginal, 1);
                        //btnReasignar.Attributes.Add("disabled", "disabled"); //or try .Add("disabled","true");
                        //btnReasignar.Enabled = false;

                        //idPlanAccion = "";
                        idDenunciasAReasignar = "";
                        txtidDenuncia.Text = "";
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Ocurrió un error al tratar de reasignar las denuncias, por favor intenta nuevamente.');", true);
                        ddlResponsable2.SelectedValue = 0.ToString();

                        BindGrid(responsableOriginal, 1);
                        //btnReasignar.Attributes.Add("disabled", "disabled"); //or try .Add("disabled","true");
                        //btnReasignar.Enabled = false;

                        //idPlanAccion = "";
                        idDenunciasAReasignar = "";
                        txtidDenuncia.Text = "";
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Faltan datos para poder reasignar denuncias.');", true);

                }
            }
        }

        public void cancelar(object sender, EventArgs e)
        {
            Response.Redirect("CatalogoResponsables.aspx", true);

        }

        protected void gvPlanAccion_PageIndexChanging(Object sender, GridViewPageEventArgs e)
        {
            //gvPlanAccion.PageIndex = e.NewPageIndex;
            //BindGrid(int.Parse(responsableDDL.SelectedValue));
        }

        public void BindGrid(int id, int tipo)
        {
            //DataTable planAccion = DBHelper.loadPlanAccionDirector(idDirector);
            ////gvPlanAccion.DataSource = planAccion;
            ////gvPlanAccion.DataBind();
            DataTable denuncias;

            if (tipo == 1) {
                int tipoAsignacion = int.Parse(ddlTipoAsignacion.SelectedValue.ToString());
                denuncias = DBHelper.getDenuncias(id, tipoAsignacion);
            }
            else {
                denuncias = DBHelper.getDenunciasPorId(id);
            }
                       
            if (denuncias.Rows.Count > 0)
            {
                divDenuncias.Visible = true;
                gvDenuncias.Visible = true;
                //gvDenuncias.HeaderRow.TableSection = TableRowSection.TableHeader;
                gvDenuncias.DataSource = denuncias;
                gvDenuncias.DataBind();

                if (gvDenuncias.Rows.Count > 0)
                {
                    //Adds THEAD and TBODY Section.
                    gvDenuncias.HeaderRow.TableSection = TableRowSection.TableHeader;

                    //Adds TH element in Header Row.  
                    gvDenuncias.UseAccessibleHeader = true;

                }

                if (tipo == 2) {

                    //ddlGrupo.SelectedValue = denuncias.Rows[0][2].ToString().Trim();
                    //ddlEmpresa.SelectedValue = denuncias.Rows[0][3].ToString().Trim();
                    //ddlSitio.SelectedValue = denuncias.Rows[0][4].ToString().Trim();
                    ddlResponsable.SelectedValue = denuncias.Rows[0][5].ToString().Trim();
                }
            }
            else
            {
                divDenuncias.Visible = true;
                gvDenuncias.Visible = true;
                gvDenuncias.DataSource = denuncias;
                gvDenuncias.DataBind();
            }

        }

      

        protected void gvDenuncias_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            //TableCell cell = e.Row.Cells[0];
            //e.Row.Cells.RemoveAt(0);
            //e.Row.Cells.Add(cell);


            //e.Row.Cells[0].Visible = false;

            //gvEquipo.Columns[0].Visible = false;

            //TableCell cell2 = e.Row.Cells[6];

            //if (cell2.Text == "0")
            //{
            //    //e.Row.Font.Bold = true;
            //}

            //if (e.Row.RowType == DataControlRowType.Header)
            //{
            //    e.Row.TableSection = TableRowSection.TableHeader;
            //}

        }

        public void buscarPorResponsable_OnClick(object sender, EventArgs e)
        {
            //riesgo = int.Parse(grupoDDL.SelectedValue.ToString());

            int director = int.Parse(ddlResponsable.SelectedValue.ToString());
            BindGrid(director,1);

            //cargaDropDownDirectoresGrupoNivel(director);
            //cargaDropDownDirectores(division);
        }

        public void buscarPorDenuncia_OnClick(object sender, EventArgs e)
        {
            //riesgo = int.Parse(grupoDDL.SelectedValue.ToString());
            int number;

            if (int.TryParse(txtidDenuncia.Text, out number)) {
                int denuncia = int.Parse(txtidDenuncia.Text);
                BindGrid(denuncia, 2);
            }


            //cargaDropDownDirectoresGrupoNivel(director);
            //cargaDropDownDirectores(division);
        }

        //[WebMethod]
        //public static string CargarResponsables(string resp)
        //{
        //    DBHelper DBHelper = new DBHelper();
        //    DataTable responsables = DBHelper.getResponsableAuto(resp);

        //    //DataRow dr = responsables.NewRow();
        //    //dr["Departamento"] = "0";
        //    //dr["Descripcion"] = "Selecciona un Departamento";
        //    //responsables.Rows.Add(dr);

        //    DataSet ds = new DataSet();
        //    ds.Tables.Add(responsables);

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

        //[WebMethod]
        //public static List<Responsables> CargarResponsables(string resp)
        //{
        //    DBHelper DBHelper = new DBHelper();
        //    DataTable responsables = DBHelper.getResponsableAuto(resp);

        //    //DataRow dr = responsables.NewRow();
        //    //dr["Departamento"] = "0";
        //    //dr["Descripcion"] = "Selecciona un Departamento";
        //    //responsables.Rows.Add(dr);

        //    //DataSet ds = new DataSet();
        //    //ds.Tables.Add(responsables);

        //    //List<Responsables> respList = new List<Responsables>();
        //    //for (int i = 0; i < responsables.Rows.Count; i++)
        //    //{
        //    //    Responsables responsableNew = new Responsables();
        //    //    responsableNew.idusuario = Convert.ToInt32(responsables.Rows[i]["idusuario"]);
        //    //    responsableNew.nombre = responsables.Rows[i]["Nombre"].ToString();
        //    //    respList.Add(responsableNew);
        //    //}

        //    //return respList;

        //}

        [WebMethod]
        public static string CargarEmpresas(string grupo)
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
        public static string CargarSitios(string grupo, string empresa)
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
        public static string CargarResponsables(string grupo, string empresa, string sitio, int tipo)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable responsables = DBHelper.getResponsable(grupo, empresa, sitio, tipo);

            DataRow dr = responsables.NewRow();
            dr["idUsuario"] = "0";
            dr["nombre"] = "Selecciona un Responsable";
            responsables.Rows.Add(dr);

            DataSet ds = new DataSet();
            ds.Tables.Add(responsables);

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

        protected void ddlGrupo2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string grupo = ddlGrupo2.SelectedValue.ToString();

            cargaDropDownEmpresaReasignar(grupo);
            cargaDropDownEmpresaReasignar(grupo);
            cargaDropDownResponsablesReasignar(grupo, "", "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
        }

        protected void ddlEmpresa2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string grupo = ddlGrupo2.SelectedValue.ToString();
            string empresa = ddlEmpresa2.SelectedValue.ToString();
            cargaDropDownSitioReasignar(grupo, empresa);
            cargaDropDownResponsablesReasignar(grupo, empresa, "", int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
        }

        protected void ddlSitio2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string grupo = ddlGrupo2.SelectedValue.ToString();
            string empresa = ddlEmpresa2.SelectedValue.ToString();
            string sitio = ddlSitio2.SelectedValue.ToString();
            cargaDropDownResponsablesReasignar(grupo, empresa, sitio, int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
        }

        protected void gvDenuncias_DataBound(object sender, EventArgs e)
        {
            //gvDenuncias.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void gvDenuncias_PreRender(object sender, EventArgs e)
        {
            if (gvDenuncias.Rows.Count > 0)
            {
                //Adds THEAD and TBODY Section.
                gvDenuncias.HeaderRow.TableSection = TableRowSection.TableHeader;

                //Adds TH element in Header Row.  
                gvDenuncias.UseAccessibleHeader = true;

            }
        }

        protected void ddlTipoAsignacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            string grupo = ddlGrupo.SelectedValue.ToString();
            string empresa = ddlEmpresa.SelectedValue.ToString();
            string sitio = ddlSitio.SelectedValue.ToString();

            cargaDropDownResponsables(grupo == "0" ? "":grupo, empresa =="0" ? "":empresa, sitio == "0" ? "":sitio, int.Parse(ddlTipoAsignacion.SelectedValue.ToString()));
        }
    }
}