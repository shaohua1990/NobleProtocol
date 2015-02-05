using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using ExerciseCom;
using WeeklyExerciseDalAndErrorHandling;

public partial class web_process_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Members member = new Members();
        member.Name = Request["name"];
        member.Password = Request["password"];
        if (Session["username"] != null && member.Name == Session["username"].ToString()||member.Login())
        {
            List<object> result = new List<object>()
            {
                new
                {
                    IsLogin = "true"
                }
            };
            Session["username"] = member.Name;  
            Session["memberId"] = member.GetMemberIdByName();
            Response.Write(Helper.GetResponseJson(result));
        } 
    }
}