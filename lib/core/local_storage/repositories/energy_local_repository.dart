import 'package:energy_consumption/core/local_storage/models/energy_local_model.dart';
import 'package:hive/hive.dart';

import 'repository.dart';

class EnergyLocalRepository extends Repository<EnergyLocalModel> {
  EnergyLocalRepository._({required hiveInterface})
      : _hiveInterface = hiveInterface;

  final HiveInterface _hiveInterface;
  late Box _box;
  bool _initialized = false;

  static Future<EnergyLocalRepository> create({required hiveInterface}) async {
    final repo = EnergyLocalRepository._(hiveInterface: hiveInterface);

    await repo.init();
    return repo;
  }

  Future<void> init() async {
    bool isInitializing = false;
    if (_initialized == false && isInitializing == false) {
      isInitializing = true;
      _hiveInterface.registerAdapter(EnergyLocalModelAdapter());
      _initialized = true;
    }
  }

  @override
  Future<EnergyLocalModel> add(EnergyLocalModel entity) async {
    await _box.put(entity.id, entity);
    return Future.value(entity);
  }

  @override
  Future<void> delete(EnergyLocalModel entity) async {
    await _box.delete(entity.id);
    return;
  }

  @override
  Future<List<EnergyLocalModel>> getAll() async {
    final values = _box.values.toList().cast<EnergyLocalModel>();
    return values.isEmpty
        ? Future.value([EnergyLocalModel.empty()])
        : Future.value(values);
  }

  Future<void> open() async {
    _box = await _hiveInterface.openBox(EnergyLocalModel.boxName);
  }

  Future<void> close() async {
    await _box.close();
  }
}
