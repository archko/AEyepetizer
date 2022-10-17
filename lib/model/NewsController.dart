import 'package:aeyepetizer/entity/NewsModel.dart';
import 'package:aeyepetizer/entity/NewsResult.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:get/get.dart';

/// 逻辑层
class NewsController extends GetxController {
  late VideoRepository _videoResposity;

  /// 是否在加载中，显示加载的loading
  bool isLoading = true;

  /// 新闻模型列表
  List<NewsModel> newsList = [];

  NewsController() {
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
      NewsResult? newsResult = await _videoResposity.getNews();
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
