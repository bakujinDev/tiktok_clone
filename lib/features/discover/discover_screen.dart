import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");
  late TabController _tabController;
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _startWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _onClearTap() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: Container(
          height: 40,
          constraints: const BoxConstraints(
            maxWidth: Breakpoints.sm,
          ),
          child: TextField(
            controller: _textEditingController,
            onTap: _startWriting,
            style: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDarkMode(context)
                  ? Colors.grey.shade700
                  : Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(Sizes.size12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
                vertical: 0,
              ),
              prefix: Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.size8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: Sizes.size14,
                      color: isDarkMode(context)
                          ? Colors.grey.shade200
                          : Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isWriting)
                    GestureDetector(
                      onTap: _onClearTap,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        size: Sizes.size14,
                        color: isDarkMode(context)
                            ? Colors.grey.shade200
                            : Colors.grey.shade700,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          isScrollable: true,
          labelStyle: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
          indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            for (var tab in tabs)
              Tab(
                text: tab,
              )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(Sizes.size6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > Breakpoints.lg ? 5 : 2,
              mainAxisSpacing: Sizes.size10,
              crossAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/placeholder.jpg',
                        image:
                            'https://source.unsplash.com/random/200x${355 + index}',
                      ),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    'This is a very long caption for my tiktok that im upload just now currently.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (constraints.maxWidth < 200 ||
                      constraints.maxWidth > 250) ...[
                    Gaps.v10,
                    DefaultTextStyle(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/3612017'),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              'My avatar is going to be very long',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: isDarkMode(context)
                                ? Colors.grey.shade300
                                : Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            '2.5M',
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            )
        ],
      ),
    );
  }
}
