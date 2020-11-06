using System;
using System.Collections.Generic;

namespace Wildcamper.API.Models
{
    public partial class User
    {
        public User()
        {
            Image = new HashSet<Image>();
            Place = new HashSet<Place>();
            Rating = new HashSet<Rating>();
        }

        public int UserId { get; set; }
        public string Login { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public virtual ICollection<Image> Image { get; set; }
        public virtual ICollection<Place> Place { get; set; }
        public virtual ICollection<Rating> Rating { get; set; }
    }
}
