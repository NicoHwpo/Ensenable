using System;
using Npgsql;
using Ensenable.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Ensenable.Datos;

namespace Ensenable.Datos
{
    public class QuestionDatos
    {
        public List<QuestionModel> ListarQuestions()
        {
            var oLista = new List<QuestionModel>();

            var con = new Conexion();

            NpgsqlCommand com = new NpgsqlCommand("fn_listar_questions", con.OpenCon());
            com.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oLista.Add(new QuestionModel()
                    {
                        IdQuestion = Convert.ToInt32(dr["id_question"]),
                        IdActivity = Convert.ToInt32(dr["id_activity"]),
                        Question = dr["question"].ToString(),
                        NumQuestion = Convert.ToInt32(dr["num_question"])
                    });
                }
            }
            return oLista;
        }

        
        public bool CrearQuestion(QuestionModel oQuestion)
        {
            bool flag = false;
            var con = new Conexion();

            string spcrearact = "CALL sp_create_question (" + oQuestion.IdActivity + ",'" + oQuestion.Question + "'," + oQuestion.NumQuestion + ")";
            NpgsqlCommand com = new NpgsqlCommand(spcrearact, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        
    }
}