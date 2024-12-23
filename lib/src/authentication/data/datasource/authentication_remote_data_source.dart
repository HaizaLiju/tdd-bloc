import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tdd_bloc/core/errors/exceptions.dart';
import 'package:tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/constrants.dart';
import '../../../../core/utils/typedef.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String id,
    required String username,
    required String email,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/api/v1/users/';
const kGetUserEndpoint = '/api/v1/users/';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String id,
    required String username,
    required String email,
  }) async {
    try {
      final response = await _client.post(
        Uri.http(kBaseUrl, kCreateUserEndpoint),
        headers: {
          'Content-Type': 'application/json', // Thêm header Content-Type
        },
        body: jsonEncode({
          'id': id,
          'username': username,
          'email': email,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.http(kBaseUrl, kGetUserEndpoint),
        headers: {
          'Content-Type': 'application/json',
          // Thêm header Content-Type nếu cần
        },
      );
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
