import 'package:energy_consumption/core/local_storage/models/energy_local_model.dart';

import '../../../../core/local_storage/local_storage.dart';
import '../models/energy_model.dart';
import '../models/energy_request.dart';
import 'package:uuid/uuid.dart';

abstract class EnergyLocalDatasource {
  Future<List<EnergyModel>> getEnergy(EnergyRequest request);
  Future<void> addEnergy(
    List<EnergyModel> energyModelList,
    String type,
  );

  void deleteEnergy();
}

class EnergyLocalDatasourceImpl implements EnergyLocalDatasource {
  const EnergyLocalDatasourceImpl({required this.localStorage});

  final LocalStorage localStorage;

  @override
  Future<void> addEnergy(
    List<EnergyModel> energyModelList,
    String type,
  ) async {
    try {
      await localStorage.open();

      for (int i = 0; i < energyModelList.length; i++) {
        final result = await mapToLocal(energyModelList[i], type);
        localStorage.getEnergyRpository.add(result);
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<EnergyModel>> getEnergy(EnergyRequest request) async {
    try {
      await localStorage.open();

      final result = await localStorage.getEnergyRpository
          .getDataFiltered(request) as List<EnergyLocalModel>;
      return result.map((e) => mapToRemote(e)).toList();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  Future<EnergyLocalModel> mapToLocal(
    EnergyModel energyModel,
    String type,
  ) async {
    return EnergyLocalModel(
      id: const Uuid().v4(),
      timestamp: energyModel.timestamp ?? DateTime.now(),
      value: energyModel.value ?? 0,
      type: type,
    );
  }

  EnergyModel mapToRemote(EnergyLocalModel energyLocal) {
    return EnergyModel(energyLocal.timestamp, energyLocal.value);
  }

  @override
  void deleteEnergy() async {
    try {
      await localStorage.open();
      await localStorage.getEnergyRpository.delete();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
