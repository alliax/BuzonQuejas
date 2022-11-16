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
    public partial class CatalogoResponsables : Page
    {
        DBHelper DBHelper = new DBHelper();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["user"] != null)
            {

                DataTable user = DBHelper.getUserInfoBuzon(Request.QueryString["user"]);

                if (user.Rows.Count > 0)
                {
                    Session["idUsuario"] = user.Rows[0][0].ToString();
                    Session["nomUsuario"] = user.Rows[0][1].ToString();
                    Session["tipoUsuario"] = user.Rows[0][2].ToString();
                    Session["username"] = Request.QueryString["user"];
                    Session["esInvestigador"] = "0";
                    Session["esDelegado"] = "0";
                    Session["esRevisor"] = "0";
                    Session["esEnterado"] = "0";

                    if (Request.QueryString["tipo"] != null)
                    {
                        // Master.menu.Visible = false;

                        //Master.menuLine.Visible = false;

                        //Session["tipoLectura"] = "1";

                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "hideMenu()", true);
                    }

                }
            }

            if (Session["username"] == null)
            {
                //Si no esta activa se redirecciona al Login
                Response.Redirect("Login");
            }

            BindGridResponsables(1,1);
        }

        public void BindGridResponsables(int idioma, int idUsuario)
        {
            DataTable responsables = DBHelper.loadResponsables(idUsuario);

            //numberAsignadas.InnerText = responsables.Rows.Count.ToString();
            //numberAsignadas2.InnerText = responsables.Rows.Count.ToString();

            if (responsables.Rows.Count > 0)
            {
                gvResponsables.DataSource = responsables;
                gvResponsables.DataBind();
                
            }
            else
            {
                gvResponsables.Visible = false;
                divResponsables.Visible = false;
            }
        }

        protected void gvResponsables_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            TableCell cell = e.Row.Cells[0];
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);


            e.Row.Cells[0].Visible = false;

            //gvEquipo.Columns[0].Visible = false;

            //TableCell cell2 = e.Row.Cells[6];

            //if (cell2.Text == "0")
            //{
            //    //e.Row.Font.Bold = true;
            //}

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }

        }
    }
}