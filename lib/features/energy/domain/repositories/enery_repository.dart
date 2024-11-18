import 'package:dartz/dartz.dart';
import 'package:energy_consumption/core/enums/energy_type.dart';

import '../../../../core/utils/execptions.dart';
import '../../data/models/energy_model.dart';

abstract class EnergyRepository {
  Future<Either<Failure, List<EnergyModel>>> getEnergy({
    required String date,
    required EnergyType type,
  });

  void deletCachce();
}
