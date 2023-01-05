using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Seguimiento_Web
{
    public partial class DocumentosAntecedentes : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
           

        }

        [WebMethod]
        public static string SaveArchivo(int tipo, int id, string nombreOriginal, string nombre, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveArchivo(tipo, id, nombreOriginal, "uploads/" +nombre, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
    }
}