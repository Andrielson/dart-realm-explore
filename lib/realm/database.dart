import 'package:realm_dart/realm.dart';

import '../model/repository.dart';
import 'schemas.dart';

final _config = Configuration.inMemory([Car.schema]);

final realm = Realm(_config);

mixin RealmRepository<E> implements Repository<E, Transaction> {
  @override
  beginTransaction() => realm.beginWrite();

  @override
  commitTransaction(Transaction transaction) => transaction.commit();

  @override
  rollbackTransaction(Transaction transaction) => transaction.rollback();

  @override
  R runTransaction<R>(R Function(Transaction transaction) callback) {
    final transaction = beginTransaction();
    try {
      final result = callback(transaction);
      if (transaction.isOpen) transaction.commit();
      return result;
    } catch (e) {
      if (transaction.isOpen) transaction.rollback();
      rethrow;
    }
  }
}
