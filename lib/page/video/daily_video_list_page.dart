import 'package:aeyepetizer/model/provider/daily_video_list_provider.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DailyVideoListPage extends StatefulWidget {
  DailyVideoListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DailyVideoListPageState();
  }

  @override
  String toStringShort() {
    return "每日精选";
  }
}

class _DailyVideoListPageState extends State<DailyVideoListPage>
    with BaseListState<DailyVideoListPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late DailyVideoListProvider _dailyVideoListProvider;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: false);
    _dailyVideoListProvider =
        DailyVideoListProvider(refreshController: refreshController);
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<DailyVideoListProvider>(
      init: _dailyVideoListProvider,
      //initState: (data) => _dailyVideoListProvider.refresh(),
      builder: (controller) {
        if (_dailyVideoListProvider.data.length > 0) {
          return Container(
            margin: EdgeInsets.all(4),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: _dailyVideoListProvider.refresh,
              onLoading: _dailyVideoListProvider.loadMore,
              header: MaterialClassicHeader(),
              footer: ClassicFooter(),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _dailyVideoListProvider.data.length,
                itemBuilder: (BuildContext context, int index) => _renderItem(
                    context, index, _dailyVideoListProvider.data[index]),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //列表的ltem
  _renderItem(context, index, item) {
    if (null == item) {
      return Container(
        height: 45,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text("",
                  style: TextStyle(fontSize: 20.0, color: Colors.cyanAccent)),
            ),
          ],
        ),
      );
    }
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
