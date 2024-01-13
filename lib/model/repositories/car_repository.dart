import '../entities/car.dart';
import '../repository.dart';

abstract class CarRepository<T> implements Repository<Car, T> {
  Car find(String id, [T? transaction]);
  Car insert(Car car, [T? transaction]);
  Car update(Car car, [T? transaction]);
  void delete(Car car, [T? transaction]);
  List<Car> findByMake(String make, [T? transaction]);
}
