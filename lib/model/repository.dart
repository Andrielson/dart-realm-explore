import 'database.dart';

abstract interface class Repository<E, T> implements DatabaseAdapter<T> {}
