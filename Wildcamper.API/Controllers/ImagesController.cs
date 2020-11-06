using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Wildcamper.API.Models;

namespace Wildcamper.API.Controllers
{
  public class ImagesController : ControllerBase
  {
    private readonly WildcamperContext _context;

    public ImagesController(WildcamperContext context)
    {
      _context = context;
    }

    // GET: api/Images
    [EnableQuery]
    public IEnumerable<Image> Get()
    {
      return _context.Image;
    }

    // // GET: api/Images/5
    // [HttpGet("{id}")]
    // public async Task<ActionResult<Images>> GetImage(int id)
    // {
    //     var image = await _context.Images.FindAsync(id);
    //
    //     if (image == null)
    //     {
    //         return NotFound();
    //     }
    //
    //     return image;
    // }
    //
    // // PUT: api/Images/5
    // // To protect from overposting attacks, enable the specific properties you want to bind to, for
    // // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
    // [HttpPut("{id}")]
    // public async Task<IActionResult> PutImage(int id, Images image)
    // {
    //     if (id != image.ImageId)
    //     {
    //         return BadRequest();
    //     }
    //
    //     _context.Entry(image).State = EntityState.Modified;
    //
    //     try
    //     {
    //         await _context.SaveChangesAsync();
    //     }
    //     catch (DbUpdateConcurrencyException)
    //     {
    //         if (!ImageExists(id))
    //         {
    //             return NotFound();
    //         }
    //         else
    //         {
    //             throw;
    //         }
    //     }
    //
    //     return NoContent();
    // }
    //
    // // POST: api/Images
    // // To protect from overposting attacks, enable the specific properties you want to bind to, for
    // // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
    // [HttpPost]
    // public async Task<ActionResult<Images>> PostImage(Images image)
    // {
    //     _context.Images.Add(image);
    //     try
    //     {
    //         await _context.SaveChangesAsync();
    //     }
    //     catch (DbUpdateException)
    //     {
    //         if (ImageExists(image.ImageId))
    //         {
    //             return Conflict();
    //         }
    //         else
    //         {
    //             throw;
    //         }
    //     }
    //
    //     return CreatedAtAction("GetImage", new { id = image.ImageId }, image);
    // }
    //
    // // DELETE: api/Images/5
    // [HttpDelete("{id}")]
    // public async Task<ActionResult<Images>> DeleteImage(int id)
    // {
    //     var image = await _context.Images.FindAsync(id);
    //     if (image == null)
    //     {
    //         return NotFound();
    //     }
    //
    //     _context.Images.Remove(image);
    //     await _context.SaveChangesAsync();
    //
    //     return image;
    // }
    //
    // private bool ImageExists(int id)
    // {
    //     return _context.Images.Any(e => e.ImageId == id);
    // }
  }
}
