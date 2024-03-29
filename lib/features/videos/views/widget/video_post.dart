import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_models.dart';
import 'package:tiktok_clone/features/videos/views/widget/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widget/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final int index;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  late final AnimationController _animationController;

  late bool _isPaused = !ref.read(playbackConfigProvider).autoplay;
  late bool _isMuted = ref.read(playbackConfigProvider).muted;
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

    if (_isMuted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }

    if (!_isPaused) {
      _videoPlayerController.play();
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.videoData.fileUrl);
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      _isMuted = true;
    }
    setState(() {});
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;

    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (!_isPaused) {
        _videoPlayerController.play();
      }
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

  void _onLikeTap() {
    ref.read(videoPostProvider(widget.videoData.id).notifier).toggleLikeVideo();
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

  void _toggleMute() {
    if (_videoPlayerController.value.volume == 0) {
      _videoPlayerController.setVolume(1);
      _isMuted = false;
    } else {
      _videoPlayerController.setVolume(0);
      _isMuted = true;
    }

    setState(() {});
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
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
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
            left: Sizes.size20,
            top: Sizes.size40,
            child: IconButton(
              icon: FaIcon(
                _isMuted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: _toggleMute,
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
                      Text(
                        "@${widget.videoData.creator}",
                        style: const TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v10,
                      Text(
                        widget.videoData.description,
                        style: const TextStyle(
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
                    CircleAvatar(
                      radius: 25,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      foregroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/flutter-practice-e2045.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media&token=92490adc-48b0-4ad1-8ac1-7f7734959731&trash=${DateTime.now().toString()}'),
                      child: Text("@${widget.videoData.creator}"),
                    ),
                    ref.watch(videoPostProvider(widget.videoData.id)).when(
                          data: (data) {
                            return VideoButton(
                              icon: FontAwesomeIcons.solidHeart,
                              iconColor: data ? Colors.red : null,
                              text: S
                                  .of(context)
                                  .likeCount(widget.videoData.likes),
                              onTap: _onLikeTap,
                            );
                          },
                          error: (error, stackTrace) => VideoButton(
                            icon: FontAwesomeIcons.solidHeart,
                            text:
                                S.of(context).likeCount(widget.videoData.likes),
                          ),
                          loading: () => VideoButton(
                            icon: FontAwesomeIcons.solidHeart,
                            text:
                                S.of(context).likeCount(widget.videoData.likes),
                          ),
                        ),
                    VideoButton(
                      icon: FontAwesomeIcons.solidComment,
                      text:
                          S.of(context).commentCount(widget.videoData.comments),
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
