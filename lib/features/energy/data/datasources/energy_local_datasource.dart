import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/core/local_storage/models/energy_local_model.dart';

import '../../../../core/local_storage/local_storage.dart';
import '../models/energy_model.dart';
import '../models/energy_request.dart';
import 'package:uuid/uuid.dart';

abstract class EnergyLocalDatasource {
  Future<List<EnergyModel>> getEnergy(EnergyRequest request);
  Future<void> addEnergy(
    List<EnergyModel> energyModelList,
    EnergyType type,
  );
}

class EnergyLocalDatasourceImpl implements EnergyLocalDatasource {
  const EnergyLocalDatasourceImpl({required this.localStorage});

  final LocalStorage localStorage;

  @override
  Future<void> addEnergy(
    List<EnergyModel> energyModelList,
    EnergyType type,
  ) async {
    try {
      await localStorage.open();

      for (int i = 0; i < energyModelList.length; i++) {
        final result = await mapToLocal(energyModelList[i], type);
        localStorage.getEnergy.add(result);
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<EnergyModel>> getEnergy(EnergyRequest request) async {
    try {
      await localStorage.open();

      final result = await localStorage.getEnergy.getDataFiltered(request)
          as List<EnergyLocalModel>;
      return result.map((e) => mapToRemote(e)).toList();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  Future<EnergyLocalModel> mapToLocal(
    EnergyModel energyModel,
    EnergyType type,
  ) async {
    return EnergyLocalModel(
      id: const Uuid().v4(),
      timestamp: energyModel.timestamp ?? DateTime.now(),
      value: energyModel.value ?? 0,
      type: type.name,
    );
  }

  EnergyModel mapToRemote(EnergyLocalModel energyLocal) {
    return EnergyModel(energyLocal.timestamp, energyLocal.value);
  }
}
