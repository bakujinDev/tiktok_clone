import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.text,
    required this.disabled,
    this.onTap,
  });

  final String text;
  final bool disabled;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: () {
          if (onTap != null && !disabled) {
            onTap!();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
          ),
          decoration: BoxDecoration(
              color: disabled
                  ? Colors.grey.shade300
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size5)),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabled ? Colors.grey.shade400 : Colors.white,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
