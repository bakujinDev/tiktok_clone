import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_count.dart';

class UserProfileScreen extends StatefulWidget {
  static String routeName = "/users";

  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final tabs = [
    const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      child: Icon(Icons.grid_4x4_rounded),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      child: FaIcon(
        FontAwesomeIcons.heart,
      ),
    ),
  ];

  void _onGearPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.tab == 'likes' ? 1 : 0,
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(widget.username),
              actions: [
                IconButton(
                  onPressed: _onGearPressed,
                  icon: const FaIcon(
                    FontAwesomeIcons.gear,
                    size: Sizes.size20,
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    foregroundImage: const NetworkImage(
                        'https://avatars.githubusercontent.com/u/3612017'),
                    child: Text(widget.username),
                  ),
                  Gaps.v20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "@${widget.username}",
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gaps.h5,
                      FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        size: Sizes.size16,
                        color: Colors.blue.shade500,
                      ),
                    ],
                  ),
                  Gaps.v24,
                  SizedBox(
                    height: Sizes.size52,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const UserCount(
                          dataKey: 'Following',
                          dataValue: '97',
                        ),
                        VerticalDivider(
                          width: Sizes.size32,
                          thickness: 1,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                        const UserCount(
                          dataKey: 'Followers',
                          dataValue: '10.5M',
                        ),
                        VerticalDivider(
                          width: Sizes.size32,
                          thickness: 1,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                        const UserCount(
                          dataKey: 'Likes',
                          dataValue: '149.3M',
                        ),
                      ],
                    ),
                  ),
                  Gaps.v14,
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: Sizes.size10,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 160,
                        height: Sizes.size40,
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.size4),
                          ),
                        ),
                        child: const Text(
                          "Follow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: Sizes.size40,
                        height: Sizes.size40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.size4),
                          ),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.youtube,
                          size: Sizes.size20,
                        ),
                      ),
                      Container(
                        width: Sizes.size40,
                        height: Sizes.size40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.size4),
                          ),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.caretDown,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v14,
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.size32,
                    ),
                    child: Text(
                      "All highlights and where to watch to match live matches on FIFA+ I wonder how it would look",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v14,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.link,
                        size: Sizes.size12,
                      ),
                      Gaps.h4,
                      Text(
                        "https://nomadcoders.co",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: PersistentTabBar(tabs),
            ),
          ],
          body: TabBarView(
            children: [
              GridView.builder(
                padding: EdgeInsets.zero,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Sizes.size2,
                  crossAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 14,
                ),
                itemBuilder: (context, index) => Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 14,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/placeholder.jpg',
                        image:
                            'https://source.unsplash.com/random/200x${312 + index}',
                      ),
                    ),
                    Positioned(
                      bottom: Sizes.size4,
                      left: Sizes.size4,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.play_arrow_outlined,
                            size: Sizes.size24,
                            color: Colors.white,
                          ),
                          Text(
                            "4.1M",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text("Page two"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
