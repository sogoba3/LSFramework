using System;
using System.Linq.Expressions;

namespace LS.Shared.CommonRepository;

public interface IBaseRepository<T> where T : class
{
    // Get all items for current tenant
    IEnumerable<T> GetAll();

    // Get by ID
    Task<T?> GetByIdAsync(int id);

    Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate);

    // Add new item
    Task AddAsync(T entity);

    // Update existing item
    Task UpdateAsync(T entity);

    // Delete item
    Task DeleteAsync(T entity);
}
