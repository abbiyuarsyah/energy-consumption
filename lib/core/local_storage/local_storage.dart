import 'package:energy_consumption/core/local_storage/repositories/energy_local_repository.dart';

import 'repositories/repository.dart';

abstract class LocalStorage {
  Repository get getEnergyRpository;
  open();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl({required this.energyLocalRepository});

  final EnergyLocalRepository energyLocalRepository;

  @override
  open() async {
    await getEnergyRpository.open();
  }

  @override
  EnergyLocalRepository get getEnergyRpository => energyLocalRepository;
}
