using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.BillingApi.Constant;
using LS.Model.Entities.Shared;

namespace LS.BillingApi.Model.Entities;

[Table(BillingConstant.BILLING_API + "Bill")]
public class Bill : MultiTenantEntity
{
    [Key]
    public int BillID { get; set; }
    //public int PatientID { get; set; }
    //public Patient Patient { get; set; } = null!; 
    [Required, Column(TypeName = "decimal(18,2)")]
    public decimal Amount { get; set; }
    [Required]
    public DateTime DueDate { get; set; }
    [Required]
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    // Payments linked to this bill
    public ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public string CurrentBillingStatus { get; set; } = string.Empty;
    public enum BillingStatus
    {
        [Description("Unpaid")]
        Unpaid = 0,
        [Description("Partial")]
        Partial = 1,
        [Description("Paid")]
        Paid = 2
    }
}
