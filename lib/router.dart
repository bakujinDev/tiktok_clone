import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/views/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/views/chats_screen.dart';
import 'package:tiktok_clone/features/notifications/notifications_provider.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  // ref.watch(authState);
  return GoRouter(
      initialLocation: '/home',
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;

        if (!isLoggedIn) {
          if (state.subloc != SignUpScreen.routeUrl &&
              state.subloc != LoginScreen.routeUrl) {
            return SignUpScreen.routeUrl;
          }
        }

        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            ref.read(notificationsProvider(context));
            return child;
          },
          routes: [
            GoRoute(
              name: SignUpScreen.routeName,
              path: SignUpScreen.routeUrl,
              builder: (context, state) => const SignUpScreen(),
            ),
            GoRoute(
              name: LoginScreen.routeName,
              path: LoginScreen.routeUrl,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              name: InterestsScreen.routeName,
              path: InterestsScreen.routeUrl,
              builder: (context, state) => const InterestsScreen(),
            ),
            GoRoute(
              path: "/:tab(home|discover|inbox|profile)",
              name: MainNavigationScreen.routeName,
              builder: (context, state) {
                final tab = state.params['tab']!;

                return MainNavigationScreen(tab: tab);
              },
            ),
            GoRoute(
              name: ActivityScreen.routeName,
              path: ActivityScreen.routeUrl,
              builder: (context, state) => const ActivityScreen(),
            ),
            GoRoute(
              name: ChatsScreen.routeName,
              path: ChatsScreen.routeUrl,
              builder: (context, state) => const ChatsScreen(),
              routes: [
                GoRoute(
                  name: ChatDetailScreen.routeName,
                  path: ChatDetailScreen.routeUrl,
                  builder: (context, state) {
                    final chatId = state.params['chatId']!;

                    return ChatDetailScreen(chatId: chatId);
                  },
                ),
              ],
            ),
            GoRoute(
              name: VideoRecordingScreen.routeName,
              path: VideoRecordingScreen.routeUrl,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const VideoRecordingScreen(),
                transitionDuration: const Duration(milliseconds: 200),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final position = Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation);

                  return SlideTransition(
                    position: position,
                    child: child,
                  );
                },
              ),
            ),
          ],
        )
      ]);
});
