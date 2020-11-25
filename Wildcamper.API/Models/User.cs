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

    public string UserId { get; set; }
    public string Email { get; set; }
    public string DisplayName { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime ModifiedDate { get; set; }

    public virtual ICollection<Image> Image { get; set; }
    public virtual ICollection<Place> Place { get; set; }
    public virtual ICollection<Rating> Rating { get; set; }
  }
}
