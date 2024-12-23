import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());
  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String id,
    required String username,
    required String email,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParams(id: id, username: username, email: email));

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (r) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
