﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalAndErrorHandling;
using ExerciseCom;

public partial class web_friends_data : System.Web.UI.Page
{
    private Members member = new Members();
    protected void Page_Load(object sender, EventArgs e)
    { 
        string why = Request["why"];
        if (why == "displayFriendList")
        {
            GetFriendList();
        }
    }

    private void GetFriendList()
    {
        var result = member.GetFriends();
        Response.Write(Helper.GetResponseJson(result));
    }
}