using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Mvc;
using Wildcamper.API.Models;

namespace Wildcamper.API.Controllers
{
  public class PlacesController : ControllerBase
  {
    private readonly WildcamperContext _context;

    public PlacesController(WildcamperContext context)
    {
      _context = context;
    }

    [EnableQuery]
    public IEnumerable<Place> Get()
    {
      return _context.Place;
    }

    [EnableQuery]
    public SingleResult<Place> Get([FromODataUri] int key)
    {
      var result = _context.Place.Where(p => p.PlaceId == key);
      return SingleResult.Create(result);
    }

    public async Task<IActionResult> Post([FromBody] Place model)
    {
      if (!ModelState.IsValid)
        return BadRequest(ModelState);

      if (_context.User.Any(u => u.UserId == model.CreatorId) == false)
        return NotFound(nameof(Place.PlaceId));

      await _context.AddAsync(model);
      await _context.SaveChangesAsync();
      return Created(new Uri($"{Request.Path}/{model.PlaceId}", UriKind.Relative), model);
    }

    // GET: api/Places/5
    // [HttpGet("{id}")]
    // public async Task<ActionResult<Place>> GetPlace(int id)
    // {
    //   var place = await _context.Place
    //     .Include(p => p.Images)
    //     .SingleOrDefaultAsync(p => p.PlaceId == id);
    //
    //   if (place == null)
    //     return NotFound();
    //
    //   return place;
    // }
    //
    // // PUT: api/Places/5
    // // To protect from overposting attacks, enable the specific properties you want to bind to, for
    // // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
    // [HttpPut("{id}")]
    // public async Task<IActionResult> PutPlace(int id, Place place)
    // {
    //   if (id != place.PlaceId)
    //   {
    //     return BadRequest();
    //   }
    //
    //   _context.Entry(place).State = EntityState.Modified;
    //
    //   try
    //   {
    //     await _context.SaveChangesAsync();
    //   }
    //   catch (DbUpdateConcurrencyException)
    //   {
    //     if (!PlaceExists(id))
    //     {
    //       return NotFound();
    //     }
    //     else
    //     {
    //       throw;
    //     }
    //   }
    //
    //   return NoContent();
    // }
    //
    // // POST: api/Places
    // // To protect from overposting attacks, enable the specific properties you want to bind to, for
    // // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
    // [HttpPost]
    // public async Task<ActionResult<Place>> PostPlace(Place place)
    // {
    //   _context.Place.Add(place);
    //   try
    //   {
    //     await _context.SaveChangesAsync();
    //   }
    //   catch (DbUpdateException)
    //   {
    //     if (PlaceExists(place.PlaceId))
    //     {
    //       return Conflict();
    //     }
    //     else
    //     {
    //       throw;
    //     }
    //   }
    //
    //   return CreatedAtAction("GetPlace", new { id = place.PlaceId }, place);
    // }
    //
    // // DELETE: api/Places/5
    // [HttpDelete("{id}")]
    // public async Task<ActionResult<Place>> DeletePlace(int id)
    // {
    //   var place = await _context.Place.FindAsync(id);
    //   if (place == null)
    //   {
    //     return NotFound();
    //   }
    //
    //   _context.Place.Remove(place);
    //   await _context.SaveChangesAsync();
    //
    //   return place;
    // }
    //
    // private bool PlaceExists(int id)
    // {
    //   return _context.Place.Any(e => e.PlaceId == id);
    // }
  }
}
