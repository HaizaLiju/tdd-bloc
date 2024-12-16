import 'package:tdd_bloc/core/utils/typedef.dart';
import 'package:tdd_bloc/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar
  });

  ResultFuture<List<User>> getUsers();
}
