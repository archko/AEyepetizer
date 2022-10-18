import 'package:aeyepetizer/entity/wallpaper.dart';
import 'package:aeyepetizer/entity/wallpaper_bean.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:get/get.dart';

/// 逻辑层
class WallpaperController extends GetxController {
  late VideoRepository _videoResposity;

  bool isLoading = true;

  List<Wallpaper> wallpaperBean = [];

  WallpaperController() {
    _videoResposity = VideoRepository.singleton;
  }

  @override
  void onInit() {
    super.onInit();
    getWallpaperBean();
  }

  void getWallpaperBean() async {
    try {
      WallpaperBean? newsResult = await _videoResposity.getWallpaperBean();
      if (null != newsResult && null != newsResult.wallpapers) {
        wallpaperBean = newsResult.wallpapers!;
        update();
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}
