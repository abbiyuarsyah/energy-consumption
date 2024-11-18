import 'package:energy_consumption/core/local_storage/models/energy_local_model.dart';
import 'package:hive/hive.dart';

import '../../../features/energy/data/models/energy_request.dart';
import 'repository.dart';

class EnergyLocalRepository
    extends Repository<EnergyLocalModel, EnergyRequest> {
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
  Future<void> delete() async {
    await _box.clear();
    return;
  }

  @override
  Future<List<EnergyLocalModel>> getDataFiltered(EnergyRequest request) async {
    final requestDate = DateTime.parse(request.date);
    final filteredValues = _box.values.cast<EnergyLocalModel>().where((energy) {
      return energy.timestamp.year == requestDate.year &&
          energy.timestamp.month == requestDate.month &&
          energy.timestamp.day == requestDate.day &&
          energy.type == request.type;
    }).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return filteredValues.isEmpty ? [EnergyLocalModel.empty()] : filteredValues;
  }

  Future<void> open() async {
    _box = await _hiveInterface.openBox(EnergyLocalModel.boxName);
  }

  Future<void> close() async {
    await _box.close();
  }
}
