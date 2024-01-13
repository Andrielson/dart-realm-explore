abstract interface class DatabaseAdapter<T> {
  T beginTransaction();
  void commitTransaction(T transaction);
  void rollbackTransaction(T transaction);
  R runTransaction<R>(R Function(T) callback);
}
