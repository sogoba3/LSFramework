using System;
using LS.DoctorApi.Data;
using LS.DoctorApi.Model.Entities;
using LS.DoctorApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;

namespace LS.DoctorApi.Services;

public class DoctorRepository : BaseRepository<Doctor>, IDoctorRepository
{
    private readonly DoctorDbContext _doctorDbContext;
    private readonly int _tenantId;
    private ResultDto _result;
    
    public DoctorRepository(DoctorDbContext doctorDbContext, ITenantProvider tenantProvider) : base(doctorDbContext, tenantProvider)
    {
        _doctorDbContext = doctorDbContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }
}
