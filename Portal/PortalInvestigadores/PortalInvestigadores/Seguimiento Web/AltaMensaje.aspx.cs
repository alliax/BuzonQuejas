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
using Newtonsoft.Json;
using System.Web.Script.Services;
using System.Web.Services.Description;
using Microsoft.SqlServer.Server;
using System.Security.Policy;

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
            int estatus = 0;


            if (!Page.IsPostBack)
            {
                DataTable dtMsgInt = new DataTable();
                dtMsgInt.Columns.Add("Comentario");
                dtMsgInt.Columns.Add("Ip");
                Session["dtMsgInt"] = dtMsgInt;

                DataTable dtUsrInv = new DataTable();
                dtUsrInv.Columns.Add("Nombre");
                dtUsrInv.Columns.Add("Apellido");
                dtUsrInv.Columns.Add("Puesto");
                dtUsrInv.Columns.Add("Posicion");
                Session["dtUsrInv"] = dtUsrInv;
                cargarPosiciones();

                if (Request.QueryString["idMensaje"] != null)
                {
                    idMensaje = int.Parse(Request.QueryString["idMensaje"]);
                    DataTable mensaje = DBHelper.getMensaje(idMensaje);
                    ViewState["mensaje"] = mensaje;
                    DataRow row = mensaje.Rows[0];
                    string gpo = row["grupo"].ToString();                    
                    folio.InnerText = idMensaje.ToString();
                    estatus = int.Parse(row["estatus"].ToString());
                    estatusFolio.InnerText = estatus == 2 ? "Mensaje en Clasificacion": "Mensaje en Vobo Gerente";
                    btnAceptar.Visible = estatus == 3 ? true : false;
                    btnCancel.Visible = estatus == 3 ? true : false;
                    btnGuardar.Visible = estatus == 3 ? false : true;
                    btnEnviar.Visible = estatus == 3 ? false : true;
                    cargarInvolucrados(idMensaje);
                    cargarComentarios(idMensaje);
                    txtTitulo.Text = row["titulo"].ToString();
                    fechaRegistro.Text = row["fechaAlta"].ToString();
                    fechaClasificacion.Text = row["fechaClasificacion"].ToString();
                    ultimaActualizacion.Text = row["fechaActualizacion"].ToString();
                    cargarClasificacciones(row["clasificacion"].ToString());
                    cargarResponsables(row["usuario"].ToString());
                    cargarGrupos(row["grupo"].ToString());
                    cargarEmpresas(row["grupo"].ToString(), row["empresa"].ToString());
                    txtNombre.Text = row["nombre"].ToString();
                    txtCorreo.Text = row["correo"].ToString();
                    txtPaterno.Text = row["apellidoPaterno"].ToString();
                    txtMaterno.Text = row["apellidoMaterno"].ToString();
                    txtTelefono.Text = row["telefono"].ToString();
                    chbkAnonimo.Checked = row["anonimo"].ToString() == "" ? false:  bool.Parse(row["anonimo"].ToString());
                    cargarTipos(1, int.Parse(row["tipo"].ToString()));
                    cargarSitios(row["grupo"].ToString(), row["empresa"].ToString(), row["sitio"].ToString());
                    cargarDepartamentos(row["grupo"].ToString(), int.Parse(row["idDepartamento"].ToString())); ;
                    cargarImportancias(1, row["importancia"].ToString());
                    cargarConducto(1, row["conducto"].ToString());
                    cargarTemas(1, int.Parse(row["area"].ToString()));
                    cargarAreaAsig(row["areaAsignada"].ToString());
                    cargarResponsablesArea(gpo, row["responsable"].ToString());
                    txtEmail.Text = row["revisor"].ToString();
                    enterados.Text = row["enterados"].ToString();
                    revisorInc.Checked = bool.Parse(row["revisorActivo"].ToString());
                    txtMensaje2.Text = row["mensaje"].ToString();
                    txtDetalle.Text = row["descripcion"].ToString();
                    txtResumen.Text = row["resumen"].ToString();
                    bindGridAsociadas();
                    cargarSubtemas(int.Parse(row["idBQ"].ToString()), int.Parse(row["area"].ToString()), int.Parse(row["tema"].ToString()));
                    cargarFormas(int.Parse(row["idBQ"].ToString()), 
                        getIdConducto(int.Parse(row["idBQ"].ToString()),row["conducto"].ToString()), row["forma"].ToString());
                    //asignarInfoRes(gpo, int.Parse(row["responsable"].ToString()));
                }
                else
                {
                    estatusFolio.InnerText = "Mensaje Nuevo";                    

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
                    
                }

            }

        }

        protected void cargarClasificacciones(string selectedValue = "")
        {
            DataTable clasificaciones = DBHelper.getClasificacionesByFKIdBQ(1);           

            ddlClasificacion.DataSource = clasificaciones;
            ddlClasificacion.DataTextField = clasificaciones.Columns["clasificacion"].ToString();
            ddlClasificacion.DataValueField = clasificaciones.Columns["id"].ToString();
            ddlClasificacion.DataBind();

            if (selectedValue != "")
            {
                foreach (DataRow clasificacion in clasificaciones.Rows)
                {
                    if (selectedValue == clasificacion["clasificacion"].ToString())
                    {
                        ddlClasificacion.SelectedValue = clasificacion["id"].ToString();
                    }
                }
            }

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
        protected void cargarSitios(string grupo, string empresa, string selectedValue = "")
        {
            DataTable sitios = DBHelper.getSitios(grupo, empresa);

            DataRow dr = sitios.NewRow();
            string sIdioma = Session["idioma"].ToString();
            if (sIdioma == "2")
            {
                dr["Sitio"] = "0";
                dr["Descripcion"] = "Select Site";
            }
            else
            {
                dr["Sitio"] = "0";
                dr["Descripcion"] = "Selecciona un Sitio";
            }
            sitios.Rows.Add(dr);

            ddlSitio.DataSource = sitios;
            ddlSitio.DataTextField = sitios.Columns["Descripcion"].ToString();
            ddlSitio.DataValueField = sitios.Columns["Sitio"].ToString();
            ddlSitio.DataBind();

            if (selectedValue != "")
            {
                foreach (DataRow sitio in sitios.Rows)
                {
                    if (selectedValue == sitio["Descripcion"].ToString())
                    {
                        ddlSitio.SelectedValue = sitio["Sitio"].ToString();
                    }
                }
            } else
            {
                ddlSitio.SelectedValue = 0.ToString();
            }

            
        }
        protected void cargarDepartamentos(string grupo, int selectedValue = 0)
        {
            DataTable departamentos = DBHelper.getDepartamentos(grupo);

            DataRow dr = departamentos.NewRow();
            string sIdioma = Session["idioma"].ToString();
            if (sIdioma == "2")
            {
                dr["Departamento"] = "0";
                dr["Descripcion"] = "Select Departament";

            }
            else
            {
                dr["Departamento"] = "0";
                dr["Descripcion"] = "Selecciona un Departamento";
            }
            departamentos.Rows.Add(dr);

            ddlDepartamento.DataSource = departamentos;
            ddlDepartamento.DataTextField = departamentos.Columns["Descripcion"].ToString();
            ddlDepartamento.DataValueField = departamentos.Columns["Departamento"].ToString();
            ddlDepartamento.DataBind();
            if (selectedValue != 0)
            {
                foreach (DataRow departamento in departamentos.Rows)
                {
                    if (selectedValue == int.Parse(departamento["Departamento"].ToString()))
                    {
                        ddlDepartamento.SelectedValue = departamento["Departamento"].ToString();
                    }
                }
            } else
            {
                ddlDepartamento.SelectedValue = 0.ToString();
            }
            
        }

        protected void cargarImportancias(int idBQ, string selectedValue = "")
        {
            DataTable importancias = DBHelper.getImportanciasByFKIdBQ(idBQ);
            DataRow dr = importancias.NewRow();
            string sIdioma = Session["idioma"].ToString();

            if (sIdioma == "2")
            {
                dr["importancia"] = "Select Importance";
                dr["idImportancia"] = "0";
            }
            else
            {
                dr["importancia"] = "Selecciona una Importancia";
                dr["idImportancia"] = "0";
            }

            importancias.Rows.Add(dr);

            ddlImportancia.DataSource = importancias;
            ddlImportancia.DataTextField = importancias.Columns["importancia"].ToString();
            ddlImportancia.DataValueField = importancias.Columns["idImportancia"].ToString();
            ddlImportancia.DataBind();
            if (selectedValue != "")
            {
                foreach (DataRow importancia in importancias.Rows)
                {
                    if (selectedValue == importancia["importancia"].ToString())
                    {
                        ddlImportancia.SelectedValue = importancia["idImportancia"].ToString();
                    }
                }
            } else
            {
                ddlImportancia.SelectedValue = 0.ToString();
            }
            
        }
        protected void cargarConducto(int idBQ, string selectedValue = "")
        {
            DataTable conductos = DBHelper.getConductoByFKIdBq(idBQ);
            DataRow dr = conductos.NewRow();

            string sIdioma = Session["idioma"].ToString();
            if (sIdioma == "2")
            {
                dr["id"] = "0";
                dr["conducto"] = "Select Conduit";

            }
            else
            {
                dr["conducto"] = "Selecciona un Conducto";
                dr["id"] = "0";
            }
            conductos.Rows.Add(dr);

            ddlConducto.DataSource = conductos;
            ddlConducto.DataTextField = conductos.Columns["conducto"].ToString();
            ddlConducto.DataValueField = conductos.Columns["id"].ToString();
            ddlConducto.DataBind();
            if (selectedValue != "")
            {
                foreach (DataRow conducto in conductos.Rows)
                {
                    if (selectedValue == conducto["conducto"].ToString())
                    {
                        ddlConducto.SelectedValue = conducto["id"].ToString();
                    }
                }
            } else
            {
                ddlConducto.SelectedValue = 0.ToString();
            }
            
            
        }
        protected int getIdConducto(int idBQ, string con)
        {
            int id = 0;
            DataTable conductos = DBHelper.getConductoByFKIdBq(idBQ);
            foreach (DataRow conducto in conductos.Rows)
            {
                if (con == conducto["conducto"].ToString())
                {
                    id = int.Parse(conducto["id"].ToString());
                }
            }
            return id;
        }
        protected void cargarFormas(int idBQ, int idConducto, string selectedValue = "")
        {
            DataTable formas = DBHelper.getFormasByFKIdBq(idBQ, idConducto);
            ddlForma.DataSource = formas;
            ddlForma.DataTextField = formas.Columns["forma"].ToString();
            ddlForma.DataValueField = formas.Columns["id"].ToString();
            ddlForma.DataBind();
            if (selectedValue != "")
            {
                foreach (DataRow forma in formas.Rows)
                {
                    if (selectedValue == forma["forma"].ToString())
                    {
                        ddlForma.SelectedValue = forma["id"].ToString();
                    }
                }
            }
        }
        protected void cargarTemas(int idBQ, int selectedValue = 0)
        {
            DataTable temas = DBHelper.getTemasByIdBQ(idBQ);
            ddlTema.DataSource = temas;
            ddlTema.DataTextField = temas.Columns["Descripcion"].ToString();
            ddlTema.DataValueField = temas.Columns["IdTema"].ToString();
            ddlTema.DataBind();
            if (selectedValue != 0)
            {
                foreach (DataRow tema in temas.Rows)
                {
                    if (selectedValue == int.Parse(tema["IdTema"].ToString()))
                    {
                        ddlTema.SelectedValue = tema["IdTema"].ToString();
                    }
                }
            }
        }
        protected void cargarSubtemas(int idBQ, int idTema, int selectedValue = 0)
        {
            DataTable subtemas = DBHelper.getSubtemaByIdBQ(idBQ, idTema);
            ddlSubtema.DataSource = subtemas;
            ddlSubtema.DataTextField = subtemas.Columns["Descripcion"].ToString();
            ddlSubtema.DataValueField = subtemas.Columns["IdSubtema"].ToString();
            ddlSubtema.DataBind();
            if (selectedValue != 0)
            {
                foreach (DataRow subtema in subtemas.Rows)
                {
                    if (selectedValue == int.Parse(subtema["IdSubtema"].ToString()))
                    {
                        ddlSubtema.SelectedValue = subtema["IdSubtema"].ToString();
                    }
                }
            }
            
        }
        protected void cargarAreaAsig(string selectedValue = "")
        {
            DataTable areasAsig = DBHelper.getClasificacionesTareaByIdBQ(1);

            ddlArea.DataSource = areasAsig;
            ddlArea.DataTextField = areasAsig.Columns["Descripcion"].ToString();
            ddlArea.DataValueField = areasAsig.Columns["ClasificacionTarea"].ToString();
            ddlArea.DataBind();
            if (selectedValue != "")
            {
                foreach (DataRow area in areasAsig.Rows)
                {
                    if (selectedValue == area["ClasificacionTarea"].ToString())
                    {
                        ddlArea.SelectedValue = area["ClasificacionTarea"].ToString();
                    }
                }
            }
        }
        protected void cargarTipos(int idBQ, int selectedValue = 0)
        {
            DataTable tipos = DBHelper.getTiposMensaje(idBQ);
            DataRow dr = tipos.NewRow();

            string sIdioma = Session["idioma"].ToString();
            if (sIdioma == "2")
            {
                dr["Descripcion"] = "Select Value";
                dr["IdTipo"] = "0";                

            }
            else
            {
                dr["Descripcion"] = "Selecciona un Valor";
                dr["IdTipo"] = "0";
                
            }
            tipos.Rows.Add(dr);
            ddlTipo.DataSource = tipos;
            ddlTipo.DataTextField = tipos.Columns["Descripcion"].ToString();
            ddlTipo.DataValueField = tipos.Columns["IdTipo"].ToString();
            ddlTipo.DataBind();
            
            if (selectedValue != 0)
            {
                foreach (DataRow tipo in tipos.Rows)
                {
                    if (selectedValue == int.Parse(tipo["IdTipo"].ToString()))
                    {
                        ddlTipo.SelectedValue = tipo["IdTipo"].ToString();
                    }
                }
            }
            else
            {
                ddlTipo.SelectedValue = 0.ToString();
            }
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
        protected void cargarResponsablesArea(string grupo, string selectedValue = "")
        {
            DataTable responsables = DBHelper.getResponsablesMensaje(grupo);
            ViewState["responsables"] = responsables;

            DataTable respo = new DataTable();
            respo.Columns.Add("Nombre");
            respo.Columns.Add("Id");
            DataRow dr = respo.NewRow();
            dr["Nombre"] = "Ericka Sifuentes";
            dr["Id"] = "474";
            respo.Rows.Add(dr);
            ddlResponsable2.DataSource = respo;
            ddlResponsable2.DataTextField = respo.Columns["Nombre"].ToString();
            ddlResponsable2.DataValueField = respo.Columns["Id"].ToString();
            ddlResponsable2.DataBind();


            //ddlResponsable2.DataSource = responsables;
            //ddlResponsable2.DataTextField = responsables.Columns["Nombre"].ToString();
            //ddlResponsable2.DataValueField = responsables.Columns["Id"].ToString();
            //ddlResponsable2.DataBind();

            if (selectedValue != "")
            {
                foreach (DataRow responsable  in respo.Rows)
                {
                    if (selectedValue == responsable["Id"].ToString())
                    {
                        ddlResponsable2.SelectedValue = responsable["Id"].ToString();
                    }
                }
            }
        }

        protected void cargarResponsables(string userName = "")
        {
            DataTable usuarios = DBHelper.getUsuariosResponsables();
            
            DataTable users = new DataTable();
            users.Columns.Add("Nombre");
            users.Columns.Add("Usuario");
            DataRow dr = users.NewRow();
            dr["Nombre"] = "Eduardo Nino";
            dr["Usuario"] = "eduardo.nino@alliax.com";
            users.Rows.Add(dr);
            ddlResponsable.DataSource = users;
            ddlResponsable.DataTextField = users.Columns["Nombre"].ToString();
            ddlResponsable.DataValueField = users.Columns["Usuario"].ToString();
            ddlResponsable.DataBind();

            //ddlResponsable.DataSource = usuarios;
            //ddlResponsable.DataTextField = usuarios.Columns["Nombre"].ToString();
            //ddlResponsable.DataValueField = usuarios.Columns["Usuario"].ToString();
            //ddlResponsable.DataBind();
            
            if (userName != "")
            {
                foreach (DataRow usuario in users.Rows)
                {
                    if (userName == usuario["Nombre"].ToString())
                    {
                        ddlResponsable.SelectedValue = usuario["Usuario"].ToString();
                    }
                }
            }
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
        protected void asignarInfoRes(string grupo, int idResponsable)
        {
            DataTable responsables = DBHelper.getResponsablesMensaje(grupo);
            foreach (DataRow responsable in responsables.Rows)
            {
                if (idResponsable == int.Parse(responsable["Id"].ToString()))
                {
                    txtEmail.Text = responsable["CorreoResponsable"].ToString();
                    if (responsable["NombreRevisor"].ToString() != "")
                    {
                        txtRevisor.Text = responsable["NombreRevisor"].ToString();
                        revisorEmail.Text = responsable["CorreoRevisor"].ToString();
                        idRevisor.Text = responsable["idRevisor"].ToString();
                    }
                }

            }
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
        protected void addMensajesInt(object sender, EventArgs e)
        {
            if (Request.QueryString["idMensaje"] != null)
            {
                int idM = int.Parse(Request.QueryString["idMensaje"].ToString());
                if (txtMsg.Text != "")
                {

                    string hostName = Dns.GetHostName();
                    string myIP = Dns.GetHostEntry(hostName).AddressList[0].ToString();

                    DataTable dtMsgInt = (DataTable)Session["dtMsgInt"];
                    DataRow msgRow = dtMsgInt.NewRow();
                    msgRow["Comentario"] = txtMsg.Text;
                    msgRow["IP"] = myIP;
                    dtMsgInt.Rows.Add(msgRow);


                    foreach (DataRow row in dtMsgInt.Rows)
                    {
                        //1 Mensaje
                        
                        int iIdBQ = Convert.ToInt32(Session["idBq"].ToString());
                        string sUsr = Session["nomUsuario"].ToString();
                        string sOutput = DBHelper.postMensajesInt("NEW", iIdBQ, idM, sUsr, row["Comentario"].ToString(), row["IP"].ToString());
                    }

                    gvCom.DataSource = dtMsgInt;
                    gvCom.DataBind();
                }
            }

            

        }
        protected void cargarComentarios(int idMensaje)
        {
            DataTable comentarios = DBHelper.getMensajesInt(idMensaje);
            gvCom.DataSource = comentarios;
            gvCom.DataBind();
        }

        protected void cargarInvolucrados(int idMensaje)
        {
            DataTable involucrados = DBHelper.getInvolucrados(idMensaje);
            gvInv.DataSource = involucrados;
            gvInv.DataBind();
        }
        protected void addInvolucrados(object sender, EventArgs e)
        {
            if (Request.QueryString["idMensaje"] != null)
            {
                int idM = int.Parse(Request.QueryString["idMensaje"].ToString());
                DataTable dtUsrInv = (DataTable)Session["dtUsrInv"];
                DataRow msgRow = dtUsrInv.NewRow();
                msgRow["Nombre"] = invNombre.Text;
                msgRow["Apellido"] = invApellido.Text;
                msgRow["Puesto"] = invPuesto.Text;
                msgRow["Posicion"] = ddlPosicion.SelectedValue;
                dtUsrInv.Rows.Add(msgRow);


                foreach (DataRow row in dtUsrInv.Rows)
                {
                    //1 Mensaje

                    string sUsr = Session["idUsuario"].ToString();
                    string sOutput = DBHelper.postInvolucrados("NEW", 0, idM, row["Nombre"].ToString(), row["Apellido"].ToString(), row["Puesto"].ToString(), row["Posicion"].ToString(), sUsr);

                }

                gvInv.DataSource = dtUsrInv;
                gvInv.DataBind();
                cargarInvolucrados(idMensaje);

            }


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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int idM = Request.QueryString["idMensaje"] != null ? int.Parse(Request.QueryString["idMensaje"]) : 0;
            int id;
            string output = "";
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
            string user = Session["nomUsuario"].ToString();
            string hostName = Dns.GetHostName();
            string myIP = Dns.GetHostEntry(hostName).AddressList[0].ToString();
            int idAsociada = asociadosDDL.Items.Count > 0 ? int.Parse(asociadosDDL.SelectedValue) : 0;
            if (idM > 0)
            {
                output = DBHelper.updateMensaje(idM, idAsociada, idBQ, titulo, importancia, conducto, forma, clasificacion, descripcion
                        , nombre, apellidoP, apellidoM, telefono, correo, chbkAnonimo.Checked, usuarioResp, usuario, sitio
                        , tema, subtema, idDep, areaAsig, mensaje, resumen, tipo, responsable, revisor, revisorActivo, enterad);
                if (output != "OK")
                {
                    error.Visible = true;
                    msgError.InnerText = "Hubo un Error";
                }
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
                        folio.InnerText = id.ToString();
                        DBHelper.savecomentariosIniciales(id, user, myIP);

                        Response.Redirect(string.Format("~/AltaMensaje.aspx?idMensaje={0}",
                            id));

                    }
                } 
                else
                {
                    error.Visible = true;
                    msgError.InnerText = "Necesitas llenar el campo Título y Nuevo: Visible para auditoría";
                }

            }
            
        }
        protected void bindGridAsociadas()
        {
            DataTable asociadas = DBHelper.getQuejasAsociadasMensaje("Proveedora de Alimentos de Cancún (PACSA)", 1 );
            ViewState["asociadas"] = asociadas;
            asociadasGV.DataSource = asociadas;
            asociadasGV.DataBind();
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

        protected void asociadasGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void asociadasGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            //asociadosDDL
            int value = Convert.ToInt32(asociadasGV.SelectedRow.Cells[1].Text.ToString());
            string texto = asociadasGV.SelectedRow.Cells[1].Text + " - " + asociadasGV.SelectedRow.Cells[2].Text;
            DataTable asociadas = new DataTable();
            asociadas.Columns.Add("Value");
            asociadas.Columns.Add("Text");
            DataRow dr = asociadas.NewRow();
            dr["Text"] = texto;
            dr["Value"] = value;
            asociadas.Rows.Add(dr);
            ViewState["aso"] = asociadas;
            asociadosDDL.DataSource = asociadas;
            asociadosDDL.DataTextField = asociadas.Columns["Text"].ToString();
            asociadosDDL.DataValueField = asociadas.Columns["Value"].ToString();
            asociadosDDL.DataBind();

        }

        protected void desasociar_Click(object sender, EventArgs e)
        {
            DataTable asociadas = (DataTable)ViewState["aso"];
            DataRow dr = asociadas.NewRow();
            dr["Text"] = "Escoge uno";
            dr["Value"] = "0";
            asociadas.Rows[0].Delete();
            asociadas.Rows.Add(dr);
            asociadosDDL.DataSource = asociadas;
            asociadosDDL.DataTextField = asociadas.Columns["Text"].ToString();
            asociadosDDL.DataValueField = asociadas.Columns["Value"].ToString();
            asociadosDDL.DataBind();
            

        }
        protected bool formValid()
        {


            
            if (txtTitulo.Text != "" && ddlSitio.SelectedValue.ToString() != "0"
                && int.Parse(ddlDepartamento.SelectedValue) != 0 && int.Parse(ddlImportancia.SelectedValue) != 0
                && int.Parse(ddlConducto.SelectedValue) != 0 && ddlForma.Items.Count > 0 && txtMensaje2.Text != ""
                && txtDetalle.Text != "" && txtResumen.Text != "" && ddlSubtema.Items.Count > 0) 
            {
                if (chbkAnonimo.Checked == false)
                {
                    if (txtNombre.Text != "" && txtCorreo.Text != "" && txtPaterno.Text != "" && txtMaterno.Text != ""
                       && txtTelefono.Text != "" && int.Parse(ddlTipo.SelectedValue) != 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            string output = "";
            string output2 = "";
            int idM = int.Parse(Request.QueryString["idMensaje"]);

            string usuario = Session["username"].ToString();            
            string titulo = txtTitulo.Text;
            string nuevo = txtMensaje2.Text;
            string nombre = ""; string correo = ""; string apellidoP = ""; string apellidoM = ""; string telefono = ""; string tipo = "0";
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
            string user = Session["nomUsuario"].ToString();
            string hostName = Dns.GetHostName();
            string myIP = Dns.GetHostEntry(hostName).AddressList[0].ToString();
            int idAsociada = asociadosDDL.Items.Count > 0 ? int.Parse(asociadosDDL.SelectedValue) : 0;



            if (formValid() && idM > 0)
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
                output = DBHelper.updateMensaje(idM, idAsociada, idBQ, titulo, importancia, conducto, forma, clasificacion, descripcion
                        , nombre, apellidoP, apellidoM, telefono, correo, chbkAnonimo.Checked, usuarioResp, usuario, sitio
                        , tema, subtema, idDep, areaAsig, mensaje, resumen, tipo, responsable, revisor, revisorActivo, enterad);


                if (output == "OK")
                {
                    output2 = DBHelper.enviarVoboMensaje(idM, user, myIP);
                    if (output2 == "OK")
                    {
                        Response.Redirect("Dashboard");
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard");
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            string output = "";
            int idM = Request.QueryString["idMensaje"] != null ? int.Parse(Request.QueryString["idMensaje"]) : 0;
            string user = Session["nomUsuario"].ToString();
            string hostName = Dns.GetHostName();
            string myIP = Dns.GetHostEntry(hostName).AddressList[0].ToString();

            output = DBHelper.aceptarVoboMensaje(idM, user, myIP);
            if ( output == "OK")
            {
                Response.Redirect("Dashboard");
            } else
            {
                error.Visible = true;
                msgError.InnerText = "Hubo un Error";
            }
        }
    }
}