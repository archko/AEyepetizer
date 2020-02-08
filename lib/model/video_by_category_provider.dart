import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/video_by_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoByCategoryProvider with ChangeNotifier {
  VideoByCategoryViewModel viewModel;
  RefreshController refreshController;
  ACategory category;
  bool refreshFailed = false;

  int startPage = 0;

  VideoByCategoryProvider(
      {this.viewModel, this.refreshController, this.category}) {
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

    Trending trending = await viewModel.loadData(startPage, category);
    viewModel.last = trending;
    if (trending.itemList == null || trending.itemList.length < 1) {
      refreshController.loadNoData();
    } else {
      viewModel.setData(trending.itemList);
      refreshController.refreshCompleted(resetFooterState: true);
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

    Trending trending = await viewModel.loadMore(-1);
    if (trending != null &&
        trending.itemList != null &&
        trending.itemList.length > 0) {
      viewModel.addData(trending.itemList);

      viewModel.setPage(viewModel.page + 1);

      refreshController?.refreshCompleted();
    } else {
      if (trending == null || trending.itemList == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }

    notifyListeners();
  }
}
