using System;
using LS.NotificationApi.Model.Entities;
using LS.Shared.CommonRepository;

namespace LS.NotificationApi.Services.IServices;

public interface INotificationRepository : IBaseRepository<Notification>
{
    Task<IEnumerable<Notification>> GetUnreadNotificationsAsync(int lafiyaSiraId, int tenantId);
}
