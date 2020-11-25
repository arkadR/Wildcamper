using System.Text.Json;
using Microsoft.AspNet.OData.Builder;
using Microsoft.AspNet.OData.Extensions;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OData.Edm;
using Newtonsoft.Json.Serialization;
using Serilog;
using Wildcamper.API.Models;

namespace Wildcamper.API
{
  public class Startup
  {
    public Startup(IConfiguration configuration)
    {
      Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
      services.AddControllers()
        // .AddNewtonsoftJson(opts =>
        // {
        //   opts.SerializerSettings.
        // })
        // .AddJsonOptions(opts =>
        // {
        //   opts.JsonSerializerOptions.PropertyNameCaseInsensitive = true;
        //   opts.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
        // });
        .AddNewtonsoftJson(options =>
        {
          options.SerializerSettings.ContractResolver = new DefaultContractResolver();
        });

      services.AddDbContext<WildcamperContext>(options =>
        options.UseSqlServer(
          Configuration.GetConnectionString("ApplicationDbContextConnection")));



      services.AddOData();

      // services.AddOpenApiDocument();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
      if (env.IsDevelopment())
      {
        app.UseDeveloperExceptionPage();
      }

      app.UseSerilogRequestLogging();

      app.UseHttpsRedirection();

      app.UseRouting();

      app.UseAuthorization();

      // app.UseOpenApi();
      // app.UseReDoc();

      app.UseEndpoints(endpoints =>
      {
        endpoints.MapControllers();
        endpoints.Select().Filter().OrderBy().Count().MaxTop(10).Expand();
        endpoints.EnableDependencyInjection();
        endpoints.MapODataRoute("odata", "odata", GetEdmModel());
      });
    }

    private IEdmModel GetEdmModel()
    {
      var odataBuilder = new ODataConventionModelBuilder();
      odataBuilder.EntitySet<User>("Users");
      odataBuilder.EntitySet<Place>("Places");
      odataBuilder.EntitySet<Image>("Images");
      odataBuilder.EntitySet<Rating>("Ratings");
      odataBuilder.EntitySet<PlaceType>("PlaceTypes");

      return odataBuilder.GetEdmModel();
    }
  }
}
