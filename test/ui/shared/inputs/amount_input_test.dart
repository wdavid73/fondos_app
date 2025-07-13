import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/ui/shared/inputs/amount_input.dart';

void main() {
  group('AmountInput', () {
    group('pure constructor', () {
      test('should create pure AmountInput without minimum', () {
        // Arrange & Act
        const amountInput = AmountInput.pure();

        // Assert
        expect(amountInput.value, equals(''));
        expect(amountInput.isPure, isTrue);
        expect(amountInput.isValid, isFalse);
        expect(amountInput.errorMessage, isNull);
        expect(amountInput.minimumAllowed, isNull);
      });

      test('should create pure AmountInput with minimum', () {
        // Arrange & Act
        const amountInput = AmountInput.pure(minimumAllowed: 1000.0);

        // Assert
        expect(amountInput.value, equals(''));
        expect(amountInput.isPure, isTrue);
        expect(amountInput.isValid, isFalse);
        expect(amountInput.errorMessage, isNull);
        expect(amountInput.minimumAllowed, equals(1000.0));
      });
    });

    group('dirty constructor', () {
      test('should create dirty AmountInput without minimum', () {
        // Arrange & Act
        const amountInput = AmountInput.dirty('5000');

        // Assert
        expect(amountInput.value, equals('5000'));
        expect(amountInput.isPure, isFalse);
        expect(amountInput.isValid, isTrue);
        expect(amountInput.errorMessage, isNull);
        expect(amountInput.minimumAllowed, isNull);
      });

      test('should create dirty AmountInput with minimum', () {
        // Arrange & Act
        const amountInput = AmountInput.dirty('5000', minimumAllowed: 1000.0);

        // Assert
        expect(amountInput.value, equals('5000'));
        expect(amountInput.isPure, isFalse);
        expect(amountInput.isValid, isTrue);
        expect(amountInput.errorMessage, isNull);
        expect(amountInput.minimumAllowed, equals(1000.0));
      });
    });

    group('validation', () {
      test('should return null for valid numeric input', () {
        // Arrange
        const amountInput = AmountInput.dirty('5000');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should return empty error for empty string', () {
        // Arrange
        const amountInput = AmountInput.dirty('');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, equals(AmountValidationError.empty));
      });

      test('should return invalid error for whitespace only', () {
        // Arrange
        const amountInput = AmountInput.dirty('   ');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, equals(AmountValidationError.invalid));
      });

      test('should return invalid error for non-numeric input', () {
        // Arrange
        const amountInput = AmountInput.dirty('abc');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, equals(AmountValidationError.invalid));
      });

      test('should return invalid error for mixed alphanumeric input', () {
        // Arrange
        const amountInput = AmountInput.dirty('123abc');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, equals(AmountValidationError.invalid));
      });

      test('should handle dots in input', () {
        // Arrange
        const amountInput = AmountInput.dirty('1.000');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle commas in input', () {
        // Arrange
        const amountInput = AmountInput.dirty('1,000');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle dots and commas together', () {
        // Arrange
        const amountInput = AmountInput.dirty('1.000,50');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should return belowMinimum error when below minimum', () {
        // Arrange
        const amountInput = AmountInput.dirty('500', minimumAllowed: 1000.0);

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, equals(AmountValidationError.belowMinimum));
      });

      test('should return null when equal to minimum', () {
        // Arrange
        const amountInput = AmountInput.dirty('1000', minimumAllowed: 1000.0);

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should return null when above minimum', () {
        // Arrange
        const amountInput = AmountInput.dirty('1500', minimumAllowed: 1000.0);

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle zero value with minimum', () {
        // Arrange
        const amountInput = AmountInput.dirty('0', minimumAllowed: 1000.0);

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, equals(AmountValidationError.belowMinimum));
      });

      test('should handle negative values', () {
        // Arrange
        const amountInput = AmountInput.dirty('-100');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });
    });

    group('errorMessage', () {
      test('should return null for valid input', () {
        // Arrange
        const amountInput = AmountInput.dirty('5000');

        // Act
        final errorMessage = amountInput.errorMessage;

        // Assert
        expect(errorMessage, isNull);
      });

      test('should return null for pure input', () {
        // Arrange
        const amountInput = AmountInput.pure();

        // Act
        final errorMessage = amountInput.errorMessage;

        // Assert
        expect(errorMessage, isNull);
      });

      test('should return error message for empty input', () {
        // Arrange
        const amountInput = AmountInput.dirty('');

        // Act
        final errorMessage = amountInput.errorMessage;

        // Assert
        expect(errorMessage, equals('is_required'));
      });

      test('should return error message for invalid input', () {
        // Arrange
        const amountInput = AmountInput.dirty('abc');

        // Act
        final errorMessage = amountInput.errorMessage;

        // Assert
        expect(errorMessage, equals('is_invalid'));
      });

      test('should return error message for below minimum input', () {
        // Arrange
        const amountInput = AmountInput.dirty('500', minimumAllowed: 1000.0);

        // Act
        final errorMessage = amountInput.errorMessage;

        // Assert
        expect(errorMessage, equals('is_below_minimum'));
      });
    });

    group('edge cases', () {
      test('should handle very large numbers', () {
        // Arrange
        const amountInput = AmountInput.dirty('999999999999');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle single digit', () {
        // Arrange
        const amountInput = AmountInput.dirty('5');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle multiple dots and commas', () {
        // Arrange
        const amountInput = AmountInput.dirty('1.000.000,50');

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle minimum of zero', () {
        // Arrange
        const amountInput = AmountInput.dirty('100', minimumAllowed: 0.0);

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle minimum of zero with zero input', () {
        // Arrange
        const amountInput = AmountInput.dirty('0', minimumAllowed: 0.0);

        // Act
        final error = amountInput.displayError;

        // Assert
        expect(error, isNull);
      });
    });

    group('AmountValidationError', () {
      test('should have correct error messages', () {
        // Assert
        expect(AmountValidationError.empty.message, equals('is_required'));
        expect(AmountValidationError.invalid.message, equals('is_invalid'));
        expect(AmountValidationError.belowMinimum.message,
            equals('is_below_minimum'));
      });
    });
  });
}
