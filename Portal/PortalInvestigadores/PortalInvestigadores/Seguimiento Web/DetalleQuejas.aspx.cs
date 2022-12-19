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

        [WebMethod]
        public static string SaveEntrevistadoBQ(int idQueja, int idEntrevistado, string nombre, string puesto, string entrevistador, int usuarioAlta)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.saveEntrevistadoBQ(idQueja, idEntrevistado, nombre, puesto, entrevistador, usuarioAlta);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }
        [WebMethod]
        public static string CargarEntrevistadosBQ(string idQueja)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable entrevistados = DBHelper.getEntrevistadosBQ(Int64.Parse(idQueja));

            DataSet ds = new DataSet();
            ds.Tables.Add(entrevistados);

            Dictionary<string, object> dict = new Dictionary<string, object>();
            foreach (DataTable dt in ds.Tables)
            {
                object[] arr = new object[dt.Rows.Count + 1];

                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    arr[i] = dt.Rows[i].ItemArray;
                }

                dict.Add(dt.TableName, arr);
            }

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(dict);

        }
        [WebMethod]
        public static string DeleteEntrevistadoBQ(int idEntrevistado, int usuarioBaja)
        {
            DBHelper DBHelper = new DBHelper();

            string resp = DBHelper.deleteEntrevistadoBQ(idEntrevistado, usuarioBaja);

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(resp);

        }

    }
}