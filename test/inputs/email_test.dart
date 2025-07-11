import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';

void main() {
  group("Email", () {
    ///
    test("Email pure is Valid", () {
      const email = Email.pure();
      expect(email.isValid, isFalse);
      expect(email.error, EmailInputError.empty);
    });

    test("Email empty is invalid", () {
      const email = Email.dirty(value: '');
      expect(email.isValid, isFalse);
      expect(email.error, EmailInputError.empty);
    });

    test("Email format invalid", () {
      const email = Email.dirty(value: "invalid_email");
      expect(email.isValid, isFalse);
      expect(email.error, EmailInputError.format);
    });

    test("Email valid", () {
      const email = Email.dirty(value: "john.mclean@examplepetstore.com");
      expect(email.isValid, isTrue);
      expect(email.error, isNull);
    });
  });
}
