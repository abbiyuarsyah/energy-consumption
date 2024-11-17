abstract class Repository<T, U> {
  Future<List<T>> getDataFiltered(U request);
  Future<T> add(T entity);
  Future<void> delete(T entity);
}
