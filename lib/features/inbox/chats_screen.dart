import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chat";
  static const String routeUrl = "/chat";

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _itmes = [];
  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _itmes.length,
        duration: _duration,
      );
      _itmes.add(_itmes.length);
    }
  }

  Widget _makeTile(int index) {
    return ListTile(
      onTap:()=> _onChatTap(index),
      onLongPress: () => _deleteItem(index),
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage:
            NetworkImage('https://avatars.githubusercontent.com/u/3612017'),
        child: Text("니꼬"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Lynn ($index)",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              fontSize: Sizes.size12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: const Text("Don't forget to make video"),
    );
  }

  void _onChatTap(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {
        'chatId': "$index",
      },
    );
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: _makeTile(index),
          ),
        ),
        duration: _duration,
      );

      _itmes.removeAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          )
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        initialItemCount: _itmes.length,
        itemBuilder: (context, index, animation) => FadeTransition(
          key: UniqueKey(),
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: _makeTile(index),
          ),
        ),
      ),
    );
  }
}
