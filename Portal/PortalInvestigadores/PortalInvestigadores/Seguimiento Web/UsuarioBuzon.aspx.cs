using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using Portal_Investigadores.clases;


namespace Portal_Investigadores
{
    public partial class CatalogoTipos : Page
    {
        DBHelper DBHelper = new DBHelper();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bindGridTipo();
            }
        }

        protected void agregarTipo(object sender, EventArgs e)
        {
            DataTable dttable = (DataTable)ViewState["datatable"];
            DataRow dr = null;
            if (txtTipo.Text != "" && txtDesc.Text != "")
            {
                dr = dttable.NewRow();
                dr["tipo"] = txtTipo.Text;
                dr["desc"] = txtDesc.Text;
                dttable.Rows.Add(dr);
                ViewState["datatable"] = dttable;
                tipoGV.DataSource = dttable;
                tipoGV.DataBind();
            }
        }

        private void bindGridTipo()
        {
            //se carga el catalogo al iniciar la vista
            DataTable dt = new DataTable();
            DataRow dr = dt.NewRow();
            dt.Columns.Add(new DataColumn("tipo", typeof(string)));
            dt.Columns.Add(new DataColumn("desc", typeof(string)));
            //dr["tipo"] = 1;
            //dr["desc"] = "Test";
            //dt.Rows.Add(dr);
            ViewState["datatable"] = dt;
            tipoGV.DataSource = dt;
            tipoGV.DataBind();
        }
    }
}