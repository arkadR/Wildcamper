using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Wildcamper.API.Models
{
    public partial class Rating
    {
        public int RatingId { get; set; }
        public int PlaceId { get; set; }
        public int CreatorId { get; set; }
        public int? Rating1 { get; set; }
        public string Comment { get; set; }

        [JsonIgnore]
        public virtual User Creator { get; set; }

        [JsonIgnore]
        public virtual Place Place { get; set; }
    }
}
