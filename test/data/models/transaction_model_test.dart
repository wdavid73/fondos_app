/// {@template transaction_model_test}
/// Unit tests for the [TransactionModel] data class, which represents a transaction
/// related to an investment fund, including type, amount, date, and notificationWay.
///
/// These tests cover:
/// - Construction and property validation
/// - Handling of different transaction types and amounts
/// - Optional notificationWay property
/// - Edge cases for empty and different values
/// {@endtemplate}
import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/data/models/transaction_model.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';

void main() {
  /// {@template transaction_model_test_group}
  /// Tests for the [TransactionModel] class, covering construction, property validation, and edge cases.
  /// {@endtemplate}
  group('TransactionModel', () {
    const testType = 'investment';
    const testAmount = '5000';
    final testDate = DateTime(2024, 1, 15);
    final testFund = FundModel(
      id: 'fund-1',
      name: 'Test Fund',
      amountMin: '1000',
      category: 'Technology',
    );
    const testNotificationWay = NotificationWay.email;

    test('should create a TransactionModel with all required parameters', () {
      // Arrange & Act
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
        notificationWay: testNotificationWay,
      );

      // Assert
      expect(transactionModel.type, equals(testType));
      expect(transactionModel.fund, equals(testFund));
      expect(transactionModel.amount, equals(testAmount));
      expect(transactionModel.date, equals(testDate));
      expect(transactionModel.notificationWay, equals(testNotificationWay));
    });

    test('should create a TransactionModel without notificationWay', () {
      // Arrange & Act
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Assert
      expect(transactionModel.type, equals(testType));
      expect(transactionModel.fund, equals(testFund));
      expect(transactionModel.amount, equals(testAmount));
      expect(transactionModel.date, equals(testDate));
      expect(transactionModel.notificationWay, isNull);
    });

    test('should have correct type property', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.type, isA<String>());
      expect(transactionModel.type, equals(testType));
    });

    test('should have correct fund property', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.fund, isA<FundModel>());
      expect(transactionModel.fund, equals(testFund));
    });

    test('should have correct amount property', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.amount, isA<String>());
      expect(transactionModel.amount, equals(testAmount));
    });

    test('should have correct date property', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.date, isA<DateTime>());
      expect(transactionModel.date, equals(testDate));
    });

    test('should have correct notificationWay property when provided', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(transactionModel.notificationWay, isA<NotificationWay>());
      expect(transactionModel.notificationWay, equals(testNotificationWay));
    });

    test('should work with SMS notification way', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
        notificationWay: NotificationWay.sms,
      );

      // Act & Assert
      expect(transactionModel.notificationWay, equals(NotificationWay.sms));
    });

    test('should work with email notification way', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
        notificationWay: NotificationWay.email,
      );

      // Act & Assert
      expect(transactionModel.notificationWay, equals(NotificationWay.email));
    });

    test('should handle empty type string', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: '',
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.type, equals(''));
    });

    test('should handle empty amount string', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: '',
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.amount, equals(''));
    });

    test('should handle different transaction types', () {
      // Arrange
      final investmentTransaction = TransactionModel(
        type: 'investment',
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      final withdrawalTransaction = TransactionModel(
        type: 'withdrawal',
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(investmentTransaction.type, equals('investment'));
      expect(withdrawalTransaction.type, equals('withdrawal'));
    });

    test('should handle different amounts', () {
      // Arrange
      final smallAmountTransaction = TransactionModel(
        type: testType,
        fund: testFund,
        amount: '100',
        date: testDate,
      );

      final largeAmountTransaction = TransactionModel(
        type: testType,
        fund: testFund,
        amount: '1000000',
        date: testDate,
      );

      // Act & Assert
      expect(smallAmountTransaction.amount, equals('100'));
      expect(largeAmountTransaction.amount, equals('1000000'));
    });

    test('should handle different dates', () {
      // Arrange
      final pastDate = DateTime(2020, 1, 1);
      final futureDate = DateTime(2030, 12, 31);

      final pastTransaction = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: pastDate,
      );

      final futureTransaction = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: futureDate,
      );

      // Act & Assert
      expect(pastTransaction.date, equals(pastDate));
      expect(futureTransaction.date, equals(futureDate));
    });

    test('should have different instances with different values', () {
      // Arrange
      final transaction1 = TransactionModel(
        type: 'investment',
        fund: testFund,
        amount: '5000',
        date: DateTime(2024, 1, 15),
        notificationWay: NotificationWay.email,
      );

      final transaction2 = TransactionModel(
        type: 'withdrawal',
        fund: testFund,
        amount: '2000',
        date: DateTime(2024, 2, 20),
        notificationWay: NotificationWay.sms,
      );

      // Act & Assert
      expect(transaction1.type, isNot(equals(transaction2.type)));
      expect(transaction1.amount, isNot(equals(transaction2.amount)));
      expect(transaction1.date, isNot(equals(transaction2.date)));
      expect(transaction1.notificationWay,
          isNot(equals(transaction2.notificationWay)));
    });

    test('should handle null notificationWay correctly', () {
      // Arrange
      final transactionModel = TransactionModel(
        type: testType,
        fund: testFund,
        amount: testAmount,
        date: testDate,
      );

      // Act & Assert
      expect(transactionModel.notificationWay, isNull);
    });
  });
}
