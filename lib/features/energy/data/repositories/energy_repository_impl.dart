import 'package:dartz/dartz.dart';
import 'package:energy_consumption/features/energy/data/models/energy_request.dart';

import '../../../../core/enums/energy_type.dart';
import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/network_info.dart';
import '../../domain/repositories/enery_repository.dart';
import '../datasources/energy_local_datasource.dart';
import '../datasources/energy_remote_datasource.dart';
import '../models/energy_model.dart';

class EnergyRepositoryImpl implements EnergyRepository {
  const EnergyRepositoryImpl({
    required this.networkInfo,
    required this.datasource,
    required this.localDatasoure,
  });

  final NetworkInfo networkInfo;
  final EnergyRemoteDatasource datasource;
  final EnergyLocalDatasource localDatasoure;

  @override
  Future<Either<Failure, List<EnergyModel>>> getEnergy({
    required String date,
    required EnergyType type,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        List<EnergyModel> list = [];
        final request = EnergyRequest(date: date, type: type.name);

        final localData = await localDatasoure.getEnergy(request);
        if (localData.length > 1) {
          return Right(localData);
        }

        final result = await datasource.getEnergy(request);
        result.fold((l) {
          return Left(ServerFailure());
        }, (r) {
          localDatasoure.addEnergy(r, request.type);
          list = r;
        });

        return Right(list);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDatasoure.getEnergy(
          EnergyRequest(date: date, type: type.name),
        );

        if (localData.isNotEmpty) {
          return Right(localData);
        } else {
          return Left(NetworkFailure());
        }
      } catch (_) {
        return Left(GetEnergyLocalFailure());
      }
    }
  }
}
