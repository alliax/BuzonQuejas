using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal_Investigadores.clases;


namespace Portal_Investigadores
{
    public partial class CambiarContrasena : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submit(object sender, EventArgs e)
        {
            //toma los valores de los textbox
            string contrasenaAnt = contrasenaAnterior.Text.ToString();
            string nvaContrasena = nuevaContrasena.Text.ToString();
            string confNvaContrasenat = ConfContrasena.Text.ToString();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

            if (nvaContrasena.Length > 7
                      && (nvaContrasena.Contains('.') || nvaContrasena.Contains(',') || nvaContrasena.Contains('!') || nvaContrasena.Contains('@') 
                      || nvaContrasena.Contains('#') || nvaContrasena.Contains('?') || nvaContrasena.Contains('*') || nvaContrasena.Contains('%') 
                      || nvaContrasena.Contains('&') || nvaContrasena.Contains('/') || nvaContrasena.Contains('(') || nvaContrasena.Contains(')') 
                      || nvaContrasena.Contains('=') || nvaContrasena.Contains('$') || nvaContrasena.Contains('~') || nvaContrasena.Contains('^') 
                      || nvaContrasena.Contains('_') || nvaContrasena.Contains('-') || nvaContrasena.Contains('+') || nvaContrasena.Contains('`') 
                      || nvaContrasena.Contains('|') || nvaContrasena.Contains('{') || nvaContrasena.Contains('}') || nvaContrasena.Contains('[') 
                      || nvaContrasena.Contains(']') || nvaContrasena.Contains(':') || nvaContrasena.Contains(';') || nvaContrasena.Contains('<') 
                      || nvaContrasena.Contains('>'))
                      && nvaContrasena.Any(char.IsUpper)
                      && nvaContrasena.Any(char.IsLower)
                      && nvaContrasena.Any(char.IsDigit))
            {
                //si están vacios muestra el warning
                if (contrasenaAnt == "" || nvaContrasena == "" || confNvaContrasenat == "")
                {
                    waring.Visible = true;
                    waring.Text = "Debes llenar todos los campos/Please complete all fields";
                }
                else if (nvaContrasena != confNvaContrasenat)
                {
                    waring.Visible = true;
                    waring.Text = "La nueva contraseña debe coincidir/Passwords must match";
                }
                else if (nvaContrasena == contrasenaAnt)
                {
                    waring.Visible = true;
                    waring.Text = "La nueva contraseña debe ser diferente a la anterior/The new password must be different than the previous password.";
                }
                else
                {
                    string user = Session["username"].ToString();
                    int cambio = DBHelper.changePassword(user, contrasenaAnt, nvaContrasena);

                    if (cambio == 1)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Tu contraseña ha sido cambiada correctamente/You have successfully change your password');window.location ='SignOut.aspx';", true);
                    }
                    else if (cambio == 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('La contraseña anterior no es correcta/​Incorrect password');", true);
                    }
                    else
                    {
                        Response.Write("<script>alert('Ocurrió un error al intentar recuperar la contraseña, por favor intenta nuevamente/​An error occurred while changing the password, please try again.');</script>");
                    }
                }
            }
            else
            {
                waring.Visible = true;
                waring.Text = "La nueva contraseña debe ser de al menos 8 digitos, contener al menos un carácter especial, un número, una letra mayúscula y una minúscula/Your password must be at least 8 characters long and include the following character types: uppercase letter (A-Z), lowercase letter (a-z), decimal digit number (0-9), special characters (~!@#$%^&*_-+=`|(){}[]:;'<>,.?/)";
            }
        }

    }
}