using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web; 

namespace DalAndErrorHandling
{
    /// <summary>
    /// Summary description for CrpDebugErrorHelper
    /// </summary>
    public class DebugErrorHelper
    {
        public static void WriteErrorLog(string error)
        {
            CreateLogFolder();
            CreateOrOpenLogFile("Error", error);
        }

        private static void CreateOrOpenLogFile(string logType, string log)
        {
            FileInfo fileInfo;
            if (Helper.site != "online")
                fileInfo = new FileInfo(@"C:\log\OnlineLyrics.log");
            else
                fileInfo = new FileInfo(@"f:\usr\localuser\qxw1001940965\log\OnlineLyrics.log");
            if (!fileInfo.Exists)
            {
                FileStream fs = fileInfo.Create();
                fs.Close();
            }
            using (StreamWriter sw = fileInfo.AppendText())
            {
                sw.Write(DateTime.Now.ToString() + " [{0}]>>>>>>", logType);
                sw.Write(sw.NewLine);
                sw.Write(log);
                sw.Write(sw.NewLine);
            }
        }

        private static void CreateLogFolder()
        {
            string path = string.Empty;
            if (Helper.site != "online")
                path = @"C:\";
            else
                path = @"f:\usr\localuser\qxw1001940965\";
            DirectoryInfo logDir = new DirectoryInfo(path + @"log");
            if (!logDir.Exists)
            {
                DirectoryInfo dir = new DirectoryInfo(path);
                dir.CreateSubdirectory(@"log");
            }
        }
    }

}

