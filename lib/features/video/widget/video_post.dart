import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/video/widget/video_button.dart';
import 'package:tiktok_clone/features/video/widget/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video.mp4');
  final Duration _animationDuration = const Duration(milliseconds: 300);
  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isCommentShowMore = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {});
    _videoPlayerController.setLooping(true);
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _videoPlayerController.pause();
    }
  }

  void _togglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onTapShowCommentMore() {
    _isCommentShowMore = !_isCommentShowMore;
    setState(() {});
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _togglePause();
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _togglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  ),
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      size: Sizes.size52,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            right: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "@니꼬",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "This is my house in Thailand!!!",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 100),
                              child: Text(
                                "#googleearth #googlemaps #googleearth #googlemaps #googleearth #googlemaps",
                                style: const TextStyle(
                                  fontSize: Sizes.size16,
                                  color: Colors.white,
                                ),
                                overflow: _isCommentShowMore
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Gaps.h10,
                          GestureDetector(
                            onTap: _onTapShowCommentMore,
                            child: const Text(
                              "More",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.h40,
                Wrap(
                  direction: Axis.vertical,
                  spacing: Sizes.size24,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      foregroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/3612017'),
                      child: Text("니꼬"),
                    ),
                    const VideoButton(
                      icon: FontAwesomeIcons.solidHeart,
                      text: "2.9M",
                    ),
                    VideoButton(
                      icon: FontAwesomeIcons.solidComment,
                      text: "33K",
                      onTap: () => _onCommentsTap(context),
                    ),
                    const VideoButton(
                      icon: FontAwesomeIcons.share,
                      text: "Share",
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
