using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Ensenable.Models
{
    public class AnswerModel
    {
        public int IdAnswer { get; set; }

        public int IdQuestion { get; set; }

        public string Answer { get; set; }

        public string IsCorrect { get; set; }

        public int NumAnswer { get; set; }

    }
}