using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Wildcamper.API.Models
{
  public partial class Place
  {
    public Place()
    {
      Images = new HashSet<Image>();
      Ratings = new HashSet<Rating>();
    }

    public int PlaceId { get; set; }
    public decimal Latitude { get; set; }
    public decimal Longitude { get; set; }
    public int CreatorId { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }

    [JsonIgnore]
    public virtual User Creator { get; set; }
    public virtual ICollection<Image> Images { get; set; }
    public virtual ICollection<Rating> Ratings { get; set; }
  }
}
