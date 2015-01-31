using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;  

namespace DalAndErrorHandling
{
    public class DAL
    {
        public SqlConnection cn;

        public SqlCommand cmd;
        public SqlCommand Cmd
        {
            get { return cmd; }
        }

        public void SetSqlCommand(string sql)
        {
            cmd = new SqlCommand(sql, cn);
        }

        public void SetSqlCommand(string sql, CommandType type)
        {
            cmd = new SqlCommand(sql,cn);
            cmd.CommandType = type;
        }

        public void ConnectDB()
        {
            cn = new SqlConnection();
            if (Helper.GetAppSetting("environment") == "local")
                cn.ConnectionString = Helper.GetConnectionString("localDB");
            else
                cn.ConnectionString = Helper.GetConnectionString("onlineDB");
            cn.Open();
        }

        public DataTable GetDataTable(string sql)
        {
            ConnectDB();
            cmd = new SqlCommand(sql, cn);
            DataTable bookDt = new DataTable();
            SqlDataReader dr = cmd.ExecuteReader();
            bookDt.Load(dr);
            dr.Close(); 
            return bookDt;
        }

        public DataTable GetDataTableWithParam()
        {
            DataTable dt = new DataTable();
            SqlDataReader dr;
            try
            {
                dr = cmd.ExecuteReader();
                dt.Load(dr);
                dr.Close();
                return dt;
            }
            catch (Exception ex)
            {
                string error = ex.Message;
                DebugErrorHelper.WriteErrorLog(error);
                DebugErrorHelper.WriteErrorLog(ex.StackTrace);
            }
            return null;
        }

        public DataTable GetDataTableBySP()
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            try 
            {
                da.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                string error = ex.Message;
                DebugErrorHelper.WriteErrorLog(error);
                DebugErrorHelper.WriteErrorLog(ex.StackTrace);
            }
            return null;
        }     

        public void Modify()
        {
            cmd.ExecuteNonQuery();
        }

        public Dictionary<string, string> ModifyRelationTable()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            try
            {
                cmd.ExecuteNonQuery();
                dict.Add("isRemove", "1");
            }
            catch (Exception ex)
            {
                DebugErrorHelper.WriteErrorLog(ex.Message);
                DebugErrorHelper.WriteErrorLog(ex.StackTrace);
                dict.Add("isRemove", "0");
            }
            return dict;
        }

        public bool ModifyTable()
        {
            try
            {
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                DebugErrorHelper.WriteErrorLog(ex.Message);
                DebugErrorHelper.WriteErrorLog(ex.StackTrace);
                return false;
            }
            return false;
        }

        //add param to the existing sql
        public void AddParam<T>(string paramName, T paramValue, SqlDbType type)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = paramName;
            param.Value = paramValue;
            param.SqlDbType = type;
            cmd.Parameters.Add(param);
        }

        //add param to store procedure
        public void AddParam<T>(string paramName, T paramValue, SqlDbType type, ParameterDirection direction)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = paramName;
            param.Value = paramValue;
            param.SqlDbType = type;
            param.Direction = direction;
            cmd.Parameters.Add(param);
        }

        //add output param to store procedure
        public void AddParam(string paramName, SqlDbType type, ParameterDirection direction)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = paramName; 
            param.SqlDbType = type;
            param.Direction = direction;
            cmd.Parameters.Add(param);
        }

        public void CloseCn()
        {
            cn.Close();
        }

        public bool IsUnique()
        {
            DataTable dt = GetDataTableWithParam();
            if (Helper.IsDataTableNullOrEmpty(dt))
                return true;
            return false; 
        }
    }

}

