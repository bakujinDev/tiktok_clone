import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: const Locale('ko'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
                title: const Text("Auto Mute"),
                subtitle: const Text("Videos will be muted by default."),
                value: ref.watch(playbackConfigProvider).muted,
                onChanged: (value) {
                  ref.read(playbackConfigProvider.notifier).setMuted(value);
                }),
            SwitchListTile.adaptive(
                title: const Text("Auto Play"),
                subtitle: const Text("Videos will be autoplay by default."),
                value: ref.watch(playbackConfigProvider).autoplay,
                onChanged: (value) {
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value);
                }),
            // SwitchListTile.adaptive(
            //   title: const Text("Is Dark"),
            //   subtitle: const Text("Set Device DarkMode."),
            //   value: context.watch<VideoConfig>().isDark,
            //   onChanged: (value) => context.read<VideoConfig>().toggleIsDark(),
            // ),
            Switch.adaptive(
              value: false,
              onChanged: (value) {},
            ),
            CupertinoSwitch(
              value: false,
              onChanged: (value) {},
            ),
            Switch(
              value: false,
              onChanged: (value) {},
            ),
            Checkbox(
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text("Enable notifications"),
              subtitle: const Text("Enable notifications"),
              activeColor: Colors.black,
              value: false,
              onChanged: (value) {},
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  confirmText: "하이",
                );
                if (kDebugMode) {
                  print(date);
                }

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }

                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) => Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            ListTile(
              title: const Text("Log out (iOs)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(FontAwesomeIcons.skull),
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const FaIcon(FontAwesomeIcons.car),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("Please dooooooont gooooooo"),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Not Log out"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Yes plz"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(
              applicationVersion: "1.0",
              applicationLegalese: "All rights reserved. Please dont copy me.",
            ),
          ],
        ),
      ),
    );
  }
}
