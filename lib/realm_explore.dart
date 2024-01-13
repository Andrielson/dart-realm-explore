import 'model/entities/car.dart';
import 'model/repositories/car_repository.dart';
import 'realm/car_repository.dart';
import 'realm/database.dart';

void calculate() {
  final CarRepository carRepository = CarRepositoryRealm();

  final cars = List.generate(
    100,
    (i) {
      final make = i % 2 == 0 ? 'Ford' : 'Audi';
      return Car(make: make, model: '$make #$i', miles: i * 1000);
    },
  );

  print('Inserting cars...');
  for (final car in cars) {
    carRepository.insert(car);
  }

  final transaction = carRepository.beginTransaction();
  print('Deleting cars...');
  for (final fordCar in carRepository.findByMake('Ford', transaction)) {
    carRepository.delete(fordCar, transaction);
  }
  print('Realm is in transaction? ${realm.isInTransaction}');
  print('Transaction is open? ${transaction.isOpen}');
  transaction.rollback();

  // print('Searching cars...');
  // carRepository.findByMake('Ford').forEach(print);
  print('Transaction is open? ${transaction.isOpen}');
  print('Closing Realm...');
  realm.close();

  print(realm.isClosed);
}

void teste() {
  final CarRepository carRepository = CarRepositoryRealm();

  final cars = List.generate(
    100,
    (i) {
      final make = i % 2 == 0 ? 'Ford' : 'Audi';
      return Car(make: make, model: '$make #$i', miles: i * 1000);
    },
  );

  print('Inserting cars...');
  for (final car in cars) {
    carRepository.insert(car);
  }

  carRepository.runTransaction((tx) {
    print('Deleting cars...');
    for (final fordCar in carRepository.findByMake('Ford', tx)) {
      carRepository.delete(fordCar, tx);
    }
    carRepository.rollbackTransaction(tx);
  });

  print('Searching cars...');
  carRepository.findByMake('Ford').forEach(print);
  print('Closing Realm...');
  realm.close();
}
