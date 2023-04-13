import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  final List<Widget> tabs;

  PersistentTabBar(this.tabs);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0.5,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.only(
          bottom: Sizes.size10,
        ),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
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
