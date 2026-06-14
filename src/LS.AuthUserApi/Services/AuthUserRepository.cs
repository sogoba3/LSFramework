using System;
using LS.AuthUserApi.Data;
using LS.AuthUserApi.Model.Entities;
using LS.AuthUserApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace LS.AuthUserApi.Services;

public class AuthUserRepository : BaseRepository<LafiyaSiraUser>, IAuthUserRepository
{
    private readonly AuthUserDbContext _authUserDbContext;
    private readonly int _tenantId;
    private ResultDto _result;

    public AuthUserRepository(AuthUserDbContext authUserDbContext, ITenantProvider tenantProvider) : base(authUserDbContext, tenantProvider)
    {
        _authUserDbContext = authUserDbContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }
    
    // New constructor for background workers
    //Used by SQS subscribers
    // public AuthUserRepository(AuthUserDbContext authUserDbContext, int tenantId)
    //     : base(authUserDbContext)
    // {
    //     _authUserDbContext = authUserDbContext;
    //     _result = new ResultDto();
    //     _tenantId = tenantId;
    // }


    public async Task<LafiyaSiraUser?> GetUserByPhoneNumberAsync(string phoneNumber)
    {
        return await _authUserDbContext.LafiyaSiraUsers.Where(p => p.TenantID == _tenantId && p.PhoneNumber == phoneNumber).FirstOrDefaultAsync();
    }
    
}
