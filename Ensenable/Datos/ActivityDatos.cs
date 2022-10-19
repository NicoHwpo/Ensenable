using System;
using Npgsql;
using Ensenable.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Ensenable.Datos;

namespace Ensenable.Datos
{
    public class ActivityDatos
    {
        public List<ActivityModel> ListarActivities()
        {
            var oLista = new List<ActivityModel>();

            var con = new Conexion();

            NpgsqlCommand com = new NpgsqlCommand("fn_listar_activities", con.OpenCon());
            com.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oLista.Add(new ActivityModel()
                    {
                        IdActivity = Convert.ToInt32(dr["id_activity"]),
                        IdLecture = Convert.ToInt32(dr["id_lecture"]),
                        NameActivity = dr["name_activity"].ToString(),
                        Instructions = dr["instructions"].ToString(),
                        NumQuestions = Convert.ToInt32(dr["num_questions"]),
                        NumActivity = Convert.ToInt32(dr["num_activity"])
                    });
                }
            }
            return oLista;
        }

        public ActivityModel ObtenerDetallesAct(int IdActivity)
        {
            var oActivity = new ActivityModel();

            var cn = new Conexion();

            NpgsqlCommand cmd = new NpgsqlCommand("fn_get_activity", cn.OpenCon());
            cmd.Parameters.AddWithValue("pid_activity", IdActivity);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    oActivity.IdActivity = Convert.ToInt32(dr["id_activity"]);
                    oActivity.IdLecture = Convert.ToInt32(dr["id_lecture"]);
                    oActivity.NameActivity = dr["name_activity"].ToString();
                    oActivity.Instructions = dr["instructions"].ToString();
                    oActivity.NumActivity = Convert.ToInt32(dr["num_activity"]);
                }
            }
            return oActivity;
        }

        public bool EditarDetalleActivity(ActivityModel oActivity)
        {
            bool flag = false;
            var con = new Conexion();

            string editar = "CALL sp_modify_activity (" + oActivity.IdActivity + "," + oActivity.IdLecture + ",'" + oActivity.NameActivity + "','" + oActivity.Instructions + "'," + oActivity.NumActivity + ")";
            NpgsqlCommand com = new NpgsqlCommand(editar, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        public bool CrearActivity(ActivityModel oActivity)
        {
            bool flag = false;
            var con = new Conexion();

            string spcrearact = "CALL sp_create_activity (" + oActivity.IdLecture + ",'" + oActivity.NameActivity + "','" + oActivity.Instructions + "'," + oActivity.NumQuestions + "," + oActivity.NumActivity + ")";
            NpgsqlCommand com = new NpgsqlCommand(spcrearact, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        public bool EliminarActivity(int IdActivity)
        {
            bool flag;
            var con = new Conexion();

            string sql = "CALL sp_delete_activity (" + IdActivity + ")";
            NpgsqlCommand com = new NpgsqlCommand(sql, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

    }
}