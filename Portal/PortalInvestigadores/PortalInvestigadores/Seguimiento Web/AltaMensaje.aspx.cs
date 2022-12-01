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
using System.Text.RegularExpressions;
using System.Runtime.InteropServices;

namespace Portal_Investigadores
{
    public partial class AltaMensaje : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();


        protected void Page_Load(object sender, EventArgs e)
        {
            fechaRegistro.Text = DateTime.Now.ToString("yyyy-MM-dd");
            string empresa = Session["empresa"].ToString();
            string grupo = Session["grupo"].ToString();
            int idBQ = int.Parse(Session["idBq"].ToString());
            fechaClasificacion.Text = DateTime.Now.ToString("yyyy-MM-dd hh:mm tt");
            if (!Page.IsPostBack)
            {
                cargarClasificacciones();
                cargarGrupos(grupo);
                cargarEmpresas(grupo, empresa);
                cargarSitios(grupo, empresa);
                cargarDepartamentos(grupo);
                cargarImportancias(idBQ); cargarConducto(idBQ);
                cargarTemas(idBQ);
                cargarAreaAsig();
                cargarTipos();
                cargarResponsablesArea(grupo);
            }

        }

        protected void cargarClasificacciones()
        {
            DataTable clasificaciones = DBHelper.getClasificacionesByFKIdBQ(1);           

            ddlClasificacion.DataSource = clasificaciones;
            ddlClasificacion.DataTextField = clasificaciones.Columns["clasificacion"].ToString();
            ddlClasificacion.DataValueField = clasificaciones.Columns["id"].ToString();
            ddlClasificacion.DataBind();            

        }
        protected void cargarGrupos (string grupo)
        {
            DataTable grupos = DBHelper.getGrupos();            

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
        protected void cargarEmpresas(string grupo, string empresa)
        {
            DataTable empresas = DBHelper.getEmpresas(grupo);

            ddlEmpresa.DataSource = empresas;
            ddlEmpresa.DataTextField = empresas.Columns["Descripcion"].ToString();
            ddlEmpresa.DataValueField = empresas.Columns["Empresa"].ToString();
            ddlEmpresa.DataBind();            
            ddlEmpresa.SelectedValue = empresa;
            
        }
        protected void cargarSitios(string grupo, string empresa)
        {
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
        protected void cargarDepartamentos(string grupo)
        {
            DataTable departamentos = DBHelper.getDepartamentos(grupo);

            DataRow dr = departamentos.NewRow();
            dr["Departamento"] = "0";
            dr["Descripcion"] = "Selecciona un Departamento";
            departamentos.Rows.Add(dr);

            ddlDepartamento.DataSource = departamentos;
            ddlDepartamento.DataTextField = departamentos.Columns["Descripcion"].ToString();
            ddlDepartamento.DataValueField = departamentos.Columns["Departamento"].ToString();
            ddlDepartamento.DataBind();
            ddlDepartamento.SelectedValue = 0.ToString();
        }

        protected void cargarImportancias(int idBQ)
        {
            DataTable importancias = DBHelper.getImportanciasByFKIdBQ(idBQ);
            DataRow dr = importancias.NewRow();
            dr["importancia"] = "Selecciona una Importancia";
            dr["idImportancia"] = "0";
            importancias.Rows.Add(dr);

            ddlImportancia.DataSource = importancias;
            ddlImportancia.DataTextField = importancias.Columns["importancia"].ToString();
            ddlImportancia.DataValueField = importancias.Columns["idImportancia"].ToString();
            ddlImportancia.DataBind();
            ddlImportancia.SelectedValue = 0.ToString();
        }
        protected void cargarConducto(int idBQ)
        {
            DataTable conductos = DBHelper.getConductoByFKIdBq(idBQ);
            DataRow dr = conductos.NewRow();
            dr["conducto"] = "Selecciona un Conducto";
            dr["id"] = "0";
            conductos.Rows.Add(dr);

            ddlConducto.DataSource = conductos;
            ddlConducto.DataTextField = conductos.Columns["conducto"].ToString();
            ddlConducto.DataValueField = conductos.Columns["id"].ToString();
            ddlConducto.DataBind();
            ddlConducto.SelectedValue = 0.ToString();
        }
        protected void cargarFormas(int idBQ, int idConducto)
        {
            DataTable formas = DBHelper.getFormasByFKIdBq(idBQ, idConducto);
            ddlForma.DataSource = formas;
            ddlForma.DataTextField = formas.Columns["forma"].ToString();
            ddlForma.DataValueField = formas.Columns["id"].ToString();
            ddlForma.DataBind();
        }
        protected void cargarTemas(int idBQ)
        {
            DataTable temas = DBHelper.getTemasByIdBQ(idBQ);
            ddlTema.DataSource = temas;
            ddlTema.DataTextField = temas.Columns["Descripcion"].ToString();
            ddlTema.DataValueField = temas.Columns["IdTema"].ToString();
            ddlTema.DataBind();
        }
        protected void cargarSubtemas(int idBQ, int idTema)
        {
            DataTable subtemas = DBHelper.getSubtemaByIdBQ(idBQ, idTema);
            ddlSubtema.DataSource = subtemas;
            ddlSubtema.DataTextField = subtemas.Columns["Descripcion"].ToString();
            ddlSubtema.DataValueField = subtemas.Columns["IdSubtema"].ToString(); ;
            ddlSubtema.DataBind();
        }
        protected void cargarAreaAsig()
        {
            DataTable areasAsig = DBHelper.getAreasAdmDen("");

            ddlArea.DataSource = areasAsig;
            ddlArea.DataTextField = areasAsig.Columns["Descripcion"].ToString();
            ddlArea.DataValueField = areasAsig.Columns["ClasificacionT"].ToString();
            ddlArea.DataBind();
        }
        protected void cargarTipos()
        {
            DataTable tipos = DBHelper.getTiposBuzon();
            DataRow dr = tipos.NewRow();
            dr["Descripcion"] = "Selecciona un Valor";
            dr["Tipo"] = "0";
            tipos.Rows.Add(dr);

            ddlPosicion.DataSource = tipos;
            ddlPosicion.DataTextField = tipos.Columns["Descripcion"].ToString();
            ddlPosicion.DataValueField = tipos.Columns["Tipo"].ToString();
            ddlPosicion.DataBind();
            ddlPosicion.SelectedValue = 0.ToString();
        }
        protected void cargarResponsablesArea(string grupo)
        {
            DataTable responsables = DBHelper.getResponsablesMensaje(grupo);
            ViewState["responsables"] = responsables;
            ddlResponsable2.DataSource = responsables;
            ddlResponsable2.DataTextField = responsables.Columns["Nombre"].ToString();
            ddlResponsable2.DataValueField = responsables.Columns["Id"].ToString();
            ddlResponsable2.DataBind();
        }

        protected void cargarResponsables()
        {
            DBHelper DBHelper = new DBHelper();
        }

        protected void btnAddInv_Click(object sender, EventArgs e)
        {
           
        }

        protected void ddlConducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idBQ = int.Parse(Session["idBq"].ToString());          
            cargarFormas(idBQ, int.Parse(ddlConducto.SelectedValue.ToString()));
        }

        protected void ddlTema_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idBQ = int.Parse(Session["idBq"].ToString());
            cargarSubtemas(idBQ, int.Parse(ddlTema.SelectedValue.ToString()));
        }

        protected void gvResponsables_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void ddlResponsable2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable responsables = (DataTable)ViewState["responsables"];
            foreach (DataRow responsable in responsables.Rows)
            {
                if (responsable["Id"].ToString() == ddlResponsable2.SelectedValue)
                {
                    txtEmail.Text = responsable["CorreoResponsable"].ToString();
                    enterados.Text = responsable["EnteradosEmails"].ToString();
                }
            }            
        }
    }
}