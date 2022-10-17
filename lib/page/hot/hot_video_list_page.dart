import 'package:aeyepetizer/model/provider/hot_video_list_provider.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotVideoListPage extends StatefulWidget {
  HotVideoListPage({Key? key, this.type}) : super(key: key);
  static const String TYPE_HOT_WEEKLY = "周热门";
  static const String TYPE_HOT_MONTHLY = "月热门";
  static const String TYPE_TOTAL_RANKING = "总排行";
  String? type;

  @override
  State<StatefulWidget> createState() {
    return _HotVideoListPageState();
  }

  @override
  String toStringShort() {
    return StringUtils.isEmpty(type) ? "" : type!;
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
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<HotVideoListProvider>(
      //init: _movieProvider.loadData(),
      builder: (controller) => Container(
        margin: EdgeInsets.all(4),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          onRefresh: controller.refresh,
          onLoading: controller.loadMore,
          header: MaterialClassicHeader(),
          footer: ClassicFooter(),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.getCount(),
            itemBuilder: (BuildContext context, int index) =>
                _renderItem(context, index, controller.getVideos()[index]),
          ),
        ),
      ),
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
