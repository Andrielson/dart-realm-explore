import '../entities/car.dart';
import '../repositories/car_repository.dart';

class CarService {
  final CarRepository _carRepository;

  CarService({
    required CarRepository carRepository,
  }) : _carRepository = carRepository;

  void doStuffs() {
    final car = Car(make: 'Ford', model: 'Mustang', miles: 1000);
    print(car);
    final insertedCar = _carRepository.insert(car);
    print(insertedCar);
  }
}
