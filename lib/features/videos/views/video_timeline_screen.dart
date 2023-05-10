import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widget/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0;
  final PageController _pageController = PageController();
  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPage();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: 40,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    index: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}
