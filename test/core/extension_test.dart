import 'package:energy_consumption/core/extensions/date_formatter.dart';
import 'package:energy_consumption/core/extensions/double_formatter.dart';
import 'package:energy_consumption/core/extensions/error_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/utils/execptions.dart';

void main() {
  group('string extension', () {
    test('get the string of network connection error', () {
      final NetworkFailure networkFailure = NetworkFailure();

      final result = networkFailure.message;

      expect(result, tr('network_error'));
    });

    test('get http failure call', () {
      final BadRequestFailure badRequestFailure = BadRequestFailure();

      const responseCode = 400;
      final failure = responseCode.httpErrorToFailure;

      expect(failure, badRequestFailure);
    });

    test('convert watt to Kilowatt', () {
      double watt = 5000;

      expect(watt.wattsToKilowatts, 5);
    });

    test('get string from date', () {
      final date = DateTime(1994, 10, 15).getStringDate;

      expect(date, '1994-10-15');
    });

    test('get string from date for the interface', () {
      final date = DateTime(1994, 10, 15).getStringUIDate;

      expect(date, '15 Oct 1994');
    });
  });
}
