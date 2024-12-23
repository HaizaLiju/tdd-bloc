import 'package:equatable/equatable.dart';
import 'package:tdd_bloc/core/usecase/usecase.dart';
import 'package:tdd_bloc/core/utils/typedef.dart';
import 'package:tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
      id: params.id, username: params.username, email: params.email);
}

class CreateUserParams extends Equatable {
  const CreateUserParams(
      {required this.id, required this.username, required this.email});

  const CreateUserParams.empty()
      : this(
            id: '_empty.string',
            username: '_empty.string',
            email: '_empty.string');

  final String id;
  final String username;
  final String email;

  @override
  List<Object?> get props => [id, username, email];
}
