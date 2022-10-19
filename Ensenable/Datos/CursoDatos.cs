using System;
using Npgsql;
using Ensenable.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Ensenable.Datos;

namespace Ensenable.Datos
{
    public class CursoDatos
    {
        public List<CourseModel> ListarCursos()
        {
            var oLista = new List<CourseModel>();

            var con = new Conexion();

            NpgsqlCommand com = new NpgsqlCommand("fn_listar_cursos", con.OpenCon());
            com.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oLista.Add(new CourseModel()
                    {
                        IdCourse = Convert.ToInt32(dr["id_course"]),
                        NameCourse = dr["name_course"].ToString(),
                        Subject = dr["subject"].ToString(),
                        Description = dr["description"].ToString(),
                        Author = dr["author"].ToString(),
                        id_user = Convert.ToInt32(dr["id_user"]),
                        ReleaseDate = dr["release_date"].ToString(),
                        IsPublished = dr["is_published"].ToString()
                    });
                }
            }
            return oLista;
        }

        public bool CrearCurso(CourseModel oCurso)
        {
            bool flag = false;
            var con = new Conexion();

            string spcrearcurso = "CALL sp_create_course ('" + oCurso.NameCourse + "','" + oCurso.Subject + "','" + oCurso.Description + "','" + oCurso.Author + "'," + oCurso.id_user + ")";
            NpgsqlCommand com = new NpgsqlCommand(spcrearcurso, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        public CourseModel ObtenerDetalles(int IdCourse)
        {
            var oCourse = new CourseModel();

            var cn = new Conexion();

            NpgsqlCommand cmd = new NpgsqlCommand("fn_ObtenerDetalles", cn.OpenCon());
            cmd.Parameters.AddWithValue("id_course", IdCourse);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    oCourse.IdCourse = Convert.ToInt32(dr["id_course"]);
                    oCourse.NameCourse = dr["name_course"].ToString();
                    oCourse.Subject = dr["subject"].ToString();
                    oCourse.Description = dr["description"].ToString();
                    oCourse.Author = dr["author"].ToString();
                    oCourse.id_user = Convert.ToInt32(dr["id_user"]);
                    oCourse.ReleaseDate = dr["release_date"].ToString();
                    oCourse.IsPublished = dr["is_published"].ToString();
                }
            }
            return oCourse;
        }

        public bool EditarDetalleCurso(CourseModel oCourse)
        {
            bool flag = false;
            var con = new Conexion();

            string editar = "CALL sp_modify_course (" + oCourse.IdCourse + ",'" + oCourse.NameCourse + "','" + oCourse.Subject + "','" + oCourse.Description + "','" + oCourse.Author + "')";
            NpgsqlCommand com = new NpgsqlCommand(editar, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        public bool PublicarCurso(CourseModel oCourse)
        {
            bool flag = false;
            var con = new Conexion();

            string publicar = "CALL sp_publish_course (" + oCourse.IdCourse + ")";
            NpgsqlCommand com = new NpgsqlCommand(publicar, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        public bool DesPublicarCurso(CourseModel oCourse)
        {
            bool flag = false;
            var con = new Conexion();

            string publicar = "CALL sp_unpublish_course (" + oCourse.IdCourse + ")";
            NpgsqlCommand com = new NpgsqlCommand(publicar, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        public bool EliminarCurso(int IdCourse)
        {
            bool flag;
            var con = new Conexion();

            string sql = "CALL sp_delete_course (" + IdCourse + ")";
            NpgsqlCommand com = new NpgsqlCommand(sql, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }


        public bool SubscribeCourse(int id_user, int IdCourse)
        {
            bool flag;
            var con = new Conexion();

            string sql = "CALL sp_subscribe_course(" + id_user + ","+ IdCourse + ")";
            NpgsqlCommand com = new NpgsqlCommand(sql, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }


        public bool DesubscribeCourse(int id_user, int IdCourse)
        {
            bool flag;
            var con = new Conexion();

            string sql = "CALL sp_desubscribe_course(" + id_user + "," + IdCourse + ")";
            NpgsqlCommand com = new NpgsqlCommand(sql, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }


        public List<int> ListarSubscriptions(int id_user)
        {
            var osubs = new List<int>();
            var con = new Conexion();
            NpgsqlCommand com = new NpgsqlCommand("fn_view_subscriptions", con.OpenCon());
            com.Parameters.AddWithValue("id_user", id_user);
            com.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    osubs.Add(Convert.ToInt32(dr["cursos"]));
                }
            }
            return osubs;
        }

    }
}