part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent(
      {required this.id, required this.username, required this.email});

  final String id;
  final String username;
  final String email;

  @override
  List<Object> get props => [id, username, email];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
