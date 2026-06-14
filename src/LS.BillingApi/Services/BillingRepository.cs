using System;
using LS.BillingApi.Data;
using LS.BillingApi.Model.Entities;
using LS.BillingApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;

namespace LS.BillingApi.Services;

public class BillingRepository : BaseRepository<Bill>, IBillingRepository
{
    private readonly BillingDbContext _billingDbContext;
    private readonly int _tenantId;
    private ResultDto _result;
    
    public BillingRepository(BillingDbContext billingDbContext, ITenantProvider tenantProvider) : base(billingDbContext, tenantProvider)
    {
        _billingDbContext = billingDbContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }
}
