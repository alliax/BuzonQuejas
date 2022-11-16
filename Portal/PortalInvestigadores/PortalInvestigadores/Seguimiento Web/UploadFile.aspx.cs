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
    public partial class UploadFile : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Request.QueryString["den"] != null && Request.QueryString["tipo"] !=null && Request.QueryString["id"] != null)
            //{
            //    int denuncia = int.Parse(Request.QueryString["id"]);
            //    int tipo = int.Parse(Request.QueryString["id"]);
            //    int id = int.Parse(Request.QueryString["id"]);

            //    txtidDenuncia.Value = denuncia.ToString();
            //    txtTipo.Value = tipo.ToString();
            //    txtId.Value = id.ToString();

            //}

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