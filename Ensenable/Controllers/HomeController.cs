using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Ensenable.Models;
using Ensenable.Datos;
using Microsoft.AspNetCore.Http;
using Microsoft.CodeAnalysis;
using Microsoft.AspNetCore.Components.Routing;
using Newtonsoft.Json;
using Microsoft.EntityFrameworkCore.ValueGeneration.Internal;
using System;
using System.Dynamic;

namespace Ensenable.Controllers
{
    public class HomeController : Controller
    {
        UsersDatos usersDatos = new UsersDatos();
        CursoDatos cursoDatos = new CursoDatos();
        ActivityDatos activityDatos = new ActivityDatos();
        LectureDatos lecturedatos = new LectureDatos();
        QuestionDatos questionDatos = new QuestionDatos();
        AnswerDatos answerDatos = new AnswerDatos();



        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {

            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }

        public IActionResult Privacy()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }

        public IActionResult Tutorial1()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }

        public IActionResult Tutorial2()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }

        public IActionResult Tutorial3()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }
        
        //Login y validacion
        public IActionResult Login()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }

        public IActionResult ValidarLogin(UsersModel oUser)
        {
            var bandera = usersDatos.ValidarLogin(oUser.user_email, oUser.user_password);
            if (bandera == 1)
            {
                oUser = usersDatos.getUserInfo(oUser.user_email);
                HttpContext.Session.SetInt32("Login", oUser.id_user);
            TempData["Estoy"] = 0;
                return RedirectToAction("Index");
            }
            else
            {
                TempData["errorLogin"] = 1;
            TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
        }

        //LOGOUT Y ACABAR SESSION
        public IActionResult LogOut()
        {
            TempData["LogOut"] = 1;
            HttpContext.Session.Clear();
            TempData["Estoy"] = 0;
            return RedirectToAction("Index");
        }



        //PAGINA REGISTRARSE
        public IActionResult Register()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }
        [HttpPost]
        public IActionResult Register(UsersModel oUser)
        {
            oUser.user_status = "false";
            var bandera = usersDatos.ValidarRegis(oUser.user_email);
            if (bandera == 1)
            {
                TempData["errorRegis"] = 1;
            TempData["Estoy"] = 0;
                return RedirectToAction("Register");
            }
            var resp = usersDatos.Insertar(oUser);
            if (resp)
            {
                oUser = usersDatos.getUserInfo(oUser.user_email);
                HttpContext.Session.SetInt32("Login", oUser.id_user);
            TempData["Estoy"] = 0;
                return RedirectToAction("Index");
            }
            else
            {
            TempData["Estoy"] = 0;
                return View();
            }
        }


        //PAGINA ABOUT
        public IActionResult About()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View();
        }



        //PAGINA ACCOUNT
        public IActionResult Account()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if(ViewBag.Session == null)
            {
                return RedirectToAction("Login");
            }
            TempData["Estoy"] = 1;
            var oUser = usersDatos.Obtener(ViewBag.Session);
            return View(oUser);
        }

        public IActionResult EditProfile()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            TempData["Estoy"] = 0;
            return View(oUser);
        }
        [HttpPost]
        public IActionResult EditProfile(UsersModel oUser)
        {

            if (!ModelState.IsValid)
            {
                TempData["Estoy"] = 0;
                return View();
            }

            var resp = usersDatos.Editar(oUser);
            if (resp)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Account");
            }
            else
            {
            TempData["Estoy"] = 0;
                return View();
            }
        }

        //SAMUEL
        //PAGINA CURSOS
        public IActionResult Cursos()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            
            var oLista = cursoDatos.ListarCursos();
            TempData["Estoy"] = 0;
            return View(oLista);
        }


        public IActionResult CrearCurso()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            TempData["Estoy"] = 0;
            return View();
        }
        [HttpPost]
        public IActionResult CrearCurso(CourseModel oCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            var oUser = usersDatos.Obtener(ViewBag.Session);
            oCourse.id_user = ViewBag.Session;
            oCourse.Author = oUser.user_name + " " + oUser.user_firstlastname;
            var resp = cursoDatos.CrearCurso(oCourse);
            if (resp)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Cursos");
            }
            else
            {
            TempData["Estoy"] = 0;
                return View();
            }
        }




        //DOMINGO YAAAAA
        public IActionResult EditarDetallesCurso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oCurso = cursoDatos.ObtenerDetalles(IdCourse);
            TempData["CursoActual"] = JsonConvert.SerializeObject(oCurso);
            TempData["Estoy"] = 0;
            return View(oCurso);
        }

        [HttpPost]
        public IActionResult EditarDetallesCurso(CourseModel oCurso)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if(ViewBag.Session == null)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            if (TempData.ContainsKey("CursoActual"))
            {
                var TempOcurso = JsonConvert.DeserializeObject<CourseModel>(TempData["CursoActual"].ToString());
                oCurso.IdCourse = TempOcurso.IdCourse;
                oCurso.id_user = ViewBag.Session;
                var oUser = usersDatos.Obtener(ViewBag.Session);
                oCurso.Author = oUser.user_name + " " + oUser.user_firstlastname;
                var respuesta = cursoDatos.EditarDetalleCurso(oCurso);
                if (respuesta)
                {
            TempData["Estoy"] = 0;
                    return RedirectToAction("Cursos");
                }
                else
            TempData["Estoy"] = 0;
                    return View();
            }
            else
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
            
        }

        public IActionResult PublicarCurso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oCurso = cursoDatos.ObtenerDetalles(IdCourse);
            var respuesta = cursoDatos.PublicarCurso(oCurso);
            if (respuesta)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Cursos");
            }
            else
            {

                TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }


        public IActionResult DesPublicarCurso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oCurso = cursoDatos.ObtenerDetalles(IdCourse);
            var respuesta = cursoDatos.DesPublicarCurso(oCurso);
            if (respuesta)
            {
                if (TempData["Estoy"].Equals(1))
                    return RedirectToAction("Account");
                return RedirectToAction("Cursos");
            }
            else
            {

            TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }

        

        public IActionResult EliminarCurso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oCurso = cursoDatos.ObtenerDetalles(IdCourse);
            var respuesta = cursoDatos.EliminarCurso(oCurso.IdCourse);
            if (respuesta)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Cursos");
            }
            else
            {

            TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }




        public IActionResult SubscribirseCurso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
           
            var resp = cursoDatos.SubscribeCourse(ViewBag.Session, IdCourse);
            if (resp)
            {
            TempData["Estoy"] = 0;
                return RedirectToAction("Cursos");
            }
            else
            TempData["Estoy"] = 0;
                return RedirectToAction("Error");
        }




        public IActionResult DesubscribirseCurso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
           
            var resp = cursoDatos.DesubscribeCourse(ViewBag.Session, IdCourse);
            if (resp)
            {
                if (TempData["Estoy"].Equals(1))
                    return RedirectToAction("Account");

                TempData["Estoy"] = 0;
                return RedirectToAction("Cursos");
            }
            else
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }


        
        // VISTA PARA CUALQUIER CURSO

        public IActionResult Prueba1()
        {
            return View();
        }







        //pruebas

        public IActionResult ListLectures(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oLecture = lecturedatos.ListarLectures();
            TempData["IdCourseAct"] = IdCourse;
            TempData["Estoy"] = 0;
            return View(oLecture);
        }


        public IActionResult AddLect(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }

            TempData["IdCourseAct"] = IdCourse;
            TempData["Estoy"] = 0;
            return View();
        }

        [HttpPost]
        public IActionResult AddLect(LectureModel oLecture)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            if (TempData.ContainsKey("IdCourseAct"))
            {
                oLecture.IdCourse = (int)TempData["IdCourseAct"] ;
                var respuesta = lecturedatos.CrearLecture(oLecture);
                if (respuesta)
                {
                    TempData["Estoy"] = 0;
                    return RedirectToAction("ListLectures", new { IdCourse = (int)TempData["IdCourseAct"] });
                }
                else
                    TempData["Estoy"] = 0;
                return View();
            }
            else
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }



        public IActionResult ListActivities(int IdLecture)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oActivity = activityDatos.ListarActivities();
            TempData["IdLectureAct"] = IdLecture;
            TempData["Estoy"] = 0;
            return View(oActivity);
        }


        public IActionResult AddAct(int IdLecture)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            TempData["IdLectureAct"] = IdLecture;
            TempData["Estoy"] = 0;
            return View();
        }

        [HttpPost]
        public IActionResult AddAct(ActivityModel oActivity)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            if (TempData.ContainsKey("IdLectureAct"))
            {
                oActivity.IdLecture = (int)TempData["IdLectureAct"];
                var respuesta = activityDatos.CrearActivity(oActivity);
                if (respuesta)
                {
                    TempData["Estoy"] = 0;
                    return RedirectToAction("ListActivities", new { IdLecture = (int)TempData["IdLectureAct"] });
                }
                else
                    TempData["Estoy"] = 0;
                return View();
            }
            else
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }




        public IActionResult ListQuestions(int IdActivity)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oQuestions = questionDatos.ListarQuestions();
            TempData["IdActivityAct"] = IdActivity;
            TempData["Estoy"] = 0;
            return View(oQuestions);
        }


        public IActionResult AddQuestion(int IdActivity)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            TempData["IdActivityAct"] = IdActivity;
            TempData["Estoy"] = 0;
            return View();
        }

        [HttpPost]
        public IActionResult AddQuestion(QuestionModel oQuestion)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            if (TempData.ContainsKey("IdActivityAct"))
            {
                oQuestion.IdActivity = (int)TempData["IdActivityAct"];
                var respuesta = questionDatos.CrearQuestion(oQuestion);
                if (respuesta)
                {
                    TempData["Estoy"] = 0;
                    return RedirectToAction("ListQuestions", new { IdActivity = (int)TempData["IdActivityAct"] });
                }
                else
                    TempData["Estoy"] = 0;
                return View();
            }
            else
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }


        public IActionResult ListResp(int IdQuestion)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            var oAnswers = answerDatos.ListarAnswers();
            TempData["IdQuestionAct"] = IdQuestion;
            TempData["Estoy"] = 0;
            return View(oAnswers);
        }


        public IActionResult AddAnswer(int IdQuestion)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            TempData["IdQuestionAct"] = IdQuestion;
            TempData["Estoy"] = 0;
            return View();
        }

        [HttpPost]
        public IActionResult AddAnswer(AnswerModel oAnswer)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            if (ViewBag.Session == null)
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Login");
            }
            var oUser = usersDatos.Obtener(ViewBag.Session);
            if (oUser.user_role == 3)
            {
                return RedirectToAction("Index");
            }
            if (TempData.ContainsKey("IdQuestionAct"))
            {
                oAnswer.IdQuestion = (int)TempData["IdQuestionAct"];
                var respuesta = answerDatos.CrearAnswer(oAnswer);
                if (respuesta)
                {
                    TempData["Estoy"] = 0;
                    return RedirectToAction("ListResp", new { IdQuestion = (int)TempData["IdQuestionAct"] });
                }
                else
                    TempData["Estoy"] = 0;
                return View();
            }
            else
            {
                TempData["Estoy"] = 0;
                return RedirectToAction("Error");
            }
        }



        public IActionResult Curso(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["IdCourseAct"] = IdCourse;

           // cursomodel.CursoInfo = oCurso;
            var lists = lecturedatos.ListarLectures();
            //cursomodel.LectureList = lists;

            return View(lists);
        }


        public IActionResult Game(int IdCourse)
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["IdCourseAct"] = IdCourse;
            return View();
        }



        //..
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            ViewBag.Session = HttpContext.Session.GetInt32("Login");
            TempData["Estoy"] = 0;
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


    }
}