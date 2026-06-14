using System;
using LS.Shared.Model.Dtos;

namespace LS.Shared.Interfaces;

public interface IAuditLogPublisher
{
    Task PublishAuditLogEvent(AuditLogEventDto auditLogEventDto);
}
