import 'package:dartz/dartz.dart';
import 'package:energy_consumption/core/utils/execptions.dart';
import 'package:energy_consumption/core/utils/http_helper.dart';
import 'package:energy_consumption/features/energy/data/datasources/energy_remote_datasource.dart';
import 'package:energy_consumption/features/energy/data/models/energy_model.dart';
import 'package:energy_consumption/features/energy/data/models/energy_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'energy_remote_datasource_test.mocks.dart';

@GenerateMocks([HttpClientHelper])
void main() {
  late HttpClientHelper clientHelper;
  late EnergyDatasourceImpl dataSource;
  late EnergyRequest energyRequest;

  setUp(() {
    clientHelper = MockHttpClientHelper();
    dataSource = EnergyDatasourceImpl(httpClient: clientHelper);
    energyRequest = const EnergyRequest(
      date: "2024-11-17",
      type: "solar",
    );
  });

  test("return the model when calling the datasource", () async {
    final energyList = [
      EnergyModel(DateTime.now(), 500),
      EnergyModel(DateTime.now().subtract(const Duration(minutes: 15)), 1000)
    ];

    when(
      dataSource.getEnergy(energyRequest),
    ).thenAnswer(
      (_) async => Future.value(Right(energyList)),
    );

    final result = await dataSource.getEnergy(energyRequest);

    result.fold(
      (l) => null,
      (r) => expect(r, energyList),
    );
  });

  test("return unexpected failure when calling the datasource", () async {
    when(
      dataSource.getEnergy(energyRequest),
    ).thenAnswer((_) async => Future.value(Left(UnexpectedFailure())));

    final result = await dataSource.getEnergy(energyRequest);

    result.fold((l) => expect(l, UnexpectedFailure()), (r) => null);
  });
}
