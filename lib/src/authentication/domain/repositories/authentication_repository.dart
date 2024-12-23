import 'package:tdd_bloc/core/utils/typedef.dart';
import 'package:tdd_bloc/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser(
      {required String id, required String username, required String email});

  ResultFuture<List<User>> getUsers();
}
