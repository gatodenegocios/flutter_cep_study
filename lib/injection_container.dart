import 'package:flutter_cep_study/core/network/network_info.dart';
import 'package:flutter_cep_study/core/utils/input_validator.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_local_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/repositories/adress_repository_impl.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/repositories/address_by_cep_repository.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/bloc/address_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/adress_by_cep/data/datasources/address_remote_data_source.dart';
import 'features/adress_by_cep/domain/usecases/get_address_by_cep.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Address

  // Bloc
  sl.registerFactory(
    () => AddressBloc(
      getAddress: sl(),
      validator: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => GetAddressByCep(sl()));

  // Repository

  sl.registerLazySingleton<AddressByCepRepository>(
    () => AddressRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data source 
  sl.registerLazySingleton<AddressRemoteDataSource>(() => AddressRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AddressLocalDataSource>(() => AddressLocalDataSourceImpl(sharedPreferences: sl()));

  //! core
  sl.registerLazySingleton(() => InputValidator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  //sl.registerLazySingleton(() => DataConnectionChecker());

}
