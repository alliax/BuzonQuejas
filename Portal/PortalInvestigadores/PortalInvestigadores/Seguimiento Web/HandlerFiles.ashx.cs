using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Seguimiento_Web
{
    /// <summary>
    /// Summary description for HandlerFiles
    /// </summary>
    public class HandlerFiles : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
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