using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal_Investigadores.clases;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Web.UI.HtmlControls;

namespace Portal_Investigadores
{
    public partial class Login : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            user.Attributes["placeholder"] = "Correo electrónico/Email";
            pass.Attributes["placeholder"] = "Contraseña/Password";
            waring.Visible = false;
        }

        protected void submit(object sender, EventArgs e)
        {
            //toma los valores de los textbox
            string usuario = user.Text.ToString();
            string password = pass.Text.ToString();
            int existeUsuario;
            //si están vacios muestra el warning
            if (usuario == "" || password == "")
            {
                waring.Visible = true;
                waring.Text = "Los campos usuario y password deben contener información/Username and password must be filled out.";
            }
            else
            {
                string ip = txtIp.Value;

                //checa validez de usuario y contraseña
                existeUsuario = DBHelper.verifyUser(usuario, password, ip);
                //si existe redirige a home page
                if (existeUsuario == 1)
                {
                    Session["username"] = usuario;
                    DataTable user = DBHelper.getUserInfo(usuario);

                    if (user.Rows[0][7].ToString() == "1")
                    {
                        Response.Redirect("CambiarContrasena.aspx", true);
                    }
                    else
                    {

                        //Session["nomUsuario"] = DBHelper.getUserName(usuario);
                        Session["idUsuario"] = user.Rows[0][0].ToString();
                        Session["nomUsuario"] = user.Rows[0][1].ToString();
                        Session["tipoUsuario"] = user.Rows[0][2].ToString();
                        Session["esInvestigador"] = user.Rows[0][3].ToString();
                        Session["esDelegado"] = user.Rows[0][4].ToString();
                        Session["esRevisor"] = user.Rows[0][5].ToString();
                        Session["esEnterado"] = user.Rows[0][6].ToString();
                        Session["adminDen"] = user.Rows[0][8].ToString();
                        //int perfil = DBHelper.getPerfil(usuario);
                        //Session["rol"] = perfil.ToString();
                        Session["idioma"] = ddlIdioma.SelectedValue;
                        Session["empresa"] = "CANCUN";
                        Session["grupo"] = "SIGMA";
                        Session["idBQ"] = "1";

                        Response.Redirect("Dashboard.aspx", true);
                    }
                }
                //si no existe se queda en login y muestra el warining
                else if (existeUsuario == 2) {
                    waring.Visible = true;
                    waring.Text = "Usuario bloqueado por intentos fallidos, envianos un correo a seguimientobuzon@alfa.com.mx para activar tu usuario/Account blocked, please contact seguimientobuzon@alfa.com.mx for further instructions";
                }
                else
                {
                    waring.Visible = true;
                    waring.Text = "Usuario y/o password incorrectos/Wrong username and/or password. Please try again";
                }
            }
        }
    }
}