import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoByCategoryController extends GetxController {
  late VideoRepository _videoResposity;
  RefreshController? refreshController;
  ACategory? category;
  bool refreshFailed = false;

  Trending? last;
  var data = <VideoItem>[];
  int page = 0;

  VideoByCategoryController({this.refreshController, this.category}) {
    //refresh();
    _videoResposity = VideoRepository.singleton;
  }
  int getCount() {
    return data.length;
  }

  List<VideoItem> getVideos() {
    return data.cast();
  }

  Future refreshList() async {
    print("refresh:${refreshController?.footerStatus},$_videoResposity");

    Trending? trending =
        await _videoResposity.loadTrending(page, last, category: category);
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
  }

  Future loadData({int? pn}) async {}

  Future loadMore({int? pn}) async {
    if (getCount() < 1) {
      return refreshList();
    }
    Trending? trendingb = last;
    if (trendingb == null || StringUtils.isEmpty(trendingb.nextPageUrl)) {
      refreshController?.loadNoData();
      update();
      return null;
    }

    Trending? trending =
        await _videoResposity.loadTrending(-1, last, category: category);
    if (trending != null &&
        trending.itemList != null &&
        trending.itemList!.length > 0) {
      data.addAll(trending.itemList!);

      page = (page + 1);

      refreshController?.loadComplete();
    } else {
      if (trending == null || trending.itemList == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }
    update();
  }
}
