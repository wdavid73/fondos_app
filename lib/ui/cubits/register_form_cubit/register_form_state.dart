part of 'register_form_cubit.dart';

/// Represents the state of the sign-in form.
///
/// This class holds the current values of the email and password fields,
/// the form's validity, whether the form has been posted, whether a
/// submission is in progress, and whether the password is obscured.
class RegisterFormState extends Equatable {
  /// The current email value.
  final Email email;

  /// The current password value.
  final Password password;

  /// The current confirm password value.
  final ConfirmPassword confirmPassword;

  /// The current fullName value.
  final TextInput fullName;

  /// Whether the form is currently valid.
  final bool isValid;

  /// Whether the form has been posted (submitted).
  final bool isFormPosted;

  /// Whether a form submission is currently in progress.
  final bool isPosting;

  /// Whether the password field is obscured.
  final bool isObscure;

  /// Creates a [RegisterFormState] instance.
  ///
  /// Parameters:
  ///   - [email]: The current email value. Defaults to [Email.pure()].
  ///   - [password]: The current password value. Defaults to [Password.pure()].
  ///   - [confirmPassword]: The current confirm password value. Defaults to [ConfirmPassword.pure()].
  ///   - [fullName]: The current fullName value. Defaults to [Text.pure()].
  ///   - [isValid]: Whether the form is currently valid. Defaults to `false`.
  ///   - [isFormPosted]: Whether the form has been posted. Defaults to `false`.
  ///   - [isPosting]: Whether a form submission is in progress. Defaults to `false`.
  ///   - [isObscure]: Whether the password field is obscured. Defaults to `true`.
  const RegisterFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.fullName = const TextInput.pure(),
    this.isValid = false,
    this.isFormPosted = false,
    this.isPosting = false,
    this.isObscure = true,
  });

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        fullName,
        isValid,
        isFormPosted,
        isPosting,
        isObscure,
      ];

  /// Creates a new [RegisterFormState] instance with some properties changed.
  ///
  /// This method is useful for creating a new state based on the current one,
  /// with only a few properties modified.
  ///
  /// Parameters:
  ///   - [email]: The new email value. If null, the current email is used.
  ///   - [password]: The new password value. If null, the current password is used.
  ///   - [confirmPassword]: The new confirm password value. If null, the current confirm password is used.
  ///   - [fullName]: The new fullName value. If null, the current fullName is used.
  ///   - [isValid]: The new form validity. If null, the current validity is used.
  ///   - [isFormPosted]: The new form posted status. If null, the current status is used.
  ///   - [isPosting]: The new posting status. If null, the current status is used.
  ///   - [isObscure]: The new obscure status. If null, the current status is used.
  ///
  /// Returns:
  ///   - A new [RegisterFormState] instance with the specified properties changed.
  RegisterFormState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    TextInput? fullName,
    bool? isValid,
    bool? isFormPosted,
    bool? isPosting,
    bool? isObscure,
  }) =>
      RegisterFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        fullName: fullName ?? this.fullName,
        isValid: isValid ?? this.isValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        isObscure: isObscure ?? this.isObscure,
      );
}
