import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/video/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 2;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record Video"),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screens = [
      Offstage(
        offstage: _selectedIndex != 0,
        child: const VideoTimelineScreen(),
      ),
      Offstage(
        offstage: _selectedIndex != 1,
        child: const DiscoverScreen(),
      ),
      Offstage(
        offstage: _selectedIndex != 2,
        child: const InboxScren(),
      ),
      Offstage(
        offstage: _selectedIndex != 3,
        child: Container(),
      ),
    ];

    return Scaffold(
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: screens,
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedicon: FontAwesomeIcons.house,
                text: "House",
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedicon: FontAwesomeIcons.solidCompass,
                text: "Discover",
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              PostVideoButton(
                onTap: _onPostVideoButtonTap,
                inverted: _selectedIndex != 0,
              ),
              NavTab(
                icon: FontAwesomeIcons.message,
                selectedicon: FontAwesomeIcons.solidMessage,
                text: "Inbox",
                isSelected: _selectedIndex == 2,
                onTap: () => _onTap(2),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedicon: FontAwesomeIcons.solidUser,
                text: "Profile",
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
