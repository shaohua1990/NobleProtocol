using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalAndErrorHandling;
using ExerciseCom;

public partial class web_process_record : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string action = Request["action"];
        ExerciseRecord record = new ExerciseRecord();
        if (action == "write")
        {
            WriteRecord(record);
        }
        if (action == "readForHomeDisplay")
        {
            ReadRecord(record);
        }
    }

    private void ReadRecord(ExerciseRecord record)
    {
        record.MemberId = int.Parse(Session["memberId"].ToString()); 
        var result = record.ReadForHomeDisplay();
        Response.Write(Helper.GetResponseJson(result));
    }

    private void WriteRecord(ExerciseRecord record)
    {
        record.MemberId = int.Parse(Session["memberId"].ToString());
        record.Running = float.Parse(Request["running"]);
        record.PushUp = int.Parse(Request["pushup"]);
        record.SitUp = int.Parse(Request["situp"]);
        record.Reading = int.Parse(Request["reading"]);
        if (record.Write())
        {
            List<object> list = new List<object>()
            {
                new
                {
                    IsWrite = true
                }
            };
            Response.Write(Helper.GetResponseJson(list));
        }
        else
        {
            List<object> list = new List<object>()
            {
                new
                {
                    IsWrite = false,
                    Content = "Cannot record down"
                }
            };
            Response.Write(Helper.GetResponseJson(list));
        }
    }
}