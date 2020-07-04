import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryProvider with ChangeNotifier {
  CategoryViewModel viewModel;
  RefreshController refreshController;

  bool refreshFailed = false;

  CategoryProvider({this.viewModel, this.refreshController}) {
    //refresh();
  }

  Future refresh() async {
    print("refresh:$viewModel,$refreshController");
    List<ACategory> list = await viewModel.loadData(pn: 0);
    viewModel.setData(list);
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

  Future loadMore() async {
    List<ACategory> list = await viewModel.loadData(pn: viewModel.page + 1);
    if (list != null && list.length > 0) {
      viewModel.addData(list);

      viewModel.setPage(viewModel.page + 1);

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
}
