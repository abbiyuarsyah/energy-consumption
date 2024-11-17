abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T> add(T entity);
  Future<void> delete(T entity);
}
