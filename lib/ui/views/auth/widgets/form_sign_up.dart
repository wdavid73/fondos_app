import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class FormSignUp extends StatelessWidget {
  const FormSignUp({super.key});

  void _register(BuildContext context) {
    context.unfocus();
    context.read<RegisterFormCubit>().onSubmit();
  }

  void _listenerShowSnackBar(BuildContext context, AuthState state) async {
    if (state.authStatus == AuthStatus.notAuthenticated &&
        state.errorMessage != '') {
      CustomSnackBar.showSnackBar(
        context,
        message: context.l10n.getByKey(state.errorMessage),
        icon: Icons.warning_rounded,
        colorIcon: ColorTheme.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterFormCubit>();
    final state = context.watch<RegisterFormCubit>().state;

    return BlocListener<AuthBloc, AuthState>(
      listener: _listenerShowSnackBar,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            textFormFieldKey: const Key("fullName_field"),
            label: context.l10n.fullnameLabel,
            hint: context.l10n.fullnameHint,
            prefixIcon: Icon(Icons.person_rounded),
            onChanged: cubit.fullNameChanged,
            errorMessage: context.l10n.getByKey(state.fullName.errorMessage),
            /* initialValue: state.fullName.value, */
          ),
          CustomTextFormField(
            textFormFieldKey: const Key("email_field"),
            label: context.l10n.emailLabel,
            hint: context.l10n.emailHint,
            prefixIcon: Icon(Icons.email_rounded),
            onChanged: cubit.emailChanged,
            errorMessage: context.l10n.getByKey(state.email.errorMessage),
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            textFormFieldKey: const Key("password_field"),
            label: context.l10n.passwordLabel,
            hint: context.l10n.passwordHint,
            prefixIcon: Icon(Icons.password),
            obscureText: state.isObscure,
            toggleObscure: cubit.toggleObscure,
            onChanged: cubit.passwordChanged,
            errorMessage: context.l10n.getByKey(state.password.errorMessage),
            /* initialValue: state.password.value, */
          ),
          CustomTextFormField(
            textFormFieldKey: const Key("confirm_password_field"),
            label: context.l10n.confirmPasswordLabel,
            hint: context.l10n.confirmPasswordHint,
            prefixIcon: Icon(Icons.password),
            obscureText: state.isObscure,
            toggleObscure: cubit.toggleObscure,
            onChanged: cubit.confirmPasswordChanged,
            errorMessage:
                context.l10n.getByKey(state.confirmPassword.errorMessage),
            /* initialValue: state.confirmPassword.value, */
          ),
          SizedBox(
            width: context.width,
            child: CustomButton(
              buttonKey: const Key("register_button"),
              label: context.l10n.signUp,
              icon: Icon(Icons.login_rounded),
              isLoading: context.select(
                (AuthBloc bloc) => bloc.state.isCreating,
              ),
              onPressed: state.isPosting ? null : () => _register(context),
            ),
          ),
        ],
      ),
    );
  }
}
