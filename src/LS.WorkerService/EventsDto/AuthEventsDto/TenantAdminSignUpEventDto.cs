using System;

namespace LS.WorkerService.EventsDto.AuthEventsDto;

public class TenantAdminSignUpEventDto
{
    public string Username { get; set; } = string.Empty;
    public string? CognitoId { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public string Gender { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public int TenantID { get; set; }
    public DateTime CreationDate { get; set; }
}
