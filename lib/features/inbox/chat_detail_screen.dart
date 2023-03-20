import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          leading: const CircleAvatar(
            radius: 24,
            foregroundImage: NetworkImage(
              "https://avatars.githubusercontent.com/u/3612017",
            ),
            child: Text('니꼬'),
          ),
          title: const Text(
            '니꼬',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(
                width: 32,
              ),
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 14,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:
                          isMine ? Colors.blue : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(
                          isMine ? 20 : 5,
                        ),
                        bottomRight: Radius.circular(
                          !isMine ? 20 : 5,
                        ),
                      ),
                    ),
                    child: const Text(
                      'this is a message!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: 10,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  const Expanded(child: TextField()),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: const FaIcon(FontAwesomeIcons.paperPlane),
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
