import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserCount extends StatelessWidget {
  const UserCount({
    super.key,
    required this.dataKey,
    required this.dataValue,
  });

  final String dataKey;
  final String dataValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dataValue,
          style: const TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gaps.v3,
        Text(
          dataKey,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        )
      ],
    );
  }
}
