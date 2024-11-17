class ServerExecption implements Exception {
  const ServerExecption();
}

abstract class Failure {}

class ServerFailure extends Failure {
  ServerFailure();
}

class NetworkFailure extends Failure {
  NetworkFailure();
}

class GetEnergyLocalFailure extends Failure {
  GetEnergyLocalFailure();
}
