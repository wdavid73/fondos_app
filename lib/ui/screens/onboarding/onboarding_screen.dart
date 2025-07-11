import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd() {
    getIt.get<IntroductionCubit>().markIntroductionAsSeen();
    context.goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: context.textTheme.titleLarge!.copyWith(
        color: ColorTheme.white,
      ),
      bodyTextStyle: context.textTheme.bodyLarge!.copyWith(
        color: ColorTheme.white,
      ),
    );
    return IntroductionScreen(
      key: introKey,
      onDone: () => _onIntroEnd(),
      onSkip: () => _onIntroEnd(),
      showDoneButton: true,
      showNextButton: true,
      showBackButton: true,
      showSkipButton: true,
      done: Text(
        context.l10n.done,
        style: context.textTheme.bodyLarge?.copyWith(
          color: ColorTheme.white,
        ),
      ),
      next: Icon(
        Icons.adaptive.arrow_forward,
        color: ColorTheme.white,
        size: context.dp(3),
      ),
      back: Icon(
        Icons.adaptive.arrow_back,
        color: ColorTheme.white,
        size: context.dp(3),
      ),
      skip: Text(
        context.l10n.skip,
        style: context.textTheme.bodyLarge?.copyWith(
          color: ColorTheme.white,
        ),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: ColorTheme.lightPrimaryColor,
      ),
      globalBackgroundColor: ColorTheme.primaryColor,
      pages: [
        PageViewModel(
          image: SvgPictureCustom(
            iconPath: "assets/images/introduction/startup.svg",
            iconSize: context.dp(20),
          ),
          title: "Tittle Section One",
          body: "Body Section One",
          decoration: pageDecoration,
        ),
        PageViewModel(
          image: SvgPictureCustom(
            iconPath: "assets/images/introduction/dashboard.svg",
            iconSize: context.dp(20),
          ),
          title: "Tittle Section Two",
          body: "Body Section Two",
          decoration: pageDecoration,
        ),
        PageViewModel(
          image: SvgPictureCustom(
            iconPath: "assets/images/introduction/construction.svg",
            iconSize: context.dp(20),
          ),
          title: "Tittle Section Three",
          body: "Body Section Three",
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
