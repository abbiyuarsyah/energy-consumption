import 'package:energy_consumption/features/energy/data/datasources/energy_datasource.dart';
import 'package:energy_consumption/features/energy/data/repositories/energy_repository_impl.dart';
import 'package:energy_consumption/features/energy/domain/repositories/enery_repository.dart';
import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../utils/http_helper.dart';
import '../utils/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Core
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => const HttpClientHelper());

  /// Datasource
  sl.registerLazySingleton<EnergyDatasource>(
    () => EnergyDatasourceImpl(httpClient: sl()),
  );

  /// Repository
  sl.registerLazySingleton<EnergyRepository>(
    () => EnergyRepositoryImpl(networkInfo: sl(), datasource: sl()),
  );

  /// User case
  sl.registerLazySingleton(() => GetEnergy(repository: sl()));
}
