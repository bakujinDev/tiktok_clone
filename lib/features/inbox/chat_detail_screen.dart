import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _unFocusTextEditor() {
    FocusScope.of(context).unfocus();
  }

  void _sendMessage() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return GestureDetector(
      onTap: _unFocusTextEditor,
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: Sizes.size8,
            leading: Stack(
              children: [
                const CircleAvatar(
                  radius: Sizes.size24,
                  foregroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/3612017'),
                  child: Text("니꼬"),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  width: Sizes.size18,
                  height: Sizes.size18,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: Sizes.size3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: const Text(
              "니꼬",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text("Active now"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                FaIcon(
                  FontAwesomeIcons.flag,
                  size: Sizes.size20,
                ),
                Gaps.h32,
                FaIcon(
                  FontAwesomeIcons.ellipsis,
                  size: Sizes.size20,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final bool isMine = index % 2 == 0;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(Sizes.size20),
                          topRight: const Radius.circular(Sizes.size20),
                          bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5),
                          bottomRight: Radius.circular(
                              isMine ? Sizes.size5 : Sizes.size20),
                        ),
                      ),
                      child: const Text(
                        "this is a message",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size8,
                  horizontal: Sizes.size12,
                ),
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Send a message...",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size8,
                              vertical: 0,
                            ),
                            filled: true,
                            fillColor:
                                isDark ? Colors.grey.shade500 : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Sizes.size12),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.faceLaugh,
                                size: Sizes.size18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h10,
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: Sizes.size36,
                        height: Sizes.size36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _textEditingController.value.text.isNotEmpty
                              ? Theme.of(context).primaryColor
                              : isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            size: Sizes.size18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
