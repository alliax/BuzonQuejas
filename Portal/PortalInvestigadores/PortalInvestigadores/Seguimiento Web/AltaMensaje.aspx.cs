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
using System.Web.Services.Description;

namespace Portal_Investigadores
{
    public partial class AltaMensaje : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();
        int idMensaje;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            error.Visible = false;
            string empresa = Session["empresa"].ToString();
            string grupo = Session["grupo"].ToString();
            int idBQ = int.Parse(Session["idBq"].ToString());
           
            if (Request.QueryString["idMensaje"] != null)
            {
                idMensaje = int.Parse(Request.QueryString["idMensaje"]);
            }

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
                cargarTipos(idBQ);
                cargarResponsablesArea(grupo);
                cargarResponsables();
                cargarPosiciones();
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
            DataTable areasAsig = DBHelper.getClasificacionesTareaByIdBQ(1);

            ddlArea.DataSource = areasAsig;
            ddlArea.DataTextField = areasAsig.Columns["Descripcion"].ToString();
            ddlArea.DataValueField = areasAsig.Columns["ClasificacionTarea"].ToString();
            ddlArea.DataBind();
        }
        protected void cargarTipos(int idBQ)
        {
            DataTable tipos = DBHelper.getTiposMensaje(idBQ);
            DataRow dr = tipos.NewRow();
            dr["Descripcion"] = "Selecciona un Valor";
            dr["IdTipo"] = "0";
            tipos.Rows.Add(dr);

            ddlTipo.DataSource = tipos;
            ddlTipo.DataTextField = tipos.Columns["Descripcion"].ToString();
            ddlTipo.DataValueField = tipos.Columns["IdTipo"].ToString();
            ddlTipo.DataBind();
            ddlTipo.SelectedValue = 0.ToString();
        }
        protected void cargarPosiciones()
        {
            DataTable posiciones = DBHelper.getTiposBuzon();
            DataRow dr = posiciones.NewRow();
            dr["Descripcion"] = "Escoge uno";
            dr["Tipo"] = "0";
            posiciones.Rows.Add(dr);

            ddlPosicion.DataSource = posiciones;
            ddlPosicion.DataTextField = posiciones.Columns["Descripcion"].ToString();
            ddlPosicion.DataValueField = posiciones.Columns["Tipo"].ToString();
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
            DataTable usuarios = DBHelper.getUsuariosResponsables();
            ddlResponsable.DataSource = usuarios;
            ddlResponsable.DataTextField = usuarios.Columns["Nombre"].ToString();
            ddlResponsable.DataValueField = usuarios.Columns["Usuario"].ToString();
            ddlResponsable.DataBind();
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
                    if (responsable["NombreRevisor"].ToString() != "")
                    {
                        txtRevisor.Text = responsable["NombreRevisor"].ToString();
                        revisorEmail.Text = responsable["CorreoRevisor"].ToString();
                        idRevisor.Text = responsable["idRevisor"].ToString();
                    }
                    else
                    {
                        idRevisor.Text = "0";
                        txtRevisor.Text = string.Empty;
                        revisorEmail.Text = string.Empty;
                    }
                }
            }            
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = 0;
            string usuario = Session["username"].ToString();
            string titulo = txtTitulo.Text;
            string nuevo = txtMensaje2.Text;
            string nombre = ""; string correo = ""; string apellidoP = ""; string apellidoM = "";string telefono = "";string tipo = "";
            string importancia = ddlImportancia.SelectedValue.ToString() == "0" ? "" : ddlImportancia.SelectedItem.ToString(); 
            string conducto = ddlConducto.SelectedValue.ToString() == "0" ? "" : ddlConducto.SelectedItem.ToString();
            string forma = ddlForma.Items.Count > 0 ? ddlForma.SelectedItem.ToString() : "";
            string clasificacion = ddlClasificacion.SelectedItem.ToString();
            string descripcion = txtDetalle.Text == "" ? "" : txtDetalle.Text;
            string usuarioResp = ddlResponsable.SelectedItem.ToString();
            string sitio = ddlSitio.SelectedValue.ToString() == "0" ? "" : ddlSitio.SelectedItem.ToString();
            int tema = int.Parse(ddlTema.SelectedValue);
            int subtema = ddlSubtema.SelectedValue.ToString() == "" ? 0 : int.Parse(ddlSubtema.SelectedValue);
            int idDep = ddlDepartamento.SelectedValue.ToString() == "" ? 0 : int.Parse(ddlDepartamento.SelectedValue);
            string areaAsig = ddlArea.SelectedValue.ToString();
            int idBQ = int.Parse(Session["idBq"].ToString());
            string mensaje = txtMensaje2.Text == null ? null : txtMensaje2.Text;
            string resumen = txtResumen.Text == null ? null : txtResumen.Text;
            int responsable = int.Parse(ddlResponsable2.SelectedValue);
            int revisor = idRevisor.Text == "" ? 0 : int.Parse(idRevisor.Text);
            bool revisorActivo = revisorInc.Checked;
            string enterad = enterados.Text == "" ? "" : enterados.Text;
            if (idMensaje > 0)
            {                
            }
            else
            {
                if (txtTitulo.Text != "" && txtMensaje2.Text != "")
                {
                    
                    if (chbkAnonimo.Checked == false)
                    {
                        nombre = txtNombre.Text;
                        correo = txtCorreo.Text;
                        apellidoP = txtPaterno.Text;
                        apellidoM = txtMaterno.Text;
                        telefono = txtTelefono.Text;
                        tipo = ddlTipo.SelectedValue.ToString();


                    }
                    id = DBHelper.guardarMensaje(idBQ, titulo, importancia, conducto, forma, clasificacion, descripcion
                        , nombre, apellidoP, apellidoM, telefono, correo, chbkAnonimo.Checked, usuarioResp, usuario, sitio
                        , tema, subtema, idDep, areaAsig, mensaje, resumen, tipo, responsable, revisor, revisorActivo, enterad);
                   // idNuevo.InnerText = id.ToString();
                    if (id == 0)
                    {
                        error.Visible = true;
                        msgError.InnerText = "Hubo un Error";
                    }
                    else
                    {
                        
                    }
                } 
                else
                {
                    error.Visible = true;
                    msgError.InnerText = "Necesitas llenar el campo Título y Nuevo: Visible para auditoría";
                }

            }
            
        }

        protected void chbkAnonimo_CheckedChanged(object sender, EventArgs e)
        {
            if (chbkAnonimo.Checked == true)
            {
                txtNombre.Text = string.Empty;
                txtNombre.Enabled = false;
                txtCorreo.Text = string.Empty;
                txtCorreo.Enabled = false;
                txtPaterno.Text = string.Empty;
                txtPaterno.Enabled = false;
                txtMaterno.Text = string.Empty;
                txtMaterno.Enabled = false;
                txtTelefono.Text = string.Empty;
                txtTelefono.Enabled = false;
                ddlTipo.Enabled = false;
            }
            else
            {
                txtNombre.Enabled = true;
                txtCorreo.Enabled = true;
                txtPaterno.Enabled = true; 
                txtMaterno.Enabled = true;
                txtTelefono.Enabled = true;
                ddlTipo.Enabled = true;
            }
        }
    }
}