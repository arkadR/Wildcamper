﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Wildcamper.API.Models;

namespace Wildcamper.API.Migrations
{
    [DbContext(typeof(WildcamperContext))]
    partial class WildcamperContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "3.1.9")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("Wildcamper.API.Models.Image", b =>
                {
                    b.Property<int>("ImageId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime?>("AddedDate")
                        .HasColumnType("date");

                    b.Property<byte[]>("Bytes")
                        .HasColumnType("varbinary(max)");

                    b.Property<int?>("CreatorId")
                        .HasColumnType("int");

                    b.Property<int>("PlaceId")
                        .HasColumnType("int");

                    b.HasKey("ImageId");

                    b.HasIndex("CreatorId");

                    b.HasIndex("PlaceId");

                    b.ToTable("Image");
                });

            modelBuilder.Entity("Wildcamper.API.Models.Place", b =>
                {
                    b.Property<int>("PlaceId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("CreatorId")
                        .HasColumnType("int");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(500)")
                        .HasMaxLength(500);

                    b.Property<decimal>("Latitude")
                        .HasColumnType("decimal(8, 6)");

                    b.Property<decimal>("Longitude")
                        .HasColumnType("decimal(9, 6)");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(50)")
                        .HasMaxLength(50);

                    b.HasKey("PlaceId");

                    b.HasIndex("CreatorId");

                    b.ToTable("Place");
                });

            modelBuilder.Entity("Wildcamper.API.Models.Rating", b =>
                {
                    b.Property<int>("RatingId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Comment")
                        .HasColumnType("nvarchar(500)")
                        .HasMaxLength(500);

                    b.Property<int>("CreatorId")
                        .HasColumnType("int");

                    b.Property<int>("PlaceId")
                        .HasColumnType("int");

                    b.Property<int>("Stars")
                        .HasColumnType("int");

                    b.HasKey("RatingId");

                    b.HasIndex("CreatorId");

                    b.HasIndex("PlaceId");

                    b.ToTable("Rating");
                });

            modelBuilder.Entity("Wildcamper.API.Models.User", b =>
                {
                    b.Property<int>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("FirstName")
                        .HasColumnType("varchar(50)")
                        .HasMaxLength(50)
                        .IsUnicode(false);

                    b.Property<string>("LastName")
                        .HasColumnType("varchar(50)")
                        .HasMaxLength(50)
                        .IsUnicode(false);

                    b.Property<string>("Login")
                        .HasColumnType("varchar(50)")
                        .HasMaxLength(50)
                        .IsUnicode(false);

                    b.HasKey("UserId");

                    b.ToTable("User");
                });

            modelBuilder.Entity("Wildcamper.API.Models.Image", b =>
                {
                    b.HasOne("Wildcamper.API.Models.User", "Creator")
                        .WithMany("Image")
                        .HasForeignKey("CreatorId")
                        .HasConstraintName("FK_Image_CreatorId_User_UserId");

                    b.HasOne("Wildcamper.API.Models.Place", "Place")
                        .WithMany("Images")
                        .HasForeignKey("PlaceId")
                        .HasConstraintName("FK_Image_PlaceId_Place_PlaceId")
                        .IsRequired();
                });

            modelBuilder.Entity("Wildcamper.API.Models.Place", b =>
                {
                    b.HasOne("Wildcamper.API.Models.User", "Creator")
                        .WithMany("Place")
                        .HasForeignKey("CreatorId")
                        .HasConstraintName("FK_Place_CreatorId_User_UserId")
                        .IsRequired();
                });

            modelBuilder.Entity("Wildcamper.API.Models.Rating", b =>
                {
                    b.HasOne("Wildcamper.API.Models.User", "Creator")
                        .WithMany("Rating")
                        .HasForeignKey("CreatorId")
                        .HasConstraintName("FK_Rating_CreatorId_User_UserId")
                        .IsRequired();

                    b.HasOne("Wildcamper.API.Models.Place", "Place")
                        .WithMany("Ratings")
                        .HasForeignKey("PlaceId")
                        .HasConstraintName("FK_Rating_PlaceId_Place_PlaceId")
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
