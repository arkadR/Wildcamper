using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Wildcamper.API.Migrations
{
    public partial class AddedStaticData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "PlaceType",
                columns: new[] { "PlaceTypeId", "CreatedDate", "Icon", "ModifiedDate", "Name" },
                values: new object[] { 1, new DateTime(2020, 11, 24, 12, 32, 40, 431, DateTimeKind.Local).AddTicks(334), null, new DateTime(2020, 11, 24, 12, 32, 40, 436, DateTimeKind.Local).AddTicks(7983), "Campsite" });

            migrationBuilder.InsertData(
                table: "PlaceType",
                columns: new[] { "PlaceTypeId", "CreatedDate", "Icon", "ModifiedDate", "Name" },
                values: new object[] { 2, new DateTime(2020, 11, 24, 12, 32, 40, 437, DateTimeKind.Local).AddTicks(330), null, new DateTime(2020, 11, 24, 12, 32, 40, 437, DateTimeKind.Local).AddTicks(394), "Wild camping spot" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "PlaceType",
                keyColumn: "PlaceTypeId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PlaceType",
                keyColumn: "PlaceTypeId",
                keyValue: 2);
        }
    }
}
