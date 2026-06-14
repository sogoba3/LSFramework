using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LS.PatientApi.Migrations
{
    /// <inheritdoc />
    public partial class Initialization_LSPatientApi : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PatientAPI_Patient",
                columns: table => new
                {
                    PatientID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    LafiyaSiraUserID = table.Column<int>(type: "int", nullable: true),
                    GuestID = table.Column<int>(type: "int", nullable: true),
                    FirstName = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Gender = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AssuranceMaladieObligatoire = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TenantID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatientAPI_Patient", x => x.PatientID);
                });

            migrationBuilder.CreateTable(
                name: "PatientAPI_MedicalRecord",
                columns: table => new
                {
                    MedicalRecordID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PatientId = table.Column<int>(type: "int", nullable: false),
                    Diagnosis = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatientAPI_MedicalRecord", x => x.MedicalRecordID);
                    table.ForeignKey(
                        name: "FK_PatientAPI_MedicalRecord_PatientAPI_Patient_PatientId",
                        column: x => x.PatientId,
                        principalTable: "PatientAPI_Patient",
                        principalColumn: "PatientID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PatientAPI_PatientContactInfo",
                columns: table => new
                {
                    ContactInformationId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AlternatePhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StreetAddress = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    City = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    State = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PostalCode = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Country = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    EmergencyContactName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    EmergencyContactRelationship = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    EmergencyContactPhone = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CanReceiveSms = table.Column<bool>(type: "bit", nullable: false),
                    CanReceiveEmail = table.Column<bool>(type: "bit", nullable: false),
                    PatientID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatientAPI_PatientContactInfo", x => x.ContactInformationId);
                    table.ForeignKey(
                        name: "FK_PatientAPI_PatientContactInfo_PatientAPI_Patient_PatientID",
                        column: x => x.PatientID,
                        principalTable: "PatientAPI_Patient",
                        principalColumn: "PatientID");
                });

            migrationBuilder.CreateTable(
                name: "PatientAPI_LabResult",
                columns: table => new
                {
                    LabResultID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PatientID = table.Column<int>(type: "int", nullable: false),
                    TestName = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    ResultSummary = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    FilePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    MedicalRecordID = table.Column<int>(type: "int", nullable: true),
                    TenantID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatientAPI_LabResult", x => x.LabResultID);
                    table.ForeignKey(
                        name: "FK_PatientAPI_LabResult_PatientAPI_MedicalRecord_MedicalRecordID",
                        column: x => x.MedicalRecordID,
                        principalTable: "PatientAPI_MedicalRecord",
                        principalColumn: "MedicalRecordID");
                    table.ForeignKey(
                        name: "FK_PatientAPI_LabResult_PatientAPI_Patient_PatientID",
                        column: x => x.PatientID,
                        principalTable: "PatientAPI_Patient",
                        principalColumn: "PatientID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PatientAPI_Prescription",
                columns: table => new
                {
                    PrescriptionID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PatientID = table.Column<int>(type: "int", nullable: false),
                    Medication = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Dosage = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Instructions = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IssuedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    MedicalRecordID = table.Column<int>(type: "int", nullable: true),
                    TenantID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatientAPI_Prescription", x => x.PrescriptionID);
                    table.ForeignKey(
                        name: "FK_PatientAPI_Prescription_PatientAPI_MedicalRecord_MedicalRecordID",
                        column: x => x.MedicalRecordID,
                        principalTable: "PatientAPI_MedicalRecord",
                        principalColumn: "MedicalRecordID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_PatientAPI_LabResult_MedicalRecordID",
                table: "PatientAPI_LabResult",
                column: "MedicalRecordID");

            migrationBuilder.CreateIndex(
                name: "IX_PatientAPI_LabResult_PatientID",
                table: "PatientAPI_LabResult",
                column: "PatientID");

            migrationBuilder.CreateIndex(
                name: "IX_PatientAPI_MedicalRecord_PatientId",
                table: "PatientAPI_MedicalRecord",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_PatientAPI_PatientContactInfo_PatientID",
                table: "PatientAPI_PatientContactInfo",
                column: "PatientID",
                unique: true,
                filter: "[PatientID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_PatientAPI_Prescription_MedicalRecordID",
                table: "PatientAPI_Prescription",
                column: "MedicalRecordID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PatientAPI_LabResult");

            migrationBuilder.DropTable(
                name: "PatientAPI_PatientContactInfo");

            migrationBuilder.DropTable(
                name: "PatientAPI_Prescription");

            migrationBuilder.DropTable(
                name: "PatientAPI_MedicalRecord");

            migrationBuilder.DropTable(
                name: "PatientAPI_Patient");
        }
    }
}
