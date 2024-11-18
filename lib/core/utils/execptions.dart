import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(tr('network_error'));
}

class BadRequestFailure extends Failure {
  BadRequestFailure() : super(tr('bad_request_error'));
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure() : super(tr('unauthorized_error'));
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure() : super(tr('forbidden_error'));
}

class NotFoundFailure extends Failure {
  NotFoundFailure() : super(tr('not_found_error'));
}

class BadGatewayFailure extends Failure {
  BadGatewayFailure() : super(tr('bad_gateway_error'));
}

class InternvalServerErrorFailure extends Failure {
  InternvalServerErrorFailure() : super(tr('internal_server_error'));
}

class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure() : super(tr('service_unavailable_error'));
}

class GatewayTimeoutFailure extends Failure {
  GatewayTimeoutFailure() : super(tr('gateway_timeout_error'));
}

class ClientErrorFailure extends Failure {
  ClientErrorFailure() : super(tr('client_error'));
}

class ServerErrorFailure extends Failure {
  ServerErrorFailure() : super(tr('server_error'));
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super(tr('unexpected_error'));
}

class DeleteCacheFailure extends Failure {
  DeleteCacheFailure() : super(tr('delete_cache_error'));
}
