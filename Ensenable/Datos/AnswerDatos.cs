using System;
using Npgsql;
using Ensenable.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Ensenable.Datos;

namespace Ensenable.Datos
{
    public class AnswerDatos
    {
        public List<AnswerModel> ListarAnswers()
        {
            var oLista = new List<AnswerModel>();

            var con = new Conexion();

            NpgsqlCommand com = new NpgsqlCommand("fn_listar_answer", con.OpenCon());
            com.CommandType = System.Data.CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oLista.Add(new AnswerModel()
                    {
                        IdAnswer = Convert.ToInt32(dr["id_answer"]),
                        IdQuestion = Convert.ToInt32(dr["id_question"]),
                        Answer = dr["answer"].ToString(),
                        IsCorrect = dr["is_correct"].ToString(),
                        NumAnswer = Convert.ToInt32(dr["num_answer"])
                    });
                }
            }
            return oLista;
        }

        
        public bool CrearAnswer(AnswerModel oAnswer)
        {
            bool flag = false;
            var con = new Conexion();

            string spcrearact = "CALL sp_create_answer (" + oAnswer.IdQuestion + ",'" + oAnswer.Answer + "','" + oAnswer.IsCorrect +"'," + oAnswer.NumAnswer + ")";
            NpgsqlCommand com = new NpgsqlCommand(spcrearact, con.OpenCon());
            com.ExecuteNonQuery();
            flag = true;
            con.CloseCon();
            return flag;
        }

        
    }
}