import 'package:dartz/dartz.dart';
import 'execptions.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call(Params params);
}
