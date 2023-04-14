import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onUsernameTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Localizations.localeOf(context));
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Column(
              children: [
                Gaps.v80,
                const Text(
                  'Sign up for TikTok',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                const Opacity(
                  opacity: 0.7,
                  child: Text(
                    'Create a profile, follow other accounts, make your own videos, and more.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.user),
                    text: "Use email & password",
                    onTap: () => _onUsernameTap(context),
                  ),
                  Gaps.v16,
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.apple),
                    text: "Continue with Apple",
                    onTap: () => _onUsernameTap(context),
                  ),
                ],
                if (orientation == Orientation.landscape) ...[
                  Row(
                    children: [
                      Expanded(
                        child: AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.user),
                          text: "Use email & password",
                          onTap: () => _onUsernameTap(context),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.apple),
                          text: "Continue with Apple",
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
                const Text('Already have an account?'),
                Gaps.h5,
                GestureDetector(
                  onTap: () => onLoginTap(context),
                  child: Text(
                    'Log in',
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
