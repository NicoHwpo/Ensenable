using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Ensenable.Models
{
    public class ActivityModel
    {
        public int IdActivity { get; set; }

        public int IdLecture { get; set; }

        public string NameActivity { get; set; }

        public string Instructions { get; set; }

        public int NumQuestions { get; set; }
        public int NumActivity { get; set; }
    }
}