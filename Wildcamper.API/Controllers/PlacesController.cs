using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LinkCollectionApp.Extensions;
using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Wildcamper.API.Models;

namespace Wildcamper.API.Controllers
{
  public class PlacesController : ODataController
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

    public async Task<IActionResult> Delete([FromODataUri] int key)
    {
      var place = await _context.Place.FindAsync(key);
      if (place == null)
        return NotFound();

      _context.Rating.RemoveAll(r => r.PlaceId == key);
      _context.Image.RemoveAll(i => i.PlaceId == key);
      
      _context.Place.Remove(place);
      await _context.SaveChangesAsync();
      return NoContent();
    }

    public async Task<IActionResult> Patch([FromODataUri] int key, Delta<Place> place)
    {
      if (!ModelState.IsValid)
        return BadRequest(ModelState);
      
      var entity = await _context.Place.FindAsync(key);
      if (entity == null)
        return NotFound();
      
      place.Patch(entity);
      try
      {
        await _context.SaveChangesAsync();
      }
      catch (DbUpdateConcurrencyException)
      {
        if (!ProductExists(key))
          return NotFound();
        
        else
          throw;
      }
      return Updated(entity);
    }

    private bool ProductExists(int key)
    {
      return _context.Place.Any(p => p.PlaceId == key);
    }
  }
}
