using System;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Serilog;
using Serilog.Events;
using Wildcamper.API.Models;

namespace Wildcamper.API
{
  public class Program
  {
    public static void Main(string[] args)
    {
      Log.Logger = new LoggerConfiguration()
        .MinimumLevel.Debug()
        .MinimumLevel.Override("Microsoft", LogEventLevel.Debug)
        .Enrich.FromLogContext()
        .WriteTo.Console()
        .CreateLogger();

      try
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
      catch (Exception ex)
      {
        Log.Fatal(ex, "Host terminated unexpectedly");
      }
      finally
      {
        Log.CloseAndFlush();
      }
    }
    //
    // private static void SeedCountries(WildcamperContext context)
    // {
    //   context.Add(new User
    //   {
    //     FirstName = "Arkadiusz",
    //     LastName = "Rasz",
    //     Login = "ar",
    //   });
    //   context.SaveChanges();
    //
    //   context.Place.Add(new Place
    //   {
    //     CreatorId = context.User.First().UserId,
    //     Description = "dsahj",
    //     Latitude = 51,
    //     Longitude = 17,
    //     Name = "Place1"
    //   });
    //   context.SaveChanges();
    //
    //   context.Image.Add(new Image
    //   {
    //     CreatorId = context.User.First().UserId,
    //     PlaceId = context.Place.First().PlaceId,
    //     Bytes = File.ReadAllBytes("Temp/1.jpg")
    //   });
    //
    //   context.SaveChanges();
    // }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
      Host.CreateDefaultBuilder(args)
          .ConfigureWebHostDefaults(webBuilder =>
          {
            webBuilder
              .UseKestrel()
              .UseSerilog()
              .UseUrls("https://localhost:44310", "https://192.168.0.103:44310", "https://pc-arkadr:44310")
              .UseStartup<Startup>();
          });
  }
}
