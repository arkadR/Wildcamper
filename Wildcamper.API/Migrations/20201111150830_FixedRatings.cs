using Microsoft.EntityFrameworkCore.Migrations;

namespace Wildcamper.API.Migrations
{
    public partial class FixedRatings : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Ratings",
                table: "Rating");

            migrationBuilder.AddColumn<int>(
                name: "Stars",
                table: "Rating",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Stars",
                table: "Rating");

            migrationBuilder.AddColumn<int>(
                name: "Ratings",
                table: "Rating",
                type: "int",
                nullable: true);
        }
    }
}
