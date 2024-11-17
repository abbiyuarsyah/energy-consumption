import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:energy_consumption/features/energy/data/models/energy_model.dart';
import 'package:energy_consumption/features/energy/data/models/energy_request.dart';

import '../../../../core/enums/http_method.dart';
import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/http_helper.dart';

abstract class EnergyDatasource {
  Future<Either<Exception, List<EnergyModel>>> getEnergy(EnergyRequest request);
}

class EnergyDatasourceImpl implements EnergyDatasource {
  const EnergyDatasourceImpl({required this.httpClient});

  final HttpClientHelper httpClient;

  @override
  Future<Either<Exception, List<EnergyModel>>> getEnergy(
      EnergyRequest request) async {
    try {
      final result = await httpClient.request(
        endpoint: '/monitoring',
        method: HttpMethod.get,
        queryParameters: request.toJson(),
      );

      if (result.statusCode == 200) {
        return Right(
          List<EnergyModel>.from(
            json
                .decode(result.body)
                .map((model) => EnergyModel.fromJson(model)),
          ),
        );
      } else {
        return const Left(ServerExecption());
      }
    } catch (e) {
      return const Left(ServerExecption());
    }
  }
}
