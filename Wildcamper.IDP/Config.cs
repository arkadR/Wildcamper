using IdentityServer4.Models;
using System.Collections.Generic;
using IdentityServer4;

namespace Wildcamper.IDP
{
  public static class Config
  {
    public static IEnumerable<IdentityResource> Ids =>
      new IdentityResource[]
      {
        new IdentityResources.OpenId(),
        new IdentityResources.Profile(),
      };

    public static IEnumerable<ApiResource> Apis =>
      new ApiResource[]
      {
        new ApiResource(
          "wildcamperapi",
          "Wildcamper API",
          new List<string> { "role" })
        {
          ApiSecrets = { new Secret("apisecret".Sha256()) }
        }
      };

    public static IEnumerable<Client> Clients =>
      new Client[]
      {
        new Client
        {
          AccessTokenType = AccessTokenType.Reference,
          AccessTokenLifetime = 120,
          AllowOfflineAccess = true,
          UpdateAccessTokenClaimsOnRefresh = true,
          ClientName = "Wildcamper Mobile App",
          ClientId = "wildcampermobile",
          AllowedGrantTypes = GrantTypes.Code,
          // RequirePkce = true,
          RedirectUris = new List<string>()
          {
            "com.arkadr.wildcamper.io:/auth"
          },
          PostLogoutRedirectUris = new List<string>()
          {
            "https://localhost:32768/signout-callback-oidc"
          },
          AllowedScopes =
          {
            IdentityServerConstants.StandardScopes.OpenId,
            IdentityServerConstants.StandardScopes.Profile,
            IdentityServerConstants.StandardScopes.Address,
            "roles",
            "wildcamperapi",
          },
          ClientSecrets =
          {
            new Secret("secret".Sha256())
          }
        }
      };
  }
}