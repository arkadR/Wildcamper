using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Mvc;
using Wildcamper.API.Models;

namespace Wildcamper.API.Controllers
{
  public class UsersController : ControllerBase
  {
    private readonly WildcamperContext _context;

    public UsersController(WildcamperContext context)
    {
      _context = context;
    }

    [EnableQuery]
    public IEnumerable<User> Get()
    {
      return _context.User;
    }

    public async Task<ActionResult<User>> Post([FromBody] User user)
    {
      if (_context.User.Any(u => u.UserId == user.UserId))
        return Conflict();

      await _context.User.AddAsync(user);
      await _context.SaveChangesAsync();

      return Created(new Uri($"{Request.Path}/{user.UserId}", UriKind.Relative), user);
    }
  }
}
