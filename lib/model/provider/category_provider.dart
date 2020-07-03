import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryProvider extends BaseListViewModel with ChangeNotifier {
  VideoRepository _videoResposity;
  RefreshController refreshController;

  bool refreshFailed = false;

  CategoryProvider({this.refreshController}) {
    _videoResposity = VideoRepository.singleton;
  }

  Future refresh() async {
    print("refresh:${refreshController.footerStatus},$_videoResposity");
    List<ACategory> list = await _videoResposity.loadData(0);
    setData(list);
    if (list == null || list.length == 0) {
      refreshFailed = true;
      refreshController?.refreshCompleted();
      notifyListeners();
      return;
    }
    refreshFailed = false;
    if (list != null && list.length > 0) {
      refreshController?.refreshCompleted();
    } else {
      refreshController?.loadNoData();
    }

    notifyListeners();
  }

  Future loadMore({int pn}) async {
    print("loadMore:${refreshController.footerStatus},$_videoResposity");
    List<ACategory> list = await _videoResposity.loadData(page + 1);
    if (list != null && list.length > 0) {
      addData(list);

      setPage(page + 1);

      refreshController?.loadComplete();
    } else {
      if (list == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }

    notifyListeners();
  }

  @override
  Future loadData({int pn}) {
  }
}
