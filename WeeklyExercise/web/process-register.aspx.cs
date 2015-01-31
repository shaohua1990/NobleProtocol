using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalAndErrorHandling;
using ExerciseCom;

public partial class web_process_register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        Members member = new Members();
        member.Name = Request["name"];
        member.Password = Request["password"];
        if (member.IsNameUnique())
        {
            bool result = member.Register();
            List<object> list = new List<object>()
            {
                new
                {
                    fail = false
                }
            };
            Session["name"] = member.Name;
            Response.Write(Helper.GetResponseJson(list));
        }
        else
        {
            List<object> list = new List<object>()
            {
                new
                {
                    fail = true,
                    text = "Name is not unique"
                }
            };
            Response.Write(Helper.GetResponseJson(list));
        }
            
    }
}