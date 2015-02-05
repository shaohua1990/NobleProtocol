using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeeklyExerciseDalAndErrorHandling;

public partial class web_register : System.Web.UI.Page
{
    protected string PostRegisterModal = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        PostRegisterModal = GetPostRegisterModal();
    }

    private string GetPostRegisterModal()
    {
        Template templateInstance = new Template();
        templateInstance.LoadTemplate("modal.tmpl");
        string tmpl = templateInstance.GetTempalteUseXpath("Post-Response-Modal");
        tmpl = HttpUtility.HtmlDecode(tmpl);
        Template.ReplaceInTemplate(ref tmpl, "_{Modal_Id}_", "postRegisterModal");
        Template.ReplaceInTemplate(ref tmpl, "_{Modal_Label}_", "postRegisterLabel");
        return tmpl;
    }
}