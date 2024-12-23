import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:tdd_bloc/src/authentication/domain/entities/user.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixture('user.json');
  final List<dynamic> tList =
      jsonDecode(tJson) as List<dynamic>; // Parse as array
  final tMap = tList.first as Map<String, dynamic>; // Extract first object

  test('should be a subclass of [User] entity', () {
    // Assert
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test('should return a [UserModel] with right data', () {
      // Act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with right data', () {
      // Extract first object from JSON array and encode as string
      final singleJsonString = jsonEncode(tMap);
      // Act
      final result = UserModel.fromJson(singleJsonString);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with right data', () {
      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap)); // Compare with extracted `tMap`
    });
  });

  group('toJson', () {
    test('should return a [Json] string with right data', () {
      // Act
      final result = tModel.toJson();
      final tJson = jsonEncode(
          {"id": "1", "username": "_empty.username", "email": "_empty.email"});
      // Assert
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      //Arrange

      //Act
      final result = tModel.copyWith(username: 'Logan');
      expect(result.username, equals('Logan'));
    });
  });
}
