using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal_Investigadores.clases;

namespace Portal_Investigadores
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        DBHelper DBHelper = new DBHelper();
        public DataTable tags { get; set; }

        public DataRow[] row { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            int idioma = int.Parse(Session["idioma"].ToString());
            cargarTags(idioma);
        }

        protected void cargarTags(int idioma)
        {
            //int idioma = int.Parse(Session["idioma"].ToString());
            this.tags = DBHelper.getTags(2, idioma);
        }
    }
}