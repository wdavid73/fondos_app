import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';
import 'package:flutter_starter_kit/utils/utils.dart';

part 'sign_in_form_state.dart';

/// A Cubit for managing the state of the sign-in form.
///
/// This class handles the logic for the sign-in form, including validating
/// the email and password fields, submitting the form, and toggling the
/// password visibility. It interacts with an [AuthBloc] to perform the
/// actual authentication.
class SignInFormCubit extends Cubit<SignInFormState> {
  /// The [AuthBloc] used to perform authentication operations.
  final AuthBloc authBloc;

  /// Creates a [SignInFormCubit] instance.
  ///
  /// Parameters:
  ///   - [authBloc]: The [AuthBloc] used to perform authentication operations.
  SignInFormCubit({required this.authBloc}) : super(const SignInFormState());

  /// Submits the sign-in form.
  ///
  /// This method first touches every field to mark them as dirty. If the form
  /// is not valid, it returns early. Otherwise, it sets the `isPosting` flag
  /// to true, attempts to log in using the [AuthBloc], waits for the
  /// authentication status to change, and then sets the `isPosting` flag
  /// back to false.
  void onSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    emit(state.copyWith(isPosting: true));

    authBloc.login(state.email.value, state.password.value);

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
      isValid: Formz.validate([email, state.password]),
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
      isValid: Formz.validate([state.email, password]),
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
  /// This method creates new [Email] and [Password] objects with the current
  /// values, marks them as dirty, updates the state with the new fields, and
  /// validates the form.
  void _touchEveryField() {
    final email = Email.dirty(value: state.email.value);
    final password = Password.dirty(value: state.password.value);

    emit(state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    ));
  }
}
