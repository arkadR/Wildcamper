﻿using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Wildcamper.API.Models
{
  public partial class Image
  {
    public int ImageId { get; set; }
    public int PlaceId { get; set; }
    public string CreatorId { get; set; }
    public byte[] Bytes { get; set; }

    public DateTime CreatedDate { get; set; }
    public DateTime ModifiedDate { get; set; }

    [JsonIgnore]
    public virtual User Creator { get; set; }

    [JsonIgnore]
    public virtual Place Place { get; set; }
  }
}
