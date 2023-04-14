import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeUrl = "/";
  static const String routeName = "signUp";

  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onUsernameTap(BuildContext context) {
    context.pushNamed(UsernameScreen.routeName);
    // context.push('${UserProfileScreen.routeName}/lynn?show=likes');

    // Navigator.push(
    //   context,
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(milliseconds: 300),
    //     reverseTransitionDuration: const Duration(milliseconds: 300),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation = Tween(
    //         begin: const Offset(-1, 0),
    //         end: Offset.zero,
    //       ).animate(animation);

    //       final opacityAnimation = Tween(
    //         begin: 0.5,
    //         end: 1.0,
    //       ).animate(animation);

    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: opacityAnimation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Column(
              children: [
                Gaps.v80,
                Text(
                  S.of(context).signUpTitle("TikTok"),
                  style: const TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    S.of(context).signUpSubtitle(10),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.user),
                    text: S.of(context).emailPasswordButton,
                    onTap: () => _onUsernameTap(context),
                  ),
                  Gaps.v16,
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.apple),
                    text: S.of(context).appleButton,
                    onTap: () => _onUsernameTap(context),
                  ),
                ],
                if (orientation == Orientation.landscape) ...[
                  Row(
                    children: [
                      Expanded(
                        child: AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.user),
                          text: S.of(context).emailPasswordButton,
                          onTap: () => _onUsernameTap(context),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.apple),
                          text: S.of(context).appleButton,
                          onTap: () => _onUsernameTap(context),
                        ),
                      ),
                    ],
                  )
                ],
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: isDarkMode(context) ? null : Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size32,
              bottom: Sizes.size64,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).alreadyHaveAnAccount),
                Gaps.h5,
                GestureDetector(
                  onTap: () => onLoginTap(context),
                  child: Text(
                    S.of(context).logIn('aa'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
