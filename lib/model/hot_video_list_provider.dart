import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/hot_video_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotVideoListProvider with ChangeNotifier {
  HotVideoListViewModel viewModel;
  RefreshController refreshController;
  String type;
  bool refreshFailed = false;

  int startPage = 0;

  HotVideoListProvider({this.viewModel, this.refreshController, this.type}) {
    //refresh();
  }

  int getCount() {
    return viewModel.getCount();
  }

  List<VideoItem> getVideos() {
    return viewModel.data;
  }

  Future refresh() async {
    print("refresh:$viewModel,$refreshController");
    viewModel.setPage(startPage);

    Trending trending = await viewModel.loadData(startPage, type);
    viewModel.last = trending;
    if (trending.itemList == null || trending.itemList.length < 1) {
      refreshController.loadNoData();
    } else {
      viewModel.setData(trending.itemList);
      refreshController.refreshCompleted();
    }

    notifyListeners();
  }

  Future loadMore() async {
    if (viewModel.getCount() < 1) {
      return refresh();
    }
    Trending trendingb = viewModel.last;
    if (trendingb == null || StringUtils.isEmpty(trendingb.nextPageUrl)) {
      refreshController.loadNoData();
      return null;
    }

    Trending trending = await viewModel.loadMore(viewModel.page + 1, type);
    if (trending.itemList == null || trending.itemList.length < 1) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
    if (trending.itemList != null && trending.itemList.length > 0) {
      viewModel.addData(trending.itemList);

      viewModel.setPage(viewModel.page + 1);

      refreshController?.loadComplete();
    } else {
      if (trending.itemList == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }

    notifyListeners();
  }
}
