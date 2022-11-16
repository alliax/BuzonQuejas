using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.Services;
using Portal_Investigadores.clases;

namespace Portal_Investigadores
{
    public partial class BuscadorDenuncias : System.Web.UI.Page
    {
        DBHelper DBHelper = new DBHelper();

        public DataTable tags { get; set; }

        public DataRow[] row { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null)
            {
                //Si no esta activa se redirecciona al Login
                Response.Redirect("Login");
            }

            // En caso de que este activa continua y se toma el Id del Usuario
            int idUsuario = int.Parse(Session["idUsuario"].ToString());

            int idioma = int.Parse(Session["idioma"].ToString());

            cargarTags(idioma);
            BindGridDenuncias(idioma, idUsuario);

        }

        protected void cargarTags(int idioma)
        {
            //int idioma = int.Parse(Session["idioma"].ToString());
            this.tags = DBHelper.getTags(4, idioma);
        }

        public void BindGridDenuncias(int idioma, int idUsuario)
        {
            DataTable cerradas = DBHelper.loadAllDenuncias(idioma, idUsuario);

            if (cerradas.Rows.Count > 0)
            {
                gvDenuncias.DataSource = cerradas;
                gvDenuncias.DataBind();

                row = tags.Select("id = '107'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[0].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '108'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[1].Text = row[0][1].ToString();
                }

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                row = tags.Select("id = '109'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[2].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '110'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[3].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '111'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[4].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '112'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[5].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '113'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[6].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '114'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[7].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '115'");
                if (row.Length > 0)
                {
                    gvDenuncias.HeaderRow.Cells[8].Text = row[0][1].ToString();
                }

                //if (row.Length > 0)
                //{
                //    gvCerradas.HeaderRow.Cells[5].Text = "nuevo";
                //}

                //row = tags.Select("id = '12'");
                //if (row.Length > 0)
                //{
                //    gvCerradas.HeaderRow.Cells[6].Text = row[0][1].ToString();
                //}
            }
            else
            {
                gvDenuncias.Visible = false;
                gvDenuncias.Visible = false;
            }

        }

        protected void gvDenuncias_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            TableCell cell = e.Row.Cells[0];
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
            //row = tags.Select("id = '12'");

            //((HyperLinkField)((DataControlFieldCell)e.Row.Cells[6]).ContainingField).Text = row[0][1].ToString();

        }

    }
}