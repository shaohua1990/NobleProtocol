using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;

namespace WeeklyExerciseDalAndErrorHandling
{
    public class Template
    {
        public XmlDocument doc = new XmlDocument();
        private XmlNodeList nodelist;

        /// <summary>
        /// get Template
        /// </summary>
        /// <param name="path"></param>
        public void LoadTemplate(string path)
        {
            if (Helper.GetAppSetting("environment") == "local")
                path = @"C:\ADrive\NobleProtocol\WeeklyExercise\tmpl\" + path;
            else
                path = @"f:\usr\localuser\qxw1001940965\WeeklyExercise\tmpl\" + path;
            using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                doc.Load(fs);
            }
        }

        public string GetTempalteUseXpath(string templateName)
        {
            nodelist = doc.SelectNodes("//" + templateName);
            return nodelist[0].InnerXml;
        }

        public Dictionary<string, string> GetTemplateDict()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            XmlNodeList nodes = doc.SelectNodes("//Tmpl"); 
            for (int i = 0; i < nodes[0].ChildNodes.Count; i++)
            {
                XmlNode childNode = nodes[0].ChildNodes[i];
                dict.Add(childNode.Name.ToString(), childNode.InnerXml);
            }
            return dict;
        }

        public static void ReplaceInTemplate(ref string tmpl, string placeHolder, string strToReplace)
        {
            tmpl = tmpl.Replace(placeHolder, strToReplace);
        }

        public static void ReplaceInTemplateWithDict(ref string tmpl, Dictionary<string, string> placeHolders)
        {
            foreach (KeyValuePair<string, string> pair in placeHolders)
            {
                tmpl = tmpl.Replace(pair.Key, pair.Value);
            }
        }
    } 
}
