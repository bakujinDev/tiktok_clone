import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideosRepository _repository;
  late final String _videoId;
  late final String _userId;
  bool _isLiked = false;

  @override
  FutureOr<bool> build(String videoId) async {
    _videoId = videoId;
    _repository = ref.read(videosRepo);
    _userId = ref.read(authRepo).user!.uid;

    _isLiked = await _repository.isLikedVideo(
      videoId: _videoId,
      userId: _userId,
    );

    return _isLiked;
  }

  Future<void> toggleLikeVideo() async {
    await _repository.toggleLikeVideo(
      videoId: _videoId,
      userId: _userId,
    );

    _isLiked = !_isLiked;
    state = AsyncValue.data(_isLiked);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
  () => VideoPostViewModel(),
);
