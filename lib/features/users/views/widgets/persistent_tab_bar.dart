import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  final List<Widget> tabs;

  PersistentTabBar(this.tabs);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0.5,
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade200,
          ),
        ),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.only(
          bottom: Sizes.size10,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        tabs: tabs,
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
