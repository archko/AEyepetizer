import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/netease_news.dart';
import 'package:aeyepetizer/entity/netease_news_bean.dart';
import 'package:aeyepetizer/repository/netease_repo.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NeteaseController extends GetxController {
  RefreshController? refreshController;

  //NeteaseNewsBean? neteaseNewsBean;
  List<NeteaseNews> newsList = [];

  NeteaseController({this.refreshController});

  int page = 0;

  int getCount() {
    return newsList.length;
  }

  List<NeteaseNews> getNews() {
    return newsList;
  }

  Future refreshNews() async {
    page = 0;
    NeteaseNewsBean? neteaseBean = await NeteaseRepo.singleton
        .loadNeteaseNews(WebConfig.key_finance, page);
    newsList.clear();
    if (null != neteaseBean &&
        neteaseBean.news != null &&
        neteaseBean.news!.length > 0) {
      page++;
      newsList.addAll(neteaseBean.news!);
      refreshController?.loadComplete();
    } else {
      refreshController?.loadNoData();
    }
    update();
  }

  Future loadMore({int? pn}) async {
    if (getCount() < 1) {
      return refreshNews();
    }
    NeteaseNewsBean? neteaseBean = await NeteaseRepo.singleton
        .loadNeteaseNews(WebConfig.key_finance, page + 1);
    if (neteaseBean == null ||
        neteaseBean.news == null ||
        neteaseBean.news!.length < 1) {
      refreshController?.loadNoData();
    } else {
      refreshController?.loadComplete();
    }
    if (neteaseBean == null ||
        neteaseBean.news != null && neteaseBean.news!.length > 0) {
      page = (page + 1);
      newsList.addAll(neteaseBean!.news!);

      refreshController?.loadComplete();
    } else {
      if (neteaseBean.news == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }
    update();
  }
}
