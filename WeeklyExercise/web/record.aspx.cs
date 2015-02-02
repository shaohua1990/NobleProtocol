using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalAndErrorHandling;

public partial class web_record : System.Web.UI.Page 
{
    protected string PostRecordModal = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
            Helper.KickOut();
        PostRecordModal = GetPostRecordModal();
    }

    private string GetPostRecordModal()
    {
        Template templateInstance = new Template();
        templateInstance.LoadTemplate("modal.tmpl");
        string tmpl = templateInstance.GetTempalteUseXpath("Post-Response-Modal");
        tmpl = HttpUtility.HtmlDecode(tmpl);
        Template.ReplaceInTemplate(ref tmpl, "_{Modal_Id}_", "postRecordModal");
        Template.ReplaceInTemplate(ref tmpl, "_{Modal_Label}_", "postRecordLabel");
        return tmpl;
    }
}