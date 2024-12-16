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
  const createdAt = 'tp.createdAt';
  const name = 'tp.name';
  const avatar = 'tp.avatar';
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
        when(() => remoteDataSource.createUser(
                createdAt: any(named: 'createdAt'),
                name: any(named: 'name'),
                avatar: any(named: 'avatar')))
            .thenAnswer((_) async => Future.value());

        //Act
        final result = await repoImpl.createUser(
            createdAt: createdAt, name: name, avatar: avatar);

        //Assert
        expect(result, equals(const Right(null)));
        verify(() => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
        'should return a [APIFailure] '
        'when the call to the remote source is unsuccessful', () async {
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(
        tException,
      );

      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

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
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
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
