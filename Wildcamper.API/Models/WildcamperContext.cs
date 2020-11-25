using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Wildcamper.API.Models
{
  public partial class WildcamperContext : DbContext
  {
    public WildcamperContext()
    {
    }

    public WildcamperContext(DbContextOptions<WildcamperContext> options)
      : base(options)
    {
    }

    public virtual DbSet<Image> Image { get; set; }
    public virtual DbSet<Place> Place { get; set; }
    public virtual DbSet<Rating> Rating { get; set; }
    public virtual DbSet<User> User { get; set; }
    public virtual DbSet<PlaceType> PlaceType { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
      if (!optionsBuilder.IsConfigured)
      {
        optionsBuilder.UseSqlServer("Server=(localdb)\\mssqllocaldb;Database=Wildcamper;Trusted_Connection=True;");
      }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
      modelBuilder.Entity<Image>(entity =>
      {
        entity.Property(e => e.ImageId).ValueGeneratedOnAdd();

        entity.Property(e => e.CreatedDate).HasColumnType("date");
        entity.Property(e => e.ModifiedDate).HasColumnType("date");

        entity.HasOne(d => d.Creator)
          .WithMany(p => p.Image)
          .HasForeignKey(d => d.CreatorId)
          .HasConstraintName("FK_Image_CreatorId_User_UserId");

        entity.HasOne(d => d.Place)
          .WithMany(p => p.Images)
          .HasForeignKey(d => d.PlaceId)
          .OnDelete(DeleteBehavior.ClientSetNull)
          .HasConstraintName("FK_Image_PlaceId_Place_PlaceId");
      });

      modelBuilder.Entity<Place>(entity =>
      {
        entity.Property(e => e.PlaceId).ValueGeneratedOnAdd();

        entity.Property(e => e.Description).HasMaxLength(500);

        entity.Property(e => e.Latitude).HasColumnType("decimal(8, 6)");

        entity.Property(e => e.Longitude).HasColumnType("decimal(9, 6)");

        entity.Property(e => e.Name).HasMaxLength(50);

        entity.Property(e => e.CreatedDate).HasColumnType("date");
        entity.Property(e => e.ModifiedDate).HasColumnType("date");

        entity.HasOne(d => d.Creator)
          .WithMany(p => p.Place)
          .HasForeignKey(d => d.CreatorId)
          .OnDelete(DeleteBehavior.ClientSetNull)
          .HasConstraintName("FK_Place_CreatorId_User_UserId");

        entity.HasOne(d => d.PlaceType)
          .WithMany(p => p.Places)
          .HasForeignKey(d => d.PlaceTypeId)
          .OnDelete(DeleteBehavior.ClientSetNull)
          .HasConstraintName("FK_Place_PlaceTypeId_PlaceType_PlaceTypeId");
      });

      modelBuilder.Entity<Rating>(entity =>
      {
        entity.Property(e => e.RatingId).ValueGeneratedOnAdd();

        entity.Property(e => e.Comment).HasMaxLength(500);

        entity.Property(e => e.CreatedDate).HasColumnType("date");
        entity.Property(e => e.ModifiedDate).HasColumnType("date");


        entity.HasOne(d => d.Creator)
          .WithMany(p => p.Rating)
          .HasForeignKey(d => d.CreatorId)
          .OnDelete(DeleteBehavior.ClientSetNull)
          .HasConstraintName("FK_Rating_CreatorId_User_UserId");

        entity.HasOne(d => d.Place)
          .WithMany(p => p.Ratings)
          .HasForeignKey(d => d.PlaceId)
          .OnDelete(DeleteBehavior.ClientSetNull)
          .HasConstraintName("FK_Rating_PlaceId_Place_PlaceId");
      });

      modelBuilder.Entity<User>(entity =>
      {
        entity.Property(e => e.CreatedDate).HasColumnType("date");
        entity.Property(e => e.ModifiedDate).HasColumnType("date");

        entity.Property(e => e.DisplayName)
          .HasMaxLength(50)
          .IsUnicode(false);

        entity.Property(e => e.Email)
          .HasMaxLength(50)
          .IsUnicode(false);
      });

      modelBuilder.Entity<PlaceType>(entity =>
      {
        entity.Property(e => e.PlaceTypeId).ValueGeneratedOnAdd();
        entity.Property(e => e.Name).HasMaxLength(50);

        entity.Property(e => e.CreatedDate).HasColumnType("date");
        entity.Property(e => e.ModifiedDate).HasColumnType("date");

        entity.HasData(
          new PlaceType {PlaceTypeId = 1, Name = "Campsite", CreatedDate = DateTime.Now, ModifiedDate = DateTime.Now},
          new PlaceType {PlaceTypeId = 2, Name = "Wild camping spot", CreatedDate = DateTime.Now, ModifiedDate = DateTime.Now });

      });

      OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

    public override async Task<int> SaveChangesAsync(
      bool acceptAllChangesOnSuccess,
      CancellationToken cancellationToken = default
    )
    {
      OnBeforeSaving();
      return (await base.SaveChangesAsync(acceptAllChangesOnSuccess,
        cancellationToken));
    }

    private void OnBeforeSaving()
    {
      var entries = ChangeTracker.Entries();
      var utcNow = DateTime.UtcNow;

      foreach (var entry in entries)
      {
        switch (entry.State)
        {
          case EntityState.Modified:
            entry.Property("ModifiedDate").CurrentValue = utcNow;
            entry.Property("ModifiedDate").IsModified = false;
            break;
          case EntityState.Added:
            entry.Property("CreatedDate").CurrentValue = utcNow;
            entry.Property("ModifiedDate").CurrentValue = utcNow;
            break;
        }
      }
    }
  }
}
