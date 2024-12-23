import 'dart:convert';
import 'package:tdd_bloc/core/utils/typedef.dart';
import 'package:tdd_bloc/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
  });

  const UserModel.empty()
      : this(
          id: '1',
          username: '_empty.username',
          email: '_empty.email',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          username: map['username'] as String,
          email: map['email'] as String,
        );

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
  }) {
    return UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email);
  }

  DataMap toMap() => {
        'id': id,
        'username': username,
        'email': email,
      };

  String toJson() => jsonEncode(toMap());
}
