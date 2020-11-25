using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Wildcamper.API.Migrations
{
    public partial class AddedThumbnail : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "Thumbnail",
                table: "Place",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Thumbnail",
                table: "Place");
        }
    }
}
