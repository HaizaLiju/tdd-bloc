import 'package:get_it/get_it.dart';
import 'package:tdd_bloc/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:tdd_bloc/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_bloc/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl..
    // App Logic
    registerCachedFactory(() => AuthenticationCubit(
          createUser: sl(),
          getUsers: sl(),
        ))

    //Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    //Repositories
      ..registerLazySingleton<AuthenticationRepository>(
              () => AuthenticationRepositoriesImplementation(sl()))

    //Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthRemoteDataSrcImpl(sl()))

    //External Dependencies
      ..registerLazySingleton(() => http.Client());
}
