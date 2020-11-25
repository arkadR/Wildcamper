using System;
using System.Collections.Generic;

namespace Wildcamper.API.Models
{
  public partial class PlaceType
  {
    public PlaceType()
    {
      Places = new HashSet<Place>();
    }

    public int PlaceTypeId { get; set; }
    public string Name { get; set; }
    public byte[] Icon { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime ModifiedDate { get; set; }

    public virtual ICollection<Place> Places { get; set; }
  }
}
