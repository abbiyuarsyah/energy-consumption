abstract class Failure {
  late String message;
}

class ServerFailure extends Failure {
  ServerFailure();
}

class NetworkFailure extends Failure {
  NetworkFailure();
}

class GetEnergyLocalFailure extends Failure {
  GetEnergyLocalFailure();
}

class BadRequestFailure implements Failure {
  BadRequestFailure();

  @override
  String message =
      'Bad Gateway: The server received an invalid response from the upstream server';
}

class UnauthorizedFailure implements Failure {
  UnauthorizedFailure();

  @override
  String message = 'Unauthorized: Access is denied due to invalid credentials';
}

class ForbieddenFailure implements Failure {
  ForbieddenFailure();

  @override
  String message = 'Unauthorized: Access is denied due to invalid credentials';
}

class NotFoundFailure implements Failure {
  NotFoundFailure();

  @override
  String message = 'Not Found: The requested resource could not be found';
}

class InternvalServerErrorFailure implements Failure {
  InternvalServerErrorFailure();

  @override
  String message =
      'Internal Server Error: An unexpected error occurred on the server.';
}

class BadGatewayFailure implements Failure {
  BadGatewayFailure();

  @override
  String message =
      'Bad Gateway: The server received an invalid response from the upstream server';
}

class ServiceUnavailableFailure implements Failure {
  ServiceUnavailableFailure();

  @override
  String message = 'Service Unavailable: The server is currently unavailable';
}

class GatewayTimeoutFailure implements Failure {
  GatewayTimeoutFailure();

  @override
  String message =
      'Gateway Timeout: The server did not receive a timely response';
}

class ClientErrorFailure implements Failure {
  ClientErrorFailure();

  @override
  String message = 'Client Error: An error occurred on the client-side';
}

class ServerErrorFailure implements Failure {
  ServerErrorFailure();

  @override
  String message = 'Server Error: An error occurred on the server-side';
}

class UnexpectedFailure implements Failure {
  UnexpectedFailure();

  @override
  String message = 'Unexpected Error: An unknown status code  was encountered';
}

class DeleteCacheFailure implements Failure {
  DeleteCacheFailure();

  @override
  String message =
      'Unexpected Error: Something is wrong of deleting local data';
}
