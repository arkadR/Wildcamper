using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Mvc;
using Wildcamper.API.Models;

namespace Wildcamper.API.Controllers
{
  public class RatingsController : ControllerBase
  {
    private readonly WildcamperContext _context;

    public RatingsController(WildcamperContext context)
    {
      _context = context;
    }

    [EnableQuery]
    public IEnumerable<Rating> GetRatings()
    {
      return _context.Rating;
    }

    public async Task<IActionResult> Post([FromBody] Rating model)
    {
      if (!ModelState.IsValid)
        return BadRequest(ModelState);

      if (_context.User.Any(u => u.UserId == model.CreatorId) == false)
        return NotFound(nameof(Rating.CreatorId));

      if (_context.Place.Any(u => u.PlaceId == model.PlaceId) == false)
        return NotFound(nameof(Rating.PlaceId));

      await _context.AddAsync(model);
      await _context.SaveChangesAsync();
      return Created(new Uri($"{Request.Path}/{model.RatingId}", UriKind.Relative), model);
    }
  }

}