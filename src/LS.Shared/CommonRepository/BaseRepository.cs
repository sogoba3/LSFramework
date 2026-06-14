using System;
using System.Linq.Expressions;
using LS.Model.Entities.Shared;
using LS.Shared.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;

namespace LS.Shared.CommonRepository;

public class BaseRepository<T> where T : MultiTenantEntity
{
    protected readonly DbContext _context;
    protected readonly DbSet<T> _dbSet;
    private readonly ITenantProvider _tenantProvider;
    private readonly ResultDto _resultDto;


    public BaseRepository(DbContext context, ITenantProvider tenantProvider)
    {
        _context = context;
        _dbSet = context.Set<T>();
        _tenantProvider = tenantProvider;
        _resultDto = new ResultDto();
    }

    
    /// <summary>
    /// Dynamically gets the current Tenant ID from either
    /// 1. The tenant provider (which could use HttpContext or a manually set value)
    /// 2. Throws if missing (to avoid accidental cross-tenant queries)
    /// </summary>
    protected int CurrentTenantId
    {
        get
        {
            var tenantId = _tenantProvider.GetTenantId();
            
            if (tenantId == 0)
                throw new UnauthorizedAccessException("Tenant ID not found or not set.");
            return tenantId;
        }
    }
        

    public IEnumerable<T> GetAll()
    {
        return _dbSet.Where(x => x.TenantID == CurrentTenantId);
    }

    public async Task<T?> GetByIdAsync(int id)
    {
        var entity = await _dbSet.FindAsync(id);
        if (entity == null || entity.TenantID != CurrentTenantId)
            return null;
        return entity;
            
    }

    public async Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate)
        {
            return await _dbSet
                .Where(e => e.TenantID == CurrentTenantId)
                .Where(predicate)
                .ToListAsync();
        }

        public async Task AddAsync(T entity)
        {
            entity.TenantID = CurrentTenantId;
            await _dbSet.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(T entity)
        {
            if (entity.TenantID != CurrentTenantId)
                throw new UnauthorizedAccessException("Cannot modify entity from another tenant.");

            _dbSet.Update(entity);
            await _context.SaveChangesAsync();
        }

    public async Task DeleteAsync(T entity)
    {
        if (entity.TenantID != CurrentTenantId)
            throw new UnauthorizedAccessException("Cannot delete entity from another tenant.");

        _dbSet.Remove(entity);
        await _context.SaveChangesAsync();
    }
        
}
