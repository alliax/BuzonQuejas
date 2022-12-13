using Newtonsoft.Json;
using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Seguimiento_Web
{
    public partial class DashboardQuejas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login");
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_Etiquetas(int iId, int iIdioma)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dt= DBHelper.getBQEtiquetas(iId, iIdioma);
            string str = JsonConvert.SerializeObject(dt);
            return (str);

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_Rol_Usr(int iUsr)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dt = DBHelper.getUsrRol(iUsr);
            string str = JsonConvert.SerializeObject(dt);
            return (str);

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_Dashboard(string sOpt ,int iIdBQ)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dt = DBHelper.getDashboardBQ(sOpt,iIdBQ);
            string str = JsonConvert.SerializeObject(dt);
            return (str);

        }



    }
}