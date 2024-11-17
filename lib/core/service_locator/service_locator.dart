import 'package:energy_consumption/core/local_storage/repositories/energy_local_repository.dart';
import 'package:energy_consumption/features/energy/data/datasources/energy_remote_datasource.dart';
import 'package:energy_consumption/features/energy/data/repositories/energy_repository_impl.dart';
import 'package:energy_consumption/features/energy/domain/repositories/enery_repository.dart';
import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/energy/data/datasources/energy_local_datasource.dart';
import '../local_storage/local_storage.dart';
import '../utils/http_helper.dart';
import '../utils/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Core
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => const HttpClientHelper());

  /// Datasource
  sl.registerLazySingleton<EnergyRemoteDatasource>(
    () => EnergyDatasourceImpl(httpClient: sl()),
  );
  sl.registerLazySingleton<EnergyLocalDatasource>(
    () => EnergyLocalDatasourceImpl(localStorage: sl()),
  );

  /// Repository
  sl.registerLazySingleton<EnergyRepository>(
    () => EnergyRepositoryImpl(
      networkInfo: sl(),
      datasource: sl(),
      localDatasoure: sl(),
    ),
  );
  sl.registerSingletonAsync<EnergyLocalRepository>(() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(join(directory.path, 'local_storage'));

    return await EnergyLocalRepository.create(
      hiveInterface: Hive,
    );
  });

  /// User case
  sl.registerLazySingleton(() => GetEnergy(repository: sl()));

  /// Bloc
  sl.registerLazySingleton<EnergyBloc>(() => EnergyBloc(getEnergy: sl()));

  sl.registerSingleton<LocalStorage>(
    LocalStorageImpl(energyLocalRepository: await sl.getAsync()),
  );
}
