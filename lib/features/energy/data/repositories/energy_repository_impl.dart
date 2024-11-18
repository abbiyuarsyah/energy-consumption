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
        final request = EnergyRequest(date: date, type: type.name);
        final localData = await localDatasoure.getEnergy(request);

        if (localData.isNotEmpty) {
          return Right(localData);
        }

        final result = await datasource.getEnergy(request);
        return result.fold((l) {
          return Left(l);
        }, (r) {
          localDatasoure.addEnergy(r, request.type);
          return Right(r);
        });
      } catch (_) {
        return Left(UnexpectedFailure());
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
        return Left(UnexpectedFailure());
      }
    }
  }

  @override
  void deletCachce() async {
    try {
      localDatasoure.deleteEnergy();
    } catch (_) {
      throw UnimplementedError();
    }
  }
}
