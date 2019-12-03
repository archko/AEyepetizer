import 'package:aeyepetizer/entity/video_data.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/video_detail_view_model.dart';
import 'package:aeyepetizer/page/list/base_list_state.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:aeyepetizer/page/player/video_player_page.dart';
import 'package:aeyepetizer/widget/list/pull_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoDetailListPage extends StatefulWidget {
  VideoDetailListPage({Key key, this.videoData}) : super(key: key);
  final VideoData videoData;

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailListPageState();
  }
}

class _VideoDetailListPageState extends State<VideoDetailListPage>
    with BaseListState<VideoDetailListPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshController =  RefreshController(initialRefresh: true);
    viewModel =  VideoDetailViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as VideoDetailViewModel)
        .loadData(viewModel.page, widget.videoData)
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
    refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoData.title),
      ),
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
              return  VideoPlayerPage(
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
