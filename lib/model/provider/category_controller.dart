import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends GetxController {
  late VideoRepository _videoResposity;
  RefreshController? refreshController;

  List<ACategory>? data;
  int page = 0;

  CategoryController({this.refreshController}) {
    _videoResposity = VideoRepository.singleton;
  }

  int getCount() {
    return null == data ? 0 : data!.length;
  }

  Future refreshList() async {
    print("refresh:${refreshController?.footerStatus},$_videoResposity");
    List<ACategory>? list = await _videoResposity.loadData(0);
    data = list;
    if (null == list || list.length == 0) {
      refreshController?.loadNoData();
    } else {
      refreshController?.refreshCompleted();
    }

    update();
  }

  Future loadMore({int? pn}) async {
    print("loadMore:${refreshController?.footerStatus},$_videoResposity");
    List<ACategory>? list = await _videoResposity.loadData(page + 1);
    if (list != null && list.length > 0) {
      data?.addAll(list);
      page = page + 1;
      refreshController?.loadComplete();
    } else {
      if (list == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }
    update();
  }
}
