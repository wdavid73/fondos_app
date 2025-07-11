import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class FormSignIn extends StatelessWidget {
  const FormSignIn({super.key});

  void _login(BuildContext context) {
    context.unfocus();
    context.read<SignInFormCubit>().onSubmit();
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
    if (state.authStatus == AuthStatus.authenticated &&
        state.errorMessage == '') {
      CustomSnackBar.showSnackBar(
        context,
        message: "Login successfully",
        icon: Icons.check_circle,
        colorIcon: ColorTheme.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInFormCubit>();
    final state = context.watch<SignInFormCubit>().state;

    return BlocListener<AuthBloc, AuthState>(
      listener: _listenerShowSnackBar,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            textFormFieldKey: Key("email_field"),
            label: "Email",
            hint: "Input your email",
            prefixIcon: Icon(Icons.email_rounded),
            onChanged: cubit.emailChanged,
            errorMessage: context.l10n.getByKey(state.email.errorMessage),
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            textFormFieldKey: Key("password_field"),
            label: "Password",
            hint: "Input your password",
            obscureText: state.isObscure,
            toggleObscure: cubit.toggleObscure,
            prefixIcon: Icon(Icons.password),
            onChanged: cubit.passwordChanged,
            errorMessage: context.l10n.getByKey(state.password.errorMessage),
          ),
          SizedBox(
            width: context.width,
            child: CustomButton(
              buttonKey: const Key("login_button"),
              label: context.l10n.login,
              icon: Icon(Icons.login_rounded),
              isLoading: false,
              onPressed: state.isPosting ? null : () => _login(context),
            ),
          )
        ],
      ),
    );
  }
}
