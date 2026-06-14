using System;
using LS.NotificationApi.Data;
using LS.NotificationApi.Model.Entities;
using LS.NotificationApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace LS.NotificationApi.Services;

public class NotificationRepository : BaseRepository<Notification>, INotificationRepository
{
    private readonly NotificationDbContext _notificationDbContext;
    private readonly int _tenantId;
    private ResultDto _result;

    public NotificationRepository(NotificationDbContext notificationDbContext, ITenantProvider tenantProvider) : base(notificationDbContext, tenantProvider)
    {
        _notificationDbContext = notificationDbContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }
    
    public async Task<IEnumerable<Notification>> GetUnreadNotificationsAsync(int lafiyaSiraId, int tenantId)
    {
        return await _notificationDbContext.Notifications
            .Where(n => n.LafiyaSiraID == lafiyaSiraId && n.TenantID == tenantId && !n.IsRead)
            .OrderByDescending(n => n.SentDate)
            .ToListAsync();
    }
}
