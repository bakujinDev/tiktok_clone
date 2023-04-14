import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = '';

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? _isPasswordValid() {
    if (_password.isEmpty) return null;

    if (_password.length < 8) return "more than length 8";

    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _onFormButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onSubmit() {
    if (_isPasswordValid() != null) return;

    _onFormButtonTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                'What is your password?',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                onEditingComplete: _onSubmit,
                autocorrect: false,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffix: Wrap(
                    spacing: Sizes.size14,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          size: Sizes.size20,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: Sizes.size20,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  hintText: "Make it strong!",
                  errorText: _isPasswordValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  const Text(
                    'Your password must have:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Wrap(
                    spacing: Sizes.size5,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleCheck,
                        size: Sizes.size20,
                        color:
                            _password.isNotEmpty && _isPasswordValid() == null
                                ? Colors.green
                                : Colors.grey.shade400,
                      ),
                      const Text('8 to 20 characters'),
                    ],
                  ),
                ],
              ),
              Gaps.v16,
              FormButton(
                text: "Next",
                disabled: _isPasswordValid() != null,
                onTap: _onFormButtonTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
