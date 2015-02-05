using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks; 
using WeeklyExerciseDalAndErrorHandling;

namespace ExerciseCom
{
    public class ExerciseRecord
    {
        private DAL dal = new DAL();
        public int RecordId { get; set; }
        public int MemberId { get; set; }
        public float Running { get; set; }
        public int PushUp { get; set; }
        public int SitUp { get; set; }
        public int Reading { get; set; }
        public DateTime TimeStamp
        {
            get { return DateTime.Now; }
        }


        public bool Write()
        {
            string sql;
            if(Helper.GetAppSetting("environment") == "online")
                sql = "insert into weeklyexerciserecord values(@memberId,@timestamp,@running,@pushup,@situp,@reading)";
            else
                sql = "insert into record values(@memberId,@timestamp,@running,@pushup,@situp,@reading)";                
            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@memberId",MemberId, SqlDbType.Int);
            dal.AddParam("@timestamp",TimeStamp, SqlDbType.DateTime);
            dal.AddParam("@running",Running,SqlDbType.Float);
            dal.AddParam("@pushup", PushUp, SqlDbType.Int);
            dal.AddParam("@situp", SitUp, SqlDbType.Int);
            dal.AddParam("@reading", Reading, SqlDbType.Int);
            bool IsWrite = dal.ModifyTable();
            dal.CloseCn();
            return IsWrite;
        }

        public List<object> ReadForHomeDisplay()
        {
            string sql;
            if(Helper.GetAppSetting("environment") == "online") 
                sql = "select * from weeklyexerciserecord where memberId = @memberId and timestamp between @lastFriday and @now";
            else
                sql = "select * from record where memberId = @memberId and timestamp between @lastFriday and @now";
            DateTime now = DateTime.Now;
            DateTime lastFriday = GetLastFridayDate(now);

            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@memberId",MemberId,SqlDbType.Int);
            dal.AddParam("@lastFriday",lastFriday,SqlDbType.DateTime);
            dal.AddParam("@now", now, SqlDbType.DateTime);
            DataTable dt = dal.GetDataTableWithParam();
            List<object> result = new List<object>();
            bool IsClassWarning = true;
            foreach (DataRow row in dt.Rows)
            {
                Toggle(ref IsClassWarning);
                result.Add(new
                {
                    recordId = row["recordId"],
                    running = row["running"],
                    pushup = row["pushup"],
                    situp = row["situp"],
                    reading = row["reading"],
                    tstamp = (row.Field<DateTime>("timestamp")).Date.ToString("yyyy-MM-dd"),
                    recordClass = IsClassWarning
                });
            }
            return result;
        }

        public List<object> ReadTotalForLastWeek()
        {
            string sql;
            if(Helper.GetAppSetting("environment") == "online")
                sql = "select sum(running) as total_running, " +
                         "sum(pushup) as total_pushup, " +
                         "sum(situp) as total_situp, " +
                         "sum(reading) as total_reading " +
                         "from weeklyexerciserecord where memberId = @memberId and timestamp between @lastlastFriday and @lastFriday";
            else
                sql = "select sum(running) as total_running, " +
                         "sum(pushup) as total_pushup, " +
                         "sum(situp) as total_situp, " +
                         "sum(reading) as total_reading " +
                         "from record where memberId = @memberId and timestamp between @lastlastFriday and @lastFriday";
            DateTime now = DateTime.Now;
            DateTime lastFriday = GetLastFridayDate(now);
            DateTime lastLastFriday = GetLastFridayDate(lastFriday.AddDays(-1));

            dal.ConnectDB();
            dal.SetSqlCommand(sql);
            dal.AddParam("@memberId", MemberId, SqlDbType.Int);
            dal.AddParam("@lastFriday", lastFriday, SqlDbType.DateTime);
            dal.AddParam("@lastlastFriday", lastLastFriday, SqlDbType.DateTime);
            DataTable dt = dal.GetDataTableWithParam();
            List<object> result = new List<object>();
            bool IsClassWarning = true;
            foreach (DataRow row in dt.Rows)
            {
                Toggle(ref IsClassWarning);
                result.Add(new
                { 
                    lastweek_total_running 
                        = row["total_running"]??0,
                    lastweek_total_pushup
                        = row["total_pushup"]??0,
                    lastweek_total_situp 
                        = row["total_situp"]??0,
                    lastweek_total_reading
                        = row["total_reading"]??0
                });
            }
            return result;
        } 

        private void Toggle(ref bool value)
        {
            if (value)
                value = false;
            else
                value = true;
        }

        private DateTime GetLastFridayDate(DateTime dt)
        { 
            while (dt.DayOfWeek != DayOfWeek.Friday)
            {
                dt = dt.AddDays(-1);
            }
            return dt.Date;
        } 
    }

}
