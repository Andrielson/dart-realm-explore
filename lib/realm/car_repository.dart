import 'package:realm_dart/realm.dart';

import '../model/entities/car.dart';
import '../model/repositories/car_repository.dart';
import 'database.dart';
import 'schemas.dart' as schemas;

class CarRepositoryRealm
    with RealmRepository<Car>
    implements CarRepository<Transaction> {
  schemas.Car _find(String? id) {
    if (id == null) {
      throw Exception('ID should not be null!');
    }

    final car = realm.find<schemas.Car>(ObjectId.fromHexString(id));

    if (car == null) {
      throw Exception('Car not found!');
    }

    return car;
  }

  schemas.Car _update(Car model, schemas.Car car) {
    car.make = model.make;
    car.model = model.model;
    car.miles = model.miles;
    return realm.add(car, update: true);
  }

  static schemas.Car fromModel(Car model) => schemas.Car(
        model.id == null ? ObjectId() : ObjectId.fromHexString(model.id!),
        model.make,
        model: model.model,
        miles: model.miles,
      );

  static Car toModel(schemas.Car car) => Car(
        id: car.id.hexString,
        make: car.make,
        model: car.model,
        miles: car.miles,
      );

  @override
  void delete(Car car, [Transaction? _]) {
    final realmCar = _find(car.id);

    return realm.isInTransaction
        ? realm.delete(realmCar)
        : realm.write(() => realm.delete(realmCar));
  }

  @override
  Car find(String id, [Transaction? _]) => toModel(_find(id));

  @override
  Car insert(Car car, [Transaction? _]) {
    final insertedCar = realm.isInTransaction
        ? realm.add(fromModel(car))
        : realm.write(() => realm.add(fromModel(car)));
    return toModel(insertedCar);
  }

  @override
  Car update(Car car, [Transaction? _]) {
    final realmCar = _find(car.id);

    final updatedCar = realm.isInTransaction
        ? _update(car, realmCar)
        : realm.write(() => _update(car, realmCar));

    return toModel(updatedCar);
  }

  @override
  List<Car> findByMake(String make, [Transaction? _]) {
    final foundCars = realm.query<schemas.Car>('make == \$0', [make]);
    print('Found ${foundCars.length} cars!');
    return foundCars.map((car) => toModel(car)).toList();
  }
}
