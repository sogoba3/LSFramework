using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LS.AppointmentApi.Migrations
{
    /// <inheritdoc />
    public partial class Initialization_LSAppointmentApi : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AppointmentAPI_Appointment",
                columns: table => new
                {
                    AppointmentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PatientId = table.Column<int>(type: "int", nullable: false),
                    DoctorId = table.Column<int>(type: "int", nullable: false),
                    ScheduledDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CurrentAppointmentState = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    VisitStatus = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TenantID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AppointmentAPI_Appointment", x => x.AppointmentID);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AppointmentAPI_Appointment");
        }
    }
}
