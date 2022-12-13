using Newtonsoft.Json;
using Portal_Investigadores.clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Seguimiento_Web
{
    public partial class DetalleMensaje : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        public DataTable tags { get; set; }

        public DataRow[] row { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            cargarTags(1);

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string BQ_DetalleMensaje(int iIdQueja)
        {
            DBHelper DBHelper = new DBHelper();
            DataTable dt = DBHelper.getDetalleMensaje(iIdQueja);
            string str = JsonConvert.SerializeObject(dt);
            return (str);

        }
        protected void cargarTags(int idioma)
        {
            //int idioma = int.Parse(Session["idioma"].ToString());
            this.tags = DBHelper.getTags(3, idioma);

            JavaScriptSerializer oSerializer = new JavaScriptSerializer();

            var Result = (from c in tags.AsEnumerable()
                          select new
                          {
                              id = c.Field<int>("id"),
                              tag = c.Field<string>("tag")
                          }).ToList();
            tagsJS.Value = oSerializer.Serialize(Result);
        }

    }
}