import 'package:dartz/dartz.dart';
import 'package:tdd_bloc/core/errors/exceptions.dart';
import 'package:tdd_bloc/core/errors/failure.dart';
import 'package:tdd_bloc/core/utils/typedef.dart';
import 'package:tdd_bloc/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:tdd_bloc/src/authentication/domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoriesImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoriesImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String id,
      required String username,
      required String email}) async {
    // Test - Driven Development
    // call the remote data source
    // check if method return the proper data
    // // check if when the remoteDataSource throws an exception, we return a
    // failure and if it doesn't throw and exception, we return the actual

    try {
      await _remoteDataSource.createUser(
          id: id, username: username, email: email);
      return Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
