import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => '${index}h');
  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimation() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("All Activity"),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      left: Sizes.size10,
                    ),
                    color: Colors.green,
                    child: const FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: Sizes.size32,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(
                      right: Sizes.size10,
                    ),
                    color: Colors.red,
                    child: const FaIcon(
                      FontAwesomeIcons.trashCan,
                      size: Sizes.size32,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.grey.shade900 : Colors.white,
                        border: Border.all(
                          width: Sizes.size1,
                          color: isDark
                              ? Colors.grey.shade900
                              : Colors.grey.shade400,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updateds:",
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          const TextSpan(
                            text: ' Upload longer videos',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' $notification',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size14,
                    ),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimation,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size4),
                  bottomRight: Radius.circular(Sizes.size4),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      minLeadingWidth: Sizes.size20,
                      leading: FaIcon(
                        tab['icon'],
                        size: Sizes.size16,
                      ),
                      title: Text(
                        tab['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
