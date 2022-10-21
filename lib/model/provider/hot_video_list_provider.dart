import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotVideoListControllerer extends GetxController with BaseListViewModel {
  late VideoRepository _videoResposity;
  RefreshController? refreshController;
  String? type;
  bool refreshFailed = false;

  int startPage = 0;
  Trending? last;

  HotVideoListControllerer({this.refreshController, this.type}) {
    _videoResposity = VideoRepository.singleton;
  }

  List<VideoItem> getVideos() {
    return data.cast();
  }

  Future refreshList() async {
    print("refresh:${refreshController?.footerStatus},$_videoResposity");
    Trending? trending =
        await _videoResposity.loadTrending(startPage, last, type: type);
    last = trending;
    if (trending == null ||
        trending.itemList == null ||
        trending.itemList!.length < 1) {
      refreshController?.loadNoData();
    } else {
      setData(trending.itemList);
      refreshController?.refreshCompleted();
    }
    update();
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
        await _videoResposity.loadTrending(page + 1, last, type: type);
    if (trending == null ||
        trending.itemList == null ||
        trending.itemList!.length < 1) {
      refreshController?.loadNoData();
    } else {
      refreshController?.loadComplete();
    }
    if (trending == null ||
        trending.itemList != null && trending.itemList!.length > 0) {
      addData(trending!.itemList);

      setPage(page + 1);

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
