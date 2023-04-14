import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/utils.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      if (_direction == Direction.right) return;
      setState(() {
        _direction = Direction.right;
      });
    } else {
      if (_direction == Direction.left) return;
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      if (_showingPage == Page.second) return;
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      if (_showingPage == Page.first) return;
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: SafeArea(
        child: Scaffold(
          body: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _showingPage == Page.first
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: const Page1(),
            secondChild: const Page2(),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? Colors.black : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.size24),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showingPage == Page.first ? 0 : 1,
                child: CupertinoButton(
                  onPressed: _onEnterAppTap,
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Enter the app!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Gaps.v80,
          Text(
            'Follow the rules',
            style: TextStyle(
              fontSize: Sizes.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.v16,
          Text(
            'Videos are personalized for you based on what you watch, like and share.',
            style: TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Gaps.v80,
          Text(
            'Watch cool videos!',
            style: TextStyle(
              fontSize: Sizes.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.v16,
          Text(
            'Take Care of one another! Please!',
            style: TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
        ],
      ),
    );
  }
}
