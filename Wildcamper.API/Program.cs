using System.IO;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Wildcamper.API.Models;

namespace Wildcamper.API
{
  public class Program
  {
    public static void Main(string[] args)
    {
      var host = CreateHostBuilder(args).Build();
      using (var scope = host.Services.CreateScope())
      {
        var services = scope.ServiceProvider;
        var context = scope.ServiceProvider.GetService<WildcamperContext>();
        // SeedCountries(context);
      }
      host.Run();
    }

    private static void SeedCountries(WildcamperContext context)
    {
      context.User.Add(new User
      {
        FirstName = "Arkadiusz",
        LastName = "Rasz",
        Login = "ar",
        UserId = 10
      });

      context.Place.Add(new Place
      {
        CreatorId = 10,
        Description = "dsahj",
        Latitude = 51,
        Longitude = 17,
        PlaceId = 10,
        Name = "Place1"
      });

      context.Image.Add(new Image
      {
        ImageId = 10,
        CreatorId = 10,
        PlaceId = 10,
        Bytes = File.ReadAllBytes("Temp/1.jpg")
      });

      context.SaveChanges();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
      Host.CreateDefaultBuilder(args)
          .ConfigureWebHostDefaults(webBuilder =>
          {
            webBuilder
              .UseKestrel()
              .UseUrls("https://localhost:44310", "https://192.168.0.104:44310", "https://pc-arkadr:44310")
              .UseStartup<Startup>();
          });
  }
}
