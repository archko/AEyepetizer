import 'package:aeyepetizer/entity/douyin_news_model.dart';
import 'package:aeyepetizer/entity/douyin_news_result.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:get/get.dart';

/// 逻辑层
class DouyinNewsController extends GetxController {
  late VideoRepository _videoResposity;

  /// 是否在加载中，显示加载的loading
  bool isLoading = true;

  /// 新闻模型列表
  List<DouyinNewsModel> newsList = [];

  DouyinNewsController() {
    _videoResposity = VideoRepository.singleton;
  }

  @override
  void onInit() {
    super.onInit();
    getNewsList();
  }

  /// 数据请求与处理
  void getNewsList() async {
    try {
      DouyinNewsResult? newsResult = await _videoResposity.getNews();
      if (null != newsResult && null != newsResult.result) {
        newsList = newsResult.result!;
        update();
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}
