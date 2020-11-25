using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
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

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int PlaceId { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public string CreatorId { get; set; }
    public int PlaceTypeId { get; set; }
    public decimal Latitude { get; set; }
    public decimal Longitude { get; set; }
    public string Country { get; set; }
    public string Region { get; set; }
    public string City { get; set; }
    public byte[] Thumbnail { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime ModifiedDate { get; set; }

    [JsonIgnore]
    public virtual User Creator { get; set; }
    public virtual PlaceType PlaceType { get; set; }
    public virtual ICollection<Image> Images { get; set; }
    public virtual ICollection<Rating> Ratings { get; set; }
  }
}
