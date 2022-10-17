import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DailyVideoListProvider extends GetxController {
  late VideoRepository _videoResposity;
  RefreshController? refreshController;
  bool refreshFailed = false;

  int startPage = 0;
  Trending? last;
  var data = <VideoItem>[].obs;
  int page = 0;

  DailyVideoListProvider({this.refreshController}) {
    _videoResposity = VideoRepository.singleton;
  }

  @override
  void onInit() {
    super.onInit();
    print("onInitge:${refreshController?.footerStatus},$_videoResposity");
  }

  int getCount() {
    return data.length;
  }

  Future refresh() async {
    print("refresh:${refreshController?.footerStatus},$_videoResposity");
    Trending? trending =
        await _videoResposity.loadDailySelection(startPage, last);
    last = trending;
    if (trending == null ||
        trending.itemList == null ||
        trending.itemList!.length < 1) {
      refreshController?.loadNoData();
    } else {
      data.clear();
      data.addAll(trending.itemList!);
      refreshController?.refreshCompleted();
    }
    update();
  }

  Future loadData({int? pn}) async {}

  Future loadMore({int? pn}) async {
    if (getCount() < 1) {
      return refresh();
    }
    Trending? trendingb = last;
    if (trendingb == null || StringUtils.isEmpty(trendingb.nextPageUrl)) {
      refreshController?.loadNoData();
      return null;
    }

    Trending? trending =
        await _videoResposity.loadDailySelection(page + 1, last);
    if (trending == null ||
        trending.itemList == null ||
        trending.itemList!.length < 1) {
      refreshController?.loadNoData();
    } else {
      refreshController?.loadComplete();
    }
    if (trending == null ||
        trending.itemList != null && trending.itemList!.length > 0) {
      data.addAll(trending!.itemList!);

      page = (page + 1);

      refreshController?.loadComplete();
    } else {
      if (trending.itemList == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }
    update();
  }
}
