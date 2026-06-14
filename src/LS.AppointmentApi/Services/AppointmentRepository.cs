using System;
using LS.AppointmentApi.Data;
using LS.AppointmentApi.Model.Entities;
using LS.AppointmentApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;

namespace LS.AppointmentApi.Services;

public class AppointmentRepository : BaseRepository<Appointment>, IAppointmentRepository
{
    private readonly AppointmentDBContext _appointmentDBContext;
    private readonly int _tenantId;
    private ResultDto _result;
    
    public AppointmentRepository(AppointmentDBContext appointmentDBContext, ITenantProvider tenantProvider) : base(appointmentDBContext, tenantProvider)
    {
        _appointmentDBContext = appointmentDBContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }
}
