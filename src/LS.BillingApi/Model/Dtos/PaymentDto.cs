using System;
using LS.BillingApi.Model.Entities;

namespace LS.BillingApi.Model.Dtos;

public class PaymentDto
{
    public Payment Payment { get; set; }
    public PaymentDto(Payment payment)
    {
        Payment = payment;
    }
}
