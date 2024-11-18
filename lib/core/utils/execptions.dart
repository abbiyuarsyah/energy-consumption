import 'package:easy_localization/easy_localization.dart';

abstract class Failure {
  late String message;
}

class NetworkFailure implements Failure {
  NetworkFailure();

  @override
  String message = tr('network_error');
}

class BadRequestFailure implements Failure {
  BadRequestFailure();

  @override
  String message = tr('bad_request_error');
}

class UnauthorizedFailure implements Failure {
  UnauthorizedFailure();

  @override
  String message = tr('unauthorized_error');
}

class ForbieddenFailure implements Failure {
  ForbieddenFailure();

  @override
  String message = tr('forbidden_error');
}

class NotFoundFailure implements Failure {
  NotFoundFailure();

  @override
  String message = tr('not_found_error');
}

class InternvalServerErrorFailure implements Failure {
  InternvalServerErrorFailure();

  @override
  String message = tr('internal_server_error');
}

class BadGatewayFailure implements Failure {
  BadGatewayFailure();

  @override
  String message = tr('bad_gateway_error');
}

class ServiceUnavailableFailure implements Failure {
  ServiceUnavailableFailure();

  @override
  String message = tr('service_unavailable_error');
}

class GatewayTimeoutFailure implements Failure {
  GatewayTimeoutFailure();

  @override
  String message = tr('gateway_timeout_error');
}

class ClientErrorFailure implements Failure {
  ClientErrorFailure();

  @override
  String message = tr('client_error');
}

class ServerErrorFailure implements Failure {
  ServerErrorFailure();

  @override
  String message = tr('server_error');
}

class UnexpectedFailure implements Failure {
  UnexpectedFailure();

  @override
  String message = tr('unexpected_error');
}

class DeleteCacheFailure implements Failure {
  DeleteCacheFailure();

  @override
  String message = tr('delete_cache_error');
}
