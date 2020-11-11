using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

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

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
      if (!optionsBuilder.IsConfigured)
      {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
        optionsBuilder.UseSqlServer("Server=(localdb)\\mssqllocaldb;Database=Wildcamper;Trusted_Connection=True;");
      }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
      modelBuilder.Entity<Image>(entity =>
      {
        entity.Property(e => e.ImageId).ValueGeneratedOnAdd();

        entity.Property(e => e.AddedDate).HasColumnType("date");

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

        entity.HasOne(d => d.Creator)
                  .WithMany(p => p.Place)
                  .HasForeignKey(d => d.CreatorId)
                  .OnDelete(DeleteBehavior.ClientSetNull)
                  .HasConstraintName("FK_Place_CreatorId_User_UserId");
      });

      modelBuilder.Entity<Rating>(entity =>
      {
        entity.Property(e => e.RatingId).ValueGeneratedOnAdd();

        entity.Property(e => e.Comment).HasMaxLength(500);


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
        entity.Property(e => e.UserId).ValueGeneratedOnAdd();

        entity.Property(e => e.FirstName)
                  .HasMaxLength(50)
                  .IsUnicode(false);

        entity.Property(e => e.LastName)
                  .HasMaxLength(50)
                  .IsUnicode(false);

        entity.Property(e => e.Login)
                  .HasMaxLength(50)
                  .IsUnicode(false);
      });

      OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

  }
}
