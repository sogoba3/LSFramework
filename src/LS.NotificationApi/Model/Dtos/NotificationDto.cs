using System;
using LS.NotificationApi.Model.Entities;

namespace LS.NotificationApi.Model.Dtos;

public class NotificationDto
{
    public Notification Notification { get; set; }
    public NotificationDto(Notification notification)
    {
        Notification = notification;
    }
}
