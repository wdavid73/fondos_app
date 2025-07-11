import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
import './widgets/form_sign_in.dart';
import './widgets/wrapper_bloc_providers.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          alignment: Alignment.center,
          child: _LoginBody(),
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    LogoContainer(),
                    AppSpacing.sm,
                    Text(
                      context.l10n.signInAccount,
                      style: context.textTheme.titleMedium,
                    ),
                    AppSpacing.sm,
                    _ButtonsOtherSignIn(),
                    AppSpacing.sm,
                    _DividerBody(
                      text: "Or use email",
                    ),
                    AppSpacing.sm,
                    WrapperBlocProvidersAuth(child: FormSignIn()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text(
                          "${context.l10n.notHaveAccount},",
                          style: context.textTheme.labelMedium,
                        ),
                        TextButton(
                          key: Key("go_to_register_screen"),
                          onPressed: () => context.pushNamed("register"),
                          child: Text(
                            context.l10n.createOneHere,
                            style: context.textTheme.labelMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: AppTypography.semiBoldWeight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonsOtherSignIn extends StatelessWidget {
  const _ButtonsOtherSignIn();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = context.textTheme.bodyMedium?.copyWith(
      color: ColorTheme.textPrimary,
    );

    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(
        ColorTheme.backgroundLight,
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 10),
      ),
    );

    double iconSize = context.dp(3);

    return Wrap(
      children: [
        FilledButton(
          onPressed: () => CustomSnackBar.showSnackBar(context,
              message: context.l10n.comingSoon),
          style: buttonStyle,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPictureCustom(
                iconPath: 'assets/icon/icon_google.svg',
                iconSize: iconSize,
              ),
              const SizedBox(width: 10),
              Text(
                context.l10n.signInWithGoogle,
                style: textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DividerBody extends StatelessWidget {
  final String text;
  const _DividerBody({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider()),
        const SizedBox(width: 10),
        Text(text),
        const SizedBox(width: 10),
        Expanded(child: Divider()),
      ],
    );
  }
}
