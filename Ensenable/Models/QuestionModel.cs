using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Ensenable.Models
{
    public class QuestionModel
    {
        public int IdQuestion { get; set; }

        public int IdActivity { get; set; }

        public string Question { get; set; }

        public int NumQuestion { get; set; }
    }
}