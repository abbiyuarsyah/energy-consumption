import 'package:dartz/dartz.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/user_case.dart';
import '../repositories/enery_repository.dart';

class DeleteCache extends UseCase<void, Object?> {
  DeleteCache({required this.repository});

  final EnergyRepository repository;

  @override
  Future<Either<Failure, void>> call(Object? params) async {
    try {
      return Right(repository.deletCachce());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
