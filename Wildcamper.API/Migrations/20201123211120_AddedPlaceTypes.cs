using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Wildcamper.API.Migrations
{
  public partial class AddedPlaceTypes : Migration
  {
    protected override void Up(MigrationBuilder migrationBuilder)
    {
      migrationBuilder.AddColumn<int>(
          name: "PlaceTypeId",
          table: "Place",
          nullable: false,
          defaultValue: 0);

      migrationBuilder.CreateTable(
          name: "PlaceType",
          columns: table => new
          {
            PlaceTypeId = table.Column<int>(nullable: false)
                  .Annotation("SqlServer:Identity", "1, 1"),
            Name = table.Column<string>(maxLength: 50, nullable: true),
            Icon = table.Column<byte[]>(nullable: true),
            CreatedDate = table.Column<DateTime>(type: "date", nullable: false),
            ModifiedDate = table.Column<DateTime>(type: "date", nullable: false)
          },
          constraints: table =>
          {
            table.PrimaryKey("PK_PlaceType", x => x.PlaceTypeId);
          });

      migrationBuilder.CreateIndex(
          name: "IX_Place_PlaceTypeId",
          table: "Place",
          column: "PlaceTypeId");

      migrationBuilder.AddForeignKey(
          name: "FK_Place_PlaceTypeId_PlaceType_PlaceTypeId",
          table: "Place",
          column: "PlaceTypeId",
          principalTable: "PlaceType",
          principalColumn: "PlaceTypeId",
          onDelete: ReferentialAction.Restrict);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
      migrationBuilder.DropForeignKey(
          name: "FK_Place_PlaceTypeId_PlaceType_PlaceTypeId",
          table: "Place");

      migrationBuilder.DropTable(
          name: "PlaceType");

      migrationBuilder.DropIndex(
          name: "IX_Place_PlaceTypeId",
          table: "Place");

      migrationBuilder.DropColumn(
          name: "PlaceTypeId",
          table: "Place");
    }
  }
}
