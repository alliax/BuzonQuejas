using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal_Investigadores.clases;

namespace Portal_Investigadores
{
    public partial class RecuperarContrasena : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void submit(object sender, EventArgs e)
        {
            //toma los valores de los textbox
            string correo = email.Text.ToString();
            
            bool existeUsuario;
            //si están vacios muestra el warning
            if (correo == "")
            {
                waring.Visible = true;
                waring.Text = "El campo de Email debe contener información";
            }
            else
            {
                //checa validez de usuario y contraseña
                existeUsuario = DBHelper.verifyUserExist(correo);
                //si existe redirige a home page
                if (existeUsuario)
                {
                  
                  bool recuperar=  DBHelper.recuperarContrasena(correo);

                    if (recuperar == true)
                    {
                        //Response.Write("<script>alert('Tu nueva contraseña te llegará a tu correo electrónico');</script>");
                        //Response.Redirect("Login.aspx", true);

                        ScriptManager.RegisterStartupScript(this, this.GetType(),"alert", "alert('Tu nueva contraseña llegará a tu correo electrónico/A temporary password will be sent to your email');window.location ='Login.aspx';", true);
                    }
                    else {
                        Response.Write("<script>alert('Ocurrió un error al intentar recuperar la contraseña, por favor intenta nuevamente/An error occurred while changing the password, please try again');</script>");
                    }
                }
                //si no existe se queda en login y muestra el warining
                else
                {
                    waring.Visible = true;
                    waring.Text = "El correo es incorrecto";
                }

            }

        }
    }
}