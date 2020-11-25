using System.Collections.Generic;
using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Mvc;
using Wildcamper.API.Models;

namespace Wildcamper.API.Controllers
{
  public class PlaceTypesController : ControllerBase
  {
    private readonly WildcamperContext _context;

    public PlaceTypesController(WildcamperContext context)
    {
      _context = context;
    }

    [EnableQuery]
    public IEnumerable<PlaceType> GetPlaceTypes()
    {
      return _context.PlaceType;
    }
  }
}
