using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics.Eventing.Reader;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
/// <summary>
/// Summary description for Helper
/// </summary>
using System.Web.Script.Serialization;

namespace WeeklyExerciseDalAndErrorHandling
{
    public class Helper
    { 
        public static string site = string.Empty; 
        static Helper()
        {  
            site = ConfigurationManager.AppSettings["environment"]; 
            string dir = Directory.GetCurrentDirectory();
            Console.WriteLine(dir);
        } 

        public static void KickOut()
        { 
            HttpContext.Current.Response.Redirect("login.aspx");
        }

        public static string GetResponseJson<T>(Dictionary<string, T> response)
        {
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
            HttpContext.Current.Response.ContentType = "text/xml";
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(response);
        }

        public static string GetResponseJson(List<object> response)
        {
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
            HttpContext.Current.Response.ContentType = "text/xml";
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(response);
        }

        public static string GetResponseJson<T>(List<T> response)
        {
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
            HttpContext.Current.Response.ContentType = "text/xml";
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(response);
        }

        public static bool IsDataTableNullOrEmpty(DataTable dt)
        {
            if (dt == null || dt.Rows.Count == 0)
                return true;
            return false;
        }

        public static string GetConnectionString(string db)
        {
            return ConfigurationManager.ConnectionStrings[db].ConnectionString;
        }

        public static string GetAppSetting(string key)
        {
            return ConfigurationManager.AppSettings[key];
        }
    }

}
