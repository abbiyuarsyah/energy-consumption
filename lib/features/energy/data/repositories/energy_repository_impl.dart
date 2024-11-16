import 'package:dartz/dartz.dart';
import 'package:energy_consumption/features/energy/data/models/energy_request.dart';

import '../../../../core/enums/energy_type.dart';
import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/network_info.dart';
import '../../domain/repositories/enery_repository.dart';
import '../datasources/energy_datasource.dart';
import '../models/energy_model.dart';

class EnergyRepositoryImpl implements EnergyRepository {
  const EnergyRepositoryImpl({
    required this.networkInfo,
    required this.datasource,
  });

  final NetworkInfo networkInfo;
  final EnergyDatasource datasource;

  @override
  Future<Either<Failure, List<EnergyModel>>> getEnergy({
    required String date,
    required EnergyType type,
  }) async {
    if (await networkInfo.isConnected) {
      final result = await datasource.getEnergy(
        EnergyRequest(date: date, type: type),
      );

      return result.fold((l) => Left(ServerFailure()), (r) => Right(r));
    } else {
      return Left(NetworkFailure());
    }
  }

  // @override
  // Future<Either<Failure, List<EnergyModel>>> getEnergy({
  //   required double date,
  //   required EnergyType type,
  // }) async {
  //   if (await networkInfo.isConnected) {
  //     final result = await datasource.getWeatherForecast(
  //       WeatherForecastRequestModel(lat: "$lat", lon: "$long", q: city),
  //     );

  //     return result.fold((l) => Left(ServerFailure()), (r) => Right(r));
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }
}
