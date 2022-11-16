using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

namespace Seguimiento_Web
{
    /// <summary>
    /// Summary description for FileUploadHandler
    /// </summary>
    public class FileUploadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files.Count > 0)
            {

                DateTime localDate = DateTime.Now;
                string nombre =  localDate.ToString().Replace("/","").Replace(":","").Replace(" ","").Replace("AM", "").Replace("PM", "");
                
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];

                    string myFilePath = file.FileName;
                    string ext = Path.GetExtension(myFilePath);

                    nombre = nombre + ext;
                    string fname = context.Server.MapPath("~/uploads/" + nombre);
                    file.SaveAs(fname);
                }
                context.Response.ContentType = "text/plain";
                context.Response.Write(nombre);
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