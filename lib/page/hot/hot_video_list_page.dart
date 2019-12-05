import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/hot_video_list_view_model.dart';
import 'package:aeyepetizer/page/list/base_list_state.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:aeyepetizer/utils/string_utils.dart';
import 'package:aeyepetizer/widget/list/pull_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotVideoListPage extends StatefulWidget {
  HotVideoListPage({Key key, this.type}) : super(key: key);
  static const String TYPE_HOT_WEEKLY = "周热门";
  static const String TYPE_HOT_MONTHLY = "月热门";
  static const String TYPE_TOTAL_RANKING = "总排行";
  final String type;

  @override
  State<StatefulWidget> createState() {
    return _HotVideoListPageState();
  }

  @override
  String toStringShort() {
    return type;
  }
}

class _HotVideoListPageState extends State<HotVideoListPage>
    with BaseListState<HotVideoListPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    viewModel = HotVideoListViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as HotVideoListViewModel)
        .loadData(viewModel.page, widget.type)
        .then((trending) {
      viewModel.setData(trending.itemList);
      setState(() {
        print("refresh end.${viewModel.page}, ${viewModel.getCount()}");
        if (trending.itemList == null || trending.itemList.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
      });
    }).catchError((e) => setState(() {
              print("refresh error,$e");
              refreshController.loadFailed();
            }));
  }

  @override
  Future<void> loadMore() async {
    if (viewModel.getCount() < 1) {
      return refresh();
    }
    HotVideoListViewModel hotViewModel = (viewModel as HotVideoListViewModel);
    Trending trendingb = hotViewModel.last;
    if (trendingb == null || StringUtils.isEmpty(trendingb.nextPageUrl)) {
      refreshController.loadNoData();
      return null;
    }
    await hotViewModel
        .loadMore(hotViewModel.page + 1, widget.type)
        .then((trending) {
      hotViewModel.updateDataAndPage(trending.itemList, viewModel.page + 1);
      setState(() {
        if (trending.itemList == null || trending.itemList.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        print(
            "loadMore end.${refreshController.footerStatus},${viewModel.page}, ${viewModel.getCount()}");
      });
    }).catchError((e) => setState(() {
              print("loadMore error:$e");
              refreshController.loadFailed();
            }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PullWidget(
        pullController: refreshController,
        listCount: viewModel.getCount(),
        itemBuilder: (BuildContext context, int index) =>
            _renderItem(context, index),
        header: MaterialClassicHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.HideAlways,
        ),
        onLoadMore: loadMore,
        onRefresh: refresh,
      ),
    );
  }

  //列表的ltem
  _renderItem(context, index) {
    var item = viewModel.data[index] as VideoItem;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return VideoDetailListPage(
                videoData: item.data,
              );
            },
          ),
        );
      },
      child: VideoListItem(bean: item),
    );
  }
}
