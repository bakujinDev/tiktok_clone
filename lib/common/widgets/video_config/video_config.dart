import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool isDark = true;
  bool isMuted = false;
  bool isAutoPlay = false;

  void toggleIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}
