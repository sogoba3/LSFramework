using System;
using LS.PatientApi.Data;
using LS.PatientApi.Model.Entities;
using LS.PatientApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;

namespace LS.PatientApi.Services;

public class PatientRepository : BaseRepository<Patient>, IPatientRepository
{
    private readonly PatientDbContext _patientDbContext;
    private readonly int _tenantId;
    private ResultDto _result;

    public PatientRepository(PatientDbContext patientDbContext, ITenantProvider tenantProvider) : base(patientDbContext, tenantProvider)
    {
        _patientDbContext = patientDbContext;
        _result = new ResultDto();
       _tenantId = tenantProvider.GetTenantId();
    }
}
