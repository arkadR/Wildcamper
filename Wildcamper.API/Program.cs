using System;
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
    
    public static IHostBuilder CreateHostBuilder(string[] args) =>
      Host.CreateDefaultBuilder(args)
          .ConfigureWebHostDefaults(webBuilder =>
          {
            webBuilder
              .UseKestrel()
              .UseSerilog()
              .UseUrls("https://localhost:44310", "https://192.168.1.27:44310", "https://pc-arkadr:44310")
              .UseStartup<Startup>();
          });
  }
}
