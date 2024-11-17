import 'package:energy_consumption/core/local_storage/repositories/energy_local_repository.dart';

import 'repositories/repository.dart';

abstract class LocalStorage {
  Repository get getEnergy;
  clear();
  open();
  close();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl({required this.energyLocalRepository});

  final EnergyLocalRepository energyLocalRepository;

  @override
  clear() async {
    // final se = await getEnergy.getDataFiltered();
    // for (var element in se) {
    //   getEnergy.delete(element);
    // }
  }

  @override
  open() async {
    await getEnergy.open();
  }

  @override
  close() async {
    await getEnergy.close();
  }

  @override
  EnergyLocalRepository get getEnergy => energyLocalRepository;
}
