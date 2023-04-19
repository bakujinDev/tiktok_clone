import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class ProfileLink extends ConsumerStatefulWidget {
  final String link;
  final bool editMode;
  final Function setEditLinkMode;

  const ProfileLink({
    super.key,
    required this.link,
    required this.editMode,
    required this.setEditLinkMode,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileLinkState();
}

class _ProfileLinkState extends ConsumerState<ProfileLink> {
  final TextEditingController _linkController = TextEditingController();

  String _link = '';

  @override
  void initState() {
    super.initState();

    _linkController.addListener(() {
      setState(() {
        _link = _linkController.text;
      });
    });
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  void _submitLink() async {
    final data = {"link": _link};
    await ref.read(usersProvider.notifier).updateProfile(link: _link);
    widget.setEditLinkMode(false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.link,
            size: Sizes.size16,
          ),
          Gaps.h4,
          if (widget.editMode == true)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: _linkController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: "put link here",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.h8,
                GestureDetector(
                  onTap: _submitLink,
                  child: const FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                  ),
                ),
              ],
            ),
          if (widget.editMode == false)
            GestureDetector(
              onTap: () => widget.setEditLinkMode(true),
              child: Text(
                widget.link,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
