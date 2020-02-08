import 'package:aeyepetizer/model/hot_video_list_provider.dart';
import 'package:aeyepetizer/model/hot_video_list_view_model.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/model/provider_widget.dart';
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
    refreshController = RefreshController(initialRefresh: false);
    viewModel = HotVideoListViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HotVideoListProvider>(
      model: HotVideoListProvider(
          viewModel: viewModel,
          refreshController: refreshController,
          type: widget.type),
      onModelInitial: (m) {
        refreshController.requestRefresh();
      },
      builder: (context, model, childWidget) {
        return Container(
          margin: EdgeInsets.all(4),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(),
            child: ListView.builder(
              itemCount: model.getCount(),
              itemBuilder: (BuildContext context, int index) =>
                  _renderItem(context, index, model.getVideos()[index]),
            ),
          ),
        );
      },
    );
  }

  //列表的ltem
  _renderItem(context, index, item) {
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
