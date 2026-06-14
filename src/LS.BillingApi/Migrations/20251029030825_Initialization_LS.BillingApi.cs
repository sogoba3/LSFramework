using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LS.BillingApi.Migrations
{
    /// <inheritdoc />
    public partial class Initialization_LSBillingApi : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "BillingAPI_Bill",
                columns: table => new
                {
                    BillID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Amount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    DueDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CurrentBillingStatus = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TenantID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BillingAPI_Bill", x => x.BillID);
                });

            migrationBuilder.CreateTable(
                name: "BillingAPI_Payment",
                columns: table => new
                {
                    PayementID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BillID = table.Column<int>(type: "int", nullable: false),
                    AmountPaid = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    PaiymentDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CurrentPaymentStatus = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BillingAPI_Payment", x => x.PayementID);
                    table.ForeignKey(
                        name: "FK_BillingAPI_Payment_BillingAPI_Bill_BillID",
                        column: x => x.BillID,
                        principalTable: "BillingAPI_Bill",
                        principalColumn: "BillID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BillingAPI_Payment_BillID",
                table: "BillingAPI_Payment",
                column: "BillID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BillingAPI_Payment");

            migrationBuilder.DropTable(
                name: "BillingAPI_Bill");
        }
    }
}
