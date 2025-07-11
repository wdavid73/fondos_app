import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';
import 'package:flutter_starter_kit/utils/utils.dart';

part 'register_form_state.dart';

/// A Cubit for managing the state of the register form.
///
/// This class handles the logic for the register form, including validating
/// the email, full name, password, and confirm password fields, submitting the form,
/// and toggling the password visibility. It interacts with an [AuthBloc] to perform the
/// actual authentication.
class RegisterFormCubit extends Cubit<RegisterFormState> {
  /// The [AuthBloc] used to perform authentication operations.
  final AuthBloc authBloc;

  /// Creates a [RegisterFormCubit] instance.
  ///
  /// Parameters:
  ///   - [authBloc]: The [AuthBloc] used to perform authentication operations.
  RegisterFormCubit({required this.authBloc})
      : super(const RegisterFormState());

  /// Submits the register form.}
  ///
  /// This method first touches every field to mark them as dirty. If the form
  /// is not valid, it returns early. Otherwise, it sets the `isPosting` flag
  /// to true, attempts to register using the [AuthBloc], waits for the
  /// authentication status to change, and then sets the `isPosting` flag
  ///  back to false.
  void onSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    emit(state.copyWith(isPosting: true));

    authBloc.register(
      email: state.email.value,
      password: state.password.value,
      fullName: state.fullName.value,
    );

    // Wait for the authentication status to change
    await waitForState(
      stream: authBloc.stream,
      condition: (state) =>
          state.authStatus == AuthStatus.authenticated ||
          state.authStatus == AuthStatus.notAuthenticated,
    );

    emit(state.copyWith(isPosting: false));
  }

  /// Updates the email field with the given [value].
  ///
  /// This method creates a new [Email] object with the given value, updates
  /// the state with the new email, and validates the form.
  ///
  /// Parameters:
  ///   - [value]: The new email value.
  void emailChanged(String value) {
    final email = Email.dirty(value: value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate(
        [email, state.fullName, state.password],
      ),
    ));
  }

  /// Updates the full name field with the given [value].
  ///
  /// This method creates a new [Text] object with the given value, updates
  /// the state with the new full name, and validates the form.
  ///
  /// Parameters:
  ///   - [value]: The new full name value.
  void fullNameChanged(String value) {
    final fullName = TextInput.dirty(value: value);
    emit(state.copyWith(
      fullName: fullName,
      isValid: Formz.validate(
        [fullName, state.email, state.password],
      ),
    ));
  }

  /// Updates the password field with the given [value].
  ///
  /// This method creates a new [Password] object with the given value,
  /// updates the state with the new password, and validates the form.
  ///
  /// Parameters:
  ///   - [value]: The new password value.
  void passwordChanged(String value) {
    final password = Password.dirty(value: value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate(
        [password, state.email, state.fullName],
      ),
    ));
  }

  /// Updates the confirm password field with the given [value].
  ///
  /// This method creates a new [ConfirmPassword] object with the given value,
  /// updates the state with the new confirm password, and validates the form.
  ///
  /// Parameters:
  ///   - [value]:  The new confirm password value.
  void confirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPassword.dirty(
      value: value,
      password: state.password.value,
    );
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate(
        [confirmPassword, state.password, state.email, state.fullName],
      ),
    ));
  }

  /// Toggles the password visibility.
  ///
  /// This method updates the state to toggle the `isObscure` flag.
  void toggleObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  /// Touches every field in the form to mark them as dirty.
  ///
  /// This method creates new [Email], [Password], [Text], and [ConfirmPassword]
  /// objects with the current values, marks them as dirty, updates the state
  /// with the new fields, and validates the form.
  void _touchEveryField() {
    final email = Email.dirty(value: state.email.value);
    final password = Password.dirty(value: state.password.value);
    final fullName = TextInput.dirty(value: state.fullName.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: state.confirmPassword.value,
    );

    emit(state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      fullName: fullName,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([email, password, fullName, confirmPassword]),
    ));
  }
}
