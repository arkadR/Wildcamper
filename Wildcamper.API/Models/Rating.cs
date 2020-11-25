using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Wildcamper.API.Models
{
  public partial class Rating
  {
    public int RatingId { get; set; }
    public int PlaceId { get; set; }
    public string CreatorId { get; set; }
    public string Comment { get; set; }
    public int Stars { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime ModifiedDate { get; set; }

    [JsonIgnore]
    public virtual User Creator { get; set; }

    [JsonIgnore]
    public virtual Place Place { get; set; }
  }
}
