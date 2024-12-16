import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/core/errors/exceptions.dart';
import 'package:tdd_bloc/core/utils/constrants.dart';
import 'package:tdd_bloc/src/authentication/data/datasource/authentication_remote_data_source.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;
  registerFallbackValue(Uri());

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('User created successfully', 201),
      );

      final methodCall = remoteDataSource.createUser;
      expect(methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes);

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
    test(
      'should throw [APIException when the status code is not 200 or 201 ]',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );
        final methodCall = remoteDataSource.createUser;

        expect(
            () => methodCall,
            throwsA(APIException(
                message: 'Invalid email address', statusCode: 400)));
      },
    );
    verifyNoMoreInteractions(client);
  });
}