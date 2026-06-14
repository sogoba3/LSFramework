using System;
using LS.BillingApi.Model.Entities;

namespace LS.BillingApi.Model.Dtos;

public class BillDto
{
    public Bill Bill { get; set; }
    public BillDto(Bill bill)
    {
        Bill = bill;
    }
}
