import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/data/models/fund_model.dart';

void main() {
  group('FundModel', () {
    const testId = 'test-id';
    const testName = 'Test Fund';
    const testAmountMin = '1000';
    const testCategory = 'Technology';

    test('should create a FundModel with required parameters', () {
      // Arrange & Act
      final fundModel = FundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
      );

      // Assert
      expect(fundModel.id, equals(testId));
      expect(fundModel.name, equals(testName));
      expect(fundModel.amountMin, equals(testAmountMin));
      expect(fundModel.category, equals(testCategory));
    });

    test('should create FundModel from JSON', () {
      // Arrange
      final json = {
        'id': testId,
        'name': testName,
        'min_amount': testAmountMin,
        'category': testCategory,
      };

      // Act
      final fundModel = FundModel.fromJson(json);

      // Assert
      expect(fundModel.id, equals(testId));
      expect(fundModel.name, equals(testName));
      expect(fundModel.amountMin, equals(testAmountMin));
      expect(fundModel.category, equals(testCategory));
    });

    test('should convert FundModel to JSON', () {
      // Arrange
      final fundModel = FundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
      );

      // Act
      final json = fundModel.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], equals(testId));
      expect(json['name'], equals(testName));
      expect(json['amount_min'], equals(testAmountMin));
      expect(json['category'], equals(testCategory));
    });

    test('should handle JSON with string id', () {
      // Arrange
      final json = {
        'id': testId,
        'name': testName,
        'min_amount': testAmountMin,
        'category': testCategory,
      };

      // Act
      final fundModel = FundModel.fromJson(json);

      // Assert
      expect(fundModel.id, equals(testId));
    });

    test('should handle JSON with numeric id', () {
      // Arrange
      final json = {
        'id': 123,
        'name': testName,
        'min_amount': testAmountMin,
        'category': testCategory,
      };

      // Act
      final fundModel = FundModel.fromJson(json);

      // Assert
      expect(fundModel.id, equals('123'));
    });

    test('should implement JsonSerializable interface', () {
      // Arrange
      final fundModel = FundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
      );

      // Act & Assert
      expect(fundModel, isA<FundModel>());
      expect(fundModel.toJson(), isA<Map<String, dynamic>>());
    });

    test('should extend FundEntity', () {
      // Arrange
      final fundModel = FundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
      );

      // Act & Assert
      expect(fundModel, isA<FundModel>());
      expect(fundModel.id, isA<String>());
    });

    test('should handle empty strings in JSON', () {
      // Arrange
      final json = {
        'id': '',
        'name': '',
        'min_amount': '',
        'category': '',
      };

      // Act
      final fundModel = FundModel.fromJson(json);

      // Assert
      expect(fundModel.id, equals(''));
      expect(fundModel.name, equals(''));
      expect(fundModel.amountMin, equals(''));
      expect(fundModel.category, equals(''));
    });

    test('should handle null values in JSON by converting to string', () {
      // Arrange
      final json = {
        'id': null,
        'name': null,
        'min_amount': null,
        'category': null,
      };

      // Act & Assert
      expect(() => FundModel.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}
