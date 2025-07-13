import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';

void main() {
  group('MyFundModel', () {
    const testId = 'test-id';
    const testName = 'Test Fund';
    const testAmountMin = '1000';
    const testCategory = 'Technology';
    const testInvestment = '5000';
    const testNotificationWay = NotificationWay.email;

    test('should create a MyFundModel with all required parameters', () {
      // Arrange & Act
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: testNotificationWay,
      );

      // Assert
      expect(myFundModel.id, equals(testId));
      expect(myFundModel.name, equals(testName));
      expect(myFundModel.amountMin, equals(testAmountMin));
      expect(myFundModel.category, equals(testCategory));
      expect(myFundModel.investment, equals(testInvestment));
      expect(myFundModel.notificationWay, equals(testNotificationWay));
    });

    test('should extend FundModel', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(myFundModel, isA<MyFundModel>());
      expect(myFundModel, isA<FundModel>());
    });

    test('should have correct investment property', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(myFundModel.investment, isA<String>());
      expect(myFundModel.investment, equals(testInvestment));
    });

    test('should have correct notificationWay property', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(myFundModel.notificationWay, isA<NotificationWay>());
      expect(myFundModel.notificationWay, equals(testNotificationWay));
    });

    test('should work with SMS notification way', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: NotificationWay.sms,
      );

      // Act & Assert
      expect(myFundModel.notificationWay, equals(NotificationWay.sms));
    });

    test('should work with email notification way', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: NotificationWay.email,
      );

      // Act & Assert
      expect(myFundModel.notificationWay, equals(NotificationWay.email));
    });

    test('should handle empty investment string', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: '',
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(myFundModel.investment, equals(''));
    });

    test('should handle numeric investment string', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: '12345',
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(myFundModel.investment, equals('12345'));
    });

    test('should inherit FundModel properties correctly', () {
      // Arrange
      final myFundModel = MyFundModel(
        id: testId,
        name: testName,
        amountMin: testAmountMin,
        category: testCategory,
        investment: testInvestment,
        notificationWay: testNotificationWay,
      );

      // Act & Assert
      expect(myFundModel.id, equals(testId));
      expect(myFundModel.name, equals(testName));
      expect(myFundModel.amountMin, equals(testAmountMin));
      expect(myFundModel.category, equals(testCategory));
    });

    test('should have different instances with different values', () {
      // Arrange
      final myFundModel1 = MyFundModel(
        id: 'id1',
        name: 'Fund 1',
        amountMin: '1000',
        category: 'Tech',
        investment: '5000',
        notificationWay: NotificationWay.email,
      );

      final myFundModel2 = MyFundModel(
        id: 'id2',
        name: 'Fund 2',
        amountMin: '2000',
        category: 'Finance',
        investment: '10000',
        notificationWay: NotificationWay.sms,
      );

      // Act & Assert
      expect(myFundModel1.id, isNot(equals(myFundModel2.id)));
      expect(myFundModel1.name, isNot(equals(myFundModel2.name)));
      expect(myFundModel1.investment, isNot(equals(myFundModel2.investment)));
      expect(myFundModel1.notificationWay,
          isNot(equals(myFundModel2.notificationWay)));
    });
  });
}
