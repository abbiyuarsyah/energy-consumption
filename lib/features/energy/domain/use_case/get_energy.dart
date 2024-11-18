import 'package:dartz/dartz.dart';
import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:energy_consumption/features/energy/domain/repositories/enery_repository.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/user_case.dart';

class GetEnergy extends UseCase<List<EnergyEntity>, GetEnergyParams> {
  GetEnergy({required this.repository});

  final EnergyRepository repository;

  @override
  Future<Either<Failure, List<EnergyEntity>>> call(params) async {
    final result = await repository.getEnergy(
      date: params.date,
      type: params.type,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(
        r
            .map(
              (e) => EnergyEntity(
                timestamp: e.timestamp ?? DateTime.now(),
                value: e.value ?? 0,
              ),
            )
            .toList(),
      ),
    );
  }
}

class GetEnergyParams {
  const GetEnergyParams({required this.date, required this.type});

  final String date;
  final EnergyType type;
}
