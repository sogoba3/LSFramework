using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.BillingApi.Constant;
using LS.Shared;

namespace LS.BillingApi.Model.Entities;

[Table(BillingConstant.BILLING_API + "Payment")]
public class Payment
{
    [Key]
    public int PayementID { get; set; }
    [Required]
    public int BillID { get; set; }
    [Required]
    public Bill Bill { get; set; } = null!; // Navigation property
    [Required, Column(TypeName = "decimal(18,2)")]
    public decimal AmountPaid { get; set; }
    [Required]
    public DateTime PaiymentDate { get; set; } = DateTime.UtcNow;
    [Required]
    public string CurrentPaymentStatus { get; set; } = PaymentStatus.Cash.GetDescription();
    public enum PaymentStatus
    {
        [Description("Card")]
        Card = 0,
        [Description("Cash")]
        Cash = 1,
        [Description("Insurance")]
        Insurance = 2
    }
}
