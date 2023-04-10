import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onTap(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 20,
                  child: Container(
                    width: 25,
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff61d4f0),
                      borderRadius: BorderRadius.circular(
                        Sizes.size6,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: Container(
                    width: 25,
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(
                        Sizes.size6,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      Sizes.size6,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      size: Sizes.size16 + Sizes.size2,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
