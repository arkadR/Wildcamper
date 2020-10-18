// Licensed under the Apache License, Version 2.0. See LICENSE in the project root for license information.

using System.Collections.Generic;
using System.Security.Claims;
using IdentityServer4.Test;

namespace Wildcamper.IDP
{
  public class TestUsers
  {
    public static List<TestUser> Users = new List<TestUser>
    {
      new TestUser
      {
        SubjectId = "d860efca-22d9-47fd-8249-791ba61b07c7",
        Username = "Arek",
        Password = "password",

        Claims = new List<Claim>
        {
          new Claim("role", "FreeUser"),
        }
      },
      new TestUser
      {
        SubjectId = "b7539694-97e7-4dfe-84da-b4256e1ff5c7",
        Username = "Claire",
        Password = "password",

        Claims = new List<Claim>
        {
          new Claim("role", "PayingUser"),
        }
      }
    };
  }
}