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

                    b.Property<byte[]>("Bytes")
                        .HasColumnType("varbinary(max)");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("date");

                    b.Property<string>("CreatorId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("date");

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

                    b.Property<string>("City")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Country")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("date");

                    b.Property<string>("CreatorId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(500)")
                        .HasMaxLength(500);

                    b.Property<decimal>("Latitude")
                        .HasColumnType("decimal(8, 6)");

                    b.Property<decimal>("Longitude")
                        .HasColumnType("decimal(9, 6)");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("date");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(50)")
                        .HasMaxLength(50);

                    b.Property<int>("PlaceTypeId")
                        .HasColumnType("int");

                    b.Property<string>("Region")
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("Thumbnail")
                        .HasColumnType("varbinary(max)");

                    b.HasKey("PlaceId");

                    b.HasIndex("CreatorId");

                    b.HasIndex("PlaceTypeId");

                    b.ToTable("Place");
                });

            modelBuilder.Entity("Wildcamper.API.Models.PlaceType", b =>
                {
                    b.Property<int>("PlaceTypeId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("date");

                    b.Property<byte[]>("Icon")
                        .HasColumnType("varbinary(max)");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("date");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(50)")
                        .HasMaxLength(50);

                    b.HasKey("PlaceTypeId");

                    b.ToTable("PlaceType");

                    b.HasData(
                        new
                        {
                            PlaceTypeId = 1,
                            CreatedDate = new DateTime(2020, 11, 24, 12, 32, 40, 431, DateTimeKind.Local).AddTicks(334),
                            ModifiedDate = new DateTime(2020, 11, 24, 12, 32, 40, 436, DateTimeKind.Local).AddTicks(7983),
                            Name = "Campsite"
                        },
                        new
                        {
                            PlaceTypeId = 2,
                            CreatedDate = new DateTime(2020, 11, 24, 12, 32, 40, 437, DateTimeKind.Local).AddTicks(330),
                            ModifiedDate = new DateTime(2020, 11, 24, 12, 32, 40, 437, DateTimeKind.Local).AddTicks(394),
                            Name = "Wild camping spot"
                        });
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

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("date");

                    b.Property<string>("CreatorId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("date");

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
                    b.Property<string>("UserId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("date");

                    b.Property<string>("DisplayName")
                        .HasColumnType("varchar(50)")
                        .HasMaxLength(50)
                        .IsUnicode(false);

                    b.Property<string>("Email")
                        .HasColumnType("varchar(50)")
                        .HasMaxLength(50)
                        .IsUnicode(false);

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("date");

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
                        .HasConstraintName("FK_Place_CreatorId_User_UserId");

                    b.HasOne("Wildcamper.API.Models.PlaceType", "PlaceType")
                        .WithMany("Places")
                        .HasForeignKey("PlaceTypeId")
                        .HasConstraintName("FK_Place_PlaceTypeId_PlaceType_PlaceTypeId")
                        .IsRequired();
                });

            modelBuilder.Entity("Wildcamper.API.Models.Rating", b =>
                {
                    b.HasOne("Wildcamper.API.Models.User", "Creator")
                        .WithMany("Rating")
                        .HasForeignKey("CreatorId")
                        .HasConstraintName("FK_Rating_CreatorId_User_UserId");

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
