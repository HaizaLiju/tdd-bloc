import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/core/errors/exceptions.dart';
import 'package:tdd_bloc/core/errors/failure.dart';
import 'package:tdd_bloc/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:tdd_bloc/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_bloc/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  const id = 'tp.id';
  const username = 'tp.username';
  const email = 'tp.email';
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoriesImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoriesImplementation(remoteDataSource);
  });

  final tException =
      APIException(message: 'Unknown Error Occurred', statusCode: 500);

  group('createUser', () {
    test(
      'should call the [RemoteDataSource.createUser] '
      'and complete successful when call to the remote source is successful',
      () async {
        //Arrange
        when(
          () => remoteDataSource.createUser(
            id: any(named: 'id'),
            username: any(named: 'username'),
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async => Future.value());

        //Act
        final result =
            await repoImpl.createUser(id: id, username: username, email: email);

        //Assert
        expect(result, equals(const Right(null)));
        verify(() => remoteDataSource.createUser(
            id: id, username: username, email: email)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
        'should return a [APIFailure] '
        'when the call to the remote source is unsuccessful', () async {
      when(
        () => remoteDataSource.createUser(
          id: any(named: 'id'),
          username: any(named: 'username'),
          email: any(named: 'email'),
        ),
      ).thenThrow(
        tException,
      );

      final result =
          await repoImpl.createUser(id: id, username: username, email: email);

      expect(
        result,
        equals(
          Left(
            ApiFailure(
                message: tException.message, statusCode: tException.statusCode),
          ),
        ),
      );
      verify(() => remoteDataSource.createUser(
          id: id, username: username, email: email)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUser', () {
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<User>]'
      'when call to remote source is successful',
      () async {
        when(() => remoteDataSource.getUsers()).thenAnswer(
          (_) async => [],
        );

        final result = await repoImpl.getUsers();

        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [APIFailure] '
      'when the call to the remote source is unsuccessful',
      () async {
        when(() => remoteDataSource.getUsers()).thenThrow(
          tException,
        );

        final result = await repoImpl.getUsers();

        expect(result, equals(Left(ApiFailure.fromException(tException))));
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}