using System;

namespace LS.Model.Entities.Shared;

public abstract class MultiTenantEntity
{
    public int TenantID { get; set; }
}
