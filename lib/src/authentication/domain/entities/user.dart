import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
  });

  const User.empty()
      : this(
          id: '1',
          username: '_empty.string',
          email: '_empty.string',
        );

  final String id;
  final String username;
  final String email;

  @override
  List<Object?> get props => [id, email];
}
