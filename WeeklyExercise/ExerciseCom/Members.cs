﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Text;
using System.Threading.Tasks; 
using WeeklyExerciseDalAndErrorHandling;

namespace ExerciseCom
{
    public class Members
    { 
        private DAL dal = new DAL();
        public int MemberId { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }

        public bool IsNameUnique()
        {
            dal.ConnectDB();
            dal.SetSqlCommand("[dbo].[WeeklyExercise_CheckNameIsUnique_15.01]",CommandType.StoredProcedure); 
            dal.AddParam("@username", Name, SqlDbType.VarChar, ParameterDirection.Input);
            dal.AddParam("@isUnique", SqlDbType.Int, ParameterDirection.Output);
            dal.ModifyTable();
            dal.CloseCn();
            string isUnique = dal.Cmd.Parameters["@isUnique"].Value.ToString();
            if (isUnique == "1")
                return true;
            return false;
        }

        public bool Register()
        {
            string sql;
            if(Helper.GetAppSetting("environment") == "online")
                sql = "insert into weeklyexercisemembers values (@username,@password)";
            else 
                sql = "insert into members values (@username,@password)"; 
            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@username", Name, SqlDbType.VarChar);
            dal.AddParam("@password", Password, SqlDbType.VarChar);
            bool result = dal.ModifyTable();
            dal.CloseCn();
            return result; 
        }

        public bool Login()
        {
            string sql;
            if(Helper.GetAppSetting("environment") == "online")
                sql = "select memberId from weeklyexercisemembers where username=@username and password=@password";
            else
                sql = "select memberId from members where username=@username and password=@password";
            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@username", Name, SqlDbType.VarChar);
            dal.AddParam("@password", Password, SqlDbType.VarChar);
            DataTable dt = dal.GetDataTableWithParam();
            dal.CloseCn();
            if (dt.Rows.Count > 0)
            {
                MemberId = int.Parse(dt.Rows[0]["memberId"].ToString());
                return true;  
            }
            return false;
        }

        public int GetMemberIdByName()
        {
            string sql;
            if (Helper.GetAppSetting("environment") == "online")
                sql = "select memberId from weeklyexercisemembers where username = @username";
            else
                sql = "select memberId from members where username = @username"; 
            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@username", Name, SqlDbType.VarChar);
            DataTable dt = dal.GetDataTableWithParam();
            dal.CloseCn();
            MemberId = int.Parse(dt.Rows[0]["memberId"].ToString());
            return MemberId;
        }

        public List<object> GetFriends()
        {
            string sql;
            if (Helper.GetAppSetting("environment") == "online")
                sql = "select memberId, username from weeklyexercisemembers where memberId != @memberId";
            else
                sql = "select memberId, username from members where memberId != @memberId"; 
            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@memberId",MemberId,SqlDbType.Int);
            DataTable dt = dal.GetDataTableWithParam();
            dal.CloseCn();
            List<object> result = new List<object>();
            foreach (DataRow row in dt.Rows)
            {
                result.Add(new
                {
                    MemberId = row.Field<int>("memberId"),
                    Name = row.Field<string>("username")
                });
            }
            return result;
        }
    } 
}
