import 'package:energy_consumption/core/utils/execptions.dart';

extension ErrorExtensions on int {
  Failure get httpErrorToFailure {
    switch (this) {
      case 400:
        return BadRequestFailure();
      case 401:
        return UnauthorizedFailure();
      case 403:
        return ForbiddenFailure();
      case 404:
        return NotFoundFailure();
      case 500:
        return InternvalServerErrorFailure();
      case 502:
        return BadGatewayFailure();
      case 503:
        return ServiceUnavailableFailure();
      case 504:
        return GatewayTimeoutFailure();
      default:
        if (this >= 400 && this < 500) {
          return ClientErrorFailure();
        } else if (this >= 500 && this < 600) {
          return ServerErrorFailure();
        } else {
          return UnexpectedFailure();
        }
    }
  }
}
