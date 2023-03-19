import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 20,
          child: Container(
            width: 25,
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff61d4f0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            width: 25,
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 18,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
