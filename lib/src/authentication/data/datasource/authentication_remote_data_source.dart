import 'dart:convert';

import 'package:tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/constrants.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});
  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/users';
const kGetUserEndpoint = '/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);
  final http.Client _client;
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    //1. check to make sure that it return the right data when the status
    //code is 200 or the proper response code
    //2. check to make sure that it "Throw a custom exception" with the
    //right message when status code is the bad one
    // final response =
    await _client.post(
      Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
      body:
          jsonEncode({'createdAt': createdAt, 'name': name, 'avatar': avatar}),
    );
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
