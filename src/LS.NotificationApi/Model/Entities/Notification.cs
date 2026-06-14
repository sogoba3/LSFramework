using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.Model.Entities.Shared;
using LS.NotificationApi.Constants;

namespace LS.NotificationApi.Model.Entities;

[Table(NotificationConstant.NOTIFICATION_API + "Notification")]
public class Notification : MultiTenantEntity
{
    [Key]
    public int NotificationID { get; set; }
    [Required]
    public int LafiyaSiraID { get; set; }
    [Required,MaxLength(1000)]
    public string Message { get; set; } = string.Empty;
    [Required]
    public bool IsRead { get; set; } = false;
    [Required]
    public DateTime SentDate { get; set; } = DateTime.UtcNow;
}
