import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notifications = List.generate(20, (index) => '${index}h');

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Activity"),
      ),
      body: ListView(
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
                    color: Colors.white,
                    border: Border.all(
                      width: Sizes.size1,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Account updateds:",
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
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
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
