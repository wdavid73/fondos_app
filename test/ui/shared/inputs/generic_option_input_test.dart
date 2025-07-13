import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/ui/shared/inputs/generic_option_input.dart';

void main() {
  group('GenericOptionInput', () {
    group('pure constructor', () {
      test('should create pure GenericOptionInput with null value', () {
        // Arrange & Act
        const optionInput = GenericOptionInput<String>.pure();

        // Assert
        expect(optionInput.value, isNull);
        expect(optionInput.isPure, isTrue);
        expect(optionInput.isValid, isFalse);
        expect(optionInput.errorMessage, isNull);
      });

      test('should create pure GenericOptionInput with different types', () {
        // Arrange & Act
        const stringOption = GenericOptionInput<String>.pure();
        const intOption = GenericOptionInput<int>.pure();
        const doubleOption = GenericOptionInput<double>.pure();

        // Assert
        expect(stringOption.value, isNull);
        expect(intOption.value, isNull);
        expect(doubleOption.value, isNull);
      });
    });

    group('dirty constructor', () {
      test('should create dirty GenericOptionInput with value', () {
        // Arrange & Act
        const optionInput = GenericOptionInput<String>.dirty('test');

        // Assert
        expect(optionInput.value, equals('test'));
        expect(optionInput.isPure, isFalse);
        expect(optionInput.isValid, isTrue);
        expect(optionInput.errorMessage, isNull);
      });

      test('should create dirty GenericOptionInput with null value', () {
        // Arrange & Act
        const optionInput = GenericOptionInput<String>.dirty(null);

        // Assert
        expect(optionInput.value, isNull);
        expect(optionInput.isPure, isFalse);
        expect(optionInput.isValid, isFalse);
        expect(optionInput.errorMessage, equals('is_required'));
      });

      test('should create dirty GenericOptionInput with different types', () {
        // Arrange & Act
        const stringOption = GenericOptionInput<String>.dirty('test');
        const intOption = GenericOptionInput<int>.dirty(42);
        const doubleOption = GenericOptionInput<double>.dirty(3.14);

        // Assert
        expect(stringOption.value, equals('test'));
        expect(intOption.value, equals(42));
        expect(doubleOption.value, equals(3.14));
      });
    });

    group('validation', () {
      test('should return null for valid non-null value', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty('test');

        // Act
        final error = optionInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should return empty error for null value', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty(null);

        // Act
        final error = optionInput.displayError;

        // Assert
        expect(error, equals(OptionValidationError.empty));
      });

      test('should return null for pure input', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.pure();

        // Act
        final error = optionInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle empty string as valid value', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty('');

        // Act
        final error = optionInput.displayError;

        // Assert
        expect(error, isNull);
      });

      test('should handle zero as valid value for numeric types', () {
        // Arrange
        const intOption = GenericOptionInput<int>.dirty(0);
        const doubleOption = GenericOptionInput<double>.dirty(0.0);

        // Act
        final intError = intOption.displayError;
        final doubleError = doubleOption.displayError;

        // Assert
        expect(intError, isNull);
        expect(doubleError, isNull);
      });

      test('should handle false as valid value for boolean type', () {
        // Arrange
        const boolOption = GenericOptionInput<bool>.dirty(false);

        // Act
        final error = boolOption.displayError;

        // Assert
        expect(error, isNull);
      });
    });

    group('errorMessage', () {
      test('should return null for valid input', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty('test');

        // Act
        final errorMessage = optionInput.errorMessage;

        // Assert
        expect(errorMessage, isNull);
      });

      test('should return null for pure input', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.pure();

        // Act
        final errorMessage = optionInput.errorMessage;

        // Assert
        expect(errorMessage, isNull);
      });

      test('should return error message for null input', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty(null);

        // Act
        final errorMessage = optionInput.errorMessage;

        // Assert
        expect(errorMessage, equals('is_required'));
      });
    });

    group('different types', () {
      test('should work with String type', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty('test');

        // Act & Assert
        expect(optionInput.value, isA<String>());
        expect(optionInput.isValid, isTrue);
      });

      test('should work with int type', () {
        // Arrange
        const optionInput = GenericOptionInput<int>.dirty(42);

        // Act & Assert
        expect(optionInput.value, isA<int>());
        expect(optionInput.isValid, isTrue);
      });

      test('should work with double type', () {
        // Arrange
        const optionInput = GenericOptionInput<double>.dirty(3.14);

        // Act & Assert
        expect(optionInput.value, isA<double>());
        expect(optionInput.isValid, isTrue);
      });

      test('should work with bool type', () {
        // Arrange
        const optionInput = GenericOptionInput<bool>.dirty(true);

        // Act & Assert
        expect(optionInput.value, isA<bool>());
        expect(optionInput.isValid, isTrue);
      });
    });

    group('edge cases', () {
      test('should handle very long string', () {
        // Arrange
        final longString = 'a' * 1000;
        final optionInput = GenericOptionInput<String>.dirty(longString);

        // Act & Assert
        expect(optionInput.value, equals(longString));
        expect(optionInput.isValid, isTrue);
      });

      test('should handle special characters in string', () {
        // Arrange
        const specialString = '!@#\$%^&*()_+-=[]{}|;:,.<>?';
        const optionInput = GenericOptionInput<String>.dirty(specialString);

        // Act & Assert
        expect(optionInput.value, equals(specialString));
        expect(optionInput.isValid, isTrue);
      });

      test('should handle large numbers', () {
        // Arrange
        const optionInput = GenericOptionInput<int>.dirty(999999999);

        // Act & Assert
        expect(optionInput.value, equals(999999999));
        expect(optionInput.isValid, isTrue);
      });

      test('should handle negative numbers', () {
        // Arrange
        const optionInput = GenericOptionInput<int>.dirty(-42);

        // Act & Assert
        expect(optionInput.value, equals(-42));
        expect(optionInput.isValid, isTrue);
      });

      test('should handle decimal numbers', () {
        // Arrange
        const optionInput = GenericOptionInput<double>.dirty(3.14159265359);

        // Act & Assert
        expect(optionInput.value, equals(3.14159265359));
        expect(optionInput.isValid, isTrue);
      });
    });

    group('OptionValidationError', () {
      test('should have correct error message', () {
        // Assert
        expect(OptionValidationError.empty.message, equals('is_required'));
      });

      test('should be the only validation error', () {
        // Assert
        expect(OptionValidationError.values.length, equals(1));
      });
    });

    group('formz integration', () {
      test('should extend FormzInput correctly', () {
        // Arrange
        const optionInput = GenericOptionInput<String>.dirty('test');

        // Act & Assert
        expect(optionInput, isA<GenericOptionInput<String>>());
        expect(optionInput.value, isA<String>());
        expect(optionInput.isPure, isA<bool>());
        expect(optionInput.isValid, isA<bool>());
        expect(optionInput.isNotValid, isA<bool>());
      });
    });
  });
}
