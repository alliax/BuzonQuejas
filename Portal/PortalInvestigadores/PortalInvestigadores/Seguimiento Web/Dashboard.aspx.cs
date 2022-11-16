using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal_Investigadores.clases;


namespace Portal_Investigadores
{
    public partial class Dashboard : System.Web.UI.Page
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

            if (!Page.IsPostBack)
            {
                //modalDetail.Visible = false;

                //ClientScript.RegisterStartupScript(GetType(), "Show", "<script>$('#myModal').modal('hide');</script>");
                //modalDetail.Visible = false;
                //closeModal.Focus();

                //MethodInfo clickMethodInfo = typeof(Button).GetMethod("OnClick", BindingFlags.NonPublic | BindingFlags.Instance);

                //clickMethodInfo.Invoke(closeModal, new object[] { EventArgs.Empty });
            }

            // En caso de que este activa continua y se toma el Id del Usuario
            int idUsuario = int.Parse(Session["idUsuario"].ToString());

            int idioma = int.Parse(Session["idioma"].ToString());

            cargarTags(idioma);
            BindGridEquipo(idioma, idUsuario);
            BindGridAsignadas(idioma, idUsuario);
            BindGridDelegadas(idioma, idUsuario);
            BindGridPendVoBo(idioma, idUsuario);
            BindGridRevAuditoria(idioma, idUsuario);

        }

        protected void cargarTags(int idioma)
        {
            //int idioma = int.Parse(Session["idioma"].ToString());
            this.tags = DBHelper.getTags(1, idioma); 
        }

        #region Carga de Grids
        public void BindGridEquipo(int idioma, int idUsuario)
        {
            DataTable equipo = DBHelper.loadEquipo(idioma, idUsuario);

            numberEquipo.InnerText = equipo.Rows.Count.ToString();

            if (equipo.Rows.Count > 0)
            {
                gvEquipo.DataSource = equipo;
                gvEquipo.DataBind();

                //int idioma = int.Parse(Session["idioma"].ToString());
                //tags = DBHelper.getTags(1, idioma);

                row = tags.Select("id = '6'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[0].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '7'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[1].Text = row[0][1].ToString();
                }

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvPendAceptar.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                row = tags.Select("id = '9'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[2].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '10'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[3].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '11'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[4].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '15'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[5].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '12'");
                if (row.Length > 0)
                {
                    gvEquipo.HeaderRow.Cells[6].Text = row[0][1].ToString();
                }
            }
            else
            {
                gvEquipo.Visible = false;
                divEquipo.Visible = false;
            }

        }

        public void BindGridAsignadas(int idioma, int idUsuario)
        {
            DataTable asginadas = DBHelper.loadAsignadas(idioma, idUsuario);

            numberAsignadas.InnerText = asginadas.Rows.Count.ToString();
            numberAsignadas2.InnerText = asginadas.Rows.Count.ToString();

            if (asginadas.Rows.Count > 0)
            {

                gvAsignadas.DataSource = asginadas;
                gvAsignadas.DataBind();

                row = tags.Select("id = '6'");
                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[0].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '7'");
                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[1].Text = row[0][1].ToString();
                }

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvAsignadas.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                row = tags.Select("id = '9'");
                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[2].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '10'");
                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[3].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '11'");
                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[4].Text = row[0][1].ToString();
                }

                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[5].Text = "nuevo";
                }

                row = tags.Select("id = '12'");
                if (row.Length > 0)
                {
                    gvAsignadas.HeaderRow.Cells[6].Text = row[0][1].ToString();
                }
            }
            else
            {
                gvAsignadas.Visible = false;
                divAsignadas.Visible = false;
            }
        }

        public void BindGridDelegadas(int idioma, int idUsuario)
        {
            DataTable delegadas = DBHelper.loadDelegadas(idioma, idUsuario);

            numberDelegadas.InnerText = delegadas.Rows.Count.ToString();
            numberDelegadas2.InnerText = delegadas.Rows.Count.ToString();

            if (delegadas.Rows.Count > 0)
            {
                gvDelegadas.DataSource = delegadas;
                gvDelegadas.DataBind();

                //int idioma = int.Parse(Session["idioma"].ToString());
                //tags = DBHelper.getTags(1, idioma);

                row = tags.Select("id = '6'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[0].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '7'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[1].Text = row[0][1].ToString();
                }

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvDelegadas.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                row = tags.Select("id = '9'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[2].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '10'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[3].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '11'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[4].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '13'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[5].Text = row[0][1].ToString();
                }

                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[6].Text = "nuevo";
                }

                row = tags.Select("id = '12'");
                if (row.Length > 0)
                {
                    gvDelegadas.HeaderRow.Cells[7].Text = row[0][1].ToString();
                }
            }
            else
            {
                gvDelegadas.Visible = false;
                divDelegadas.Visible = false;
            }

        }

        public void BindGridPendVoBo(int idioma, int idUsuario)
        {
            DataTable pendVoBo = DBHelper.loadPendVoBo(idioma, idUsuario);

            numberPendVoBo.InnerText = pendVoBo.Rows.Count.ToString();
            numberPendVoBo2.InnerText = pendVoBo.Rows.Count.ToString();

            if (pendVoBo.Rows.Count > 0)
            {
                gvPendVoBo.DataSource = pendVoBo;
                gvPendVoBo.DataBind();

                //int idioma = int.Parse(Session["idioma"].ToString());
                //tags = DBHelper.getTags(1, idioma);

                row = tags.Select("id = '6'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[0].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '7'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[1].Text = row[0][1].ToString();
                }

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvPendVoBo.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                row = tags.Select("id = '9'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[2].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '10'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[3].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '11'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[4].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '14'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[5].Text = row[0][1].ToString();
                }

                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[6].Text = "nuevo";
                }

                row = tags.Select("id = '12'");
                if (row.Length > 0)
                {
                    gvPendVoBo.HeaderRow.Cells[7].Text = row[0][1].ToString();
                }
            } else
            {
                gvPendVoBo.Visible = false;
                divPendVoBo.Visible = false;
            }
        }

        public void BindGridRevAuditoria(int idioma, int idUsuario)
        {
            DataTable revAuditoria = DBHelper.loadRevAuditoria(idioma, idUsuario);

            numberRevAuditoria.InnerText = revAuditoria.Rows.Count.ToString();
            numberRevAuditoria2.InnerText = revAuditoria.Rows.Count.ToString();

            if (revAuditoria.Rows.Count > 0)
            {
                gvRevAuditoria.DataSource = revAuditoria;
                gvRevAuditoria.DataBind();

                //int idioma = int.Parse(Session["idioma"].ToString());
                //tags = DBHelper.getTags(1, idioma);

                row = tags.Select("id = '6'");
                if (row.Length > 0)
                {
                    gvRevAuditoria.HeaderRow.Cells[0].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '7'");
                if (row.Length > 0)
                {
                    gvRevAuditoria.HeaderRow.Cells[1].Text = row[0][1].ToString();
                }

                //row = tags.Select("id = '8'");
                //if (row.Length > 0)
                //{
                //    gvRevAuditoria.HeaderRow.Cells[2].Text = row[0][1].ToString();
                //}

                row = tags.Select("id = '9'");
                if (row.Length > 0)
                {
                    gvRevAuditoria.HeaderRow.Cells[2].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '10'");
                if (row.Length > 0)
                {
                    gvRevAuditoria.HeaderRow.Cells[3].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '11'");
                if (row.Length > 0)
                {
                    gvRevAuditoria.HeaderRow.Cells[4].Text = row[0][1].ToString();
                }

                row = tags.Select("id = '12'");
                if (row.Length > 0)
                {
                    gvRevAuditoria.HeaderRow.Cells[5].Text = row[0][1].ToString();
                }

            }
            else
            {
                gvRevAuditoria.Visible = false;
                divRevAuditoria.Visible = false;
            }
        }

        #endregion

        protected void gvEquipo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            TableCell cell = e.Row.Cells[0];
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);

            //gvEquipo.Columns[0].Visible = false;

            TableCell cell2 = e.Row.Cells[6];

            if (cell2.Text == "0")
            {
                //e.Row.Font.Bold = true;
            }

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }

            row = tags.Select("id = '12'");
            ((HyperLinkField)((DataControlFieldCell)e.Row.Cells[7]).ContainingField).Text = row[0][1].ToString();

        }

        protected void gvAsignadas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            TableCell cell = e.Row.Cells[0];
            TableCell cellEsconder = e.Row.Cells[6];
            e.Row.Cells[6].Visible = false;
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);

            //TableCell cell2 = e.Row.Cells[0];

            if (cellEsconder.Text == "1") {
                //cell2.Font.Bold = true;
                e.Row.Font.Bold = true;
            }

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
            row = tags.Select("id = '12'");

            ((HyperLinkField)((DataControlFieldCell)e.Row.Cells[6]).ContainingField).Text = row[0][1].ToString();
              
        }

        protected void gvPendAceptar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            TableCell cell = e.Row.Cells[0];
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);
        }

        protected void gvDelegadas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //TableCell cell = e.Row.Cells[0];
            //e.Row.Cells.RemoveAt(0);
            //e.Row.Cells.Add(cell);

            //if (e.Row.RowType == DataControlRowType.Header)
            //{
            //    e.Row.TableSection = TableRowSection.TableHeader;
            //}

            TableCell cell = e.Row.Cells[0];
            TableCell cellEsconder = e.Row.Cells[7];
            e.Row.Cells[7].Visible = false;
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);

            //TableCell cell2 = e.Row.Cells[0];

            if (cellEsconder.Text == "1")
            {
                //cell2.Font.Bold = true;
                e.Row.Font.Bold = true;
            }

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }

            row = tags.Select("id = '12'");
            ((HyperLinkField)((DataControlFieldCell)e.Row.Cells[7]).ContainingField).Text = row[0][1].ToString();
        }

        protected void gvPendVoBo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //TableCell cell = e.Row.Cells[0];
            //e.Row.Cells.RemoveAt(0);
            //e.Row.Cells.Add(cell);

            //if (e.Row.RowType == DataControlRowType.Header)
            //{
            //    e.Row.TableSection = TableRowSection.TableHeader;
            //}

            TableCell cell = e.Row.Cells[0];
            TableCell cellEsconder = e.Row.Cells[7];
            e.Row.Cells[7].Visible = false;
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);

            //TableCell cell2 = e.Row.Cells[0];

            if (cellEsconder.Text == "1")
            {
                //cell2.Font.Bold = true;
                e.Row.Font.Bold = true;
            }

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }

            row = tags.Select("id = '12'");
            ((HyperLinkField)((DataControlFieldCell)e.Row.Cells[7]).ContainingField).Text = row[0][1].ToString();
        }

        protected void gvRevAuditoria_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            TableCell cell = e.Row.Cells[0];
            e.Row.Cells.RemoveAt(0);
            e.Row.Cells.Add(cell);

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }

            row = tags.Select("id = '12'");

            ((HyperLinkField)((DataControlFieldCell)e.Row.Cells[5]).ContainingField).Text = row[0][1].ToString();
        }

        //protected void Display(object sender, EventArgs e)
        //{
        //    int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
        //    GridViewRow row = gvPendAceptar.Rows[rowIndex];

        //    Int64 idDenuncia = Int64.Parse(row.Cells[0].Text.ToString());

        //    DataTable infoDenuncia = DBHelper.getInfoDenuncia(idDenuncia);

        //     int den = int.Parse(infoDenuncia.Rows[0][0].ToString());

        //    txtFolio.Text = infoDenuncia.Rows[0][0].ToString();
        //    txtGrupo.Text = infoDenuncia.Rows[0][1].ToString();
        //    txtEmpresa.Text = infoDenuncia.Rows[0][2].ToString();
        //    txtSitio.Text = infoDenuncia.Rows[0][3].ToString();
        //    txtDepartamento.Text = infoDenuncia.Rows[0][4].ToString();
        //    txtTema.Text = infoDenuncia.Rows[0][5].ToString();
        //    txtTitulo.Text = infoDenuncia.Rows[0][6].ToString();
        //    txtResumen.Text = infoDenuncia.Rows[0][7].ToString();

        //    //lblstudentid.Text = (row.FindControl("lblstudent_Id") as Label).Text;
        //    //lblmonth.Text = (row.FindControl("lblMonth_Name") as Label).Text; ;
        //    //txtAmount.Text = (row.FindControl("lblAmount") as Label).Text;
        //    //ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);

        //    //ClientScript.RegisterStartupScript(GetType(), "Show", "<script> $('#modalDetail').modal('toggle');</script>");

        //    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>$( document ).ready(function() { $('#modalDetail').modal('show')});</script>", false);

        //    //modalDetail.Visible = true;

        //    //modalDetail.Visible = true;
        //}
             
        [WebMethod]
        public static string CargarModal(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();
            
            DataTable infoDenuncia = DBHelper.getInfoDenuncia(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(infoDenuncia);

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
        public static string CargarDelegados(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            DataTable delegados = DBHelper.getDelegados(Int64.Parse(idDenuncia));

            DataSet ds = new DataSet();
            ds.Tables.Add(delegados);

            string arreglo = DataSetToJSON(ds);

            //Dictionary<string, object> dict = new Dictionary<string, object>();
            //foreach (DataTable dt in ds.Tables)
            //{
            //    object[] arr = new object[dt.Rows.Count + 1];

            //    for (int i = 0; i <= dt.Rows.Count - 1; i++)
            //    {
            //        arr[i] = dt.Rows[i].ItemArray;
            //    }

            //    dict.Add(dt.TableName, arr);
            //}

            //JavaScriptSerializer json = new JavaScriptSerializer();

            
            return arreglo;

        }

        [WebMethod]
        public static string DelegarDenuncia(string idDenuncia, string usuario)
        {
            DBHelper DBHelper = new DBHelper();

            //int resp = DBHelper.delegarDenuncia(Int64.Parse(idDenuncia), usuario);

            return "";

        }

        [WebMethod]
        public static string AceptarDenuncia(string idDenuncia)
        {
            DBHelper DBHelper = new DBHelper();

            int resp = DBHelper.aceptarDenuncia(Int64.Parse(idDenuncia));

            return resp.ToString();
        }

        //[WebMethod]
        //public static string RechazarDenuncia(string idDenuncia, string comentario)
        //{
        //    DBHelper DBHelper = new DBHelper();

        //    int resp = DBHelper.rechazarDenuncia(Int64.Parse(idDenuncia), comentario);

        //    return resp.ToString();
        //}

        public static string DataSetToJSON(DataSet ds)
        {

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

    }

    
}


