import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';

void main() {
  group("Password", () {
    test("Password pure is Valid", () {
      const password = Password.pure();
      expect(password.isValid, isFalse);
      expect(password.error, PasswordInputError.empty);
    });

    test("Password empty is invalid", () {
      const password = Password.dirty(value: '');
      expect(password.isValid, isFalse);
      expect(password.error, PasswordInputError.empty);
    });

    test("Password length invalid", () {
      const password = Password.dirty(value: "123");
      expect(password.isValid, isFalse);
      expect(password.error, PasswordInputError.length);
    });

    test("Password pattern invalid", () {
      const password = Password.dirty(value: "ABC123456");
      expect(password.isValid, isFalse);
      expect(password.error, PasswordInputError.pattern);
    });
  });
}
