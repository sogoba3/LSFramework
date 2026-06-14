using System;
using LS.AuthUserApi.Model.Entities;
using LS.Shared.CommonRepository;

namespace LS.AuthUserApi.Services.IServices;

public interface IAuthUserRepository : IBaseRepository<LafiyaSiraUser>
{
    Task<LafiyaSiraUser?> GetUserByPhoneNumberAsync(string phoneNumber);
}
