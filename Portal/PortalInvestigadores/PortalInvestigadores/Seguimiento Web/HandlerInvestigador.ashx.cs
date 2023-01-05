using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Portal_Investigadores.clases;
using static System.Net.Mime.MediaTypeNames;

namespace Seguimiento_Web
{
    /// <summary>
    /// Summary description for HandlerInvestigador
    /// </summary>
    public class HandlerInvestigador : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int iIdQuejas = 0;
            string sIdForm = "";
            foreach (string item in HttpContext.Current.Request.Form.GetValues("idQueja"))
            {
                iIdQuejas = int.Parse(item);
            }
            foreach (string item in HttpContext.Current.Request.Form.GetValues("idForm"))
            {
                sIdForm = item;
            }

            if (context.Request.Files.Count > 0)
            {

                DateTime localDate = DateTime.Now;

                string sNewName = "";
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];

                    string myFilePath = file.FileName;
                    string[] sName = myFilePath.Split('.');
                    string ext = Path.GetExtension(myFilePath);
                    string filename = file.FileName;

                    sNewName = sName[0] + "_" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString()+ DateTime.Now.Millisecond.ToString() + ext;
                    string fname = context.Server.MapPath("~/uploads/Investigacion/" + sNewName);

                    DBHelper DBHelper = new DBHelper();
                    DBHelper.postBQInvArchivos(iIdQuejas, sIdForm, sName[0], ext, "~/uploads/Investigacion/" + sNewName);
                    file.SaveAs(fname);
                }
                context.Response.ContentType = "text/plain";
                context.Response.Write(sNewName);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}