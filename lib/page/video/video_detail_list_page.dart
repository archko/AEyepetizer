import 'package:aeyepetizer/entity/video_data.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/video_detail_view_model.dart';
import 'package:aeyepetizer/page/list/base_list_state.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:aeyepetizer/utils/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
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
    with
        BaseListState<VideoDetailListPage>,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;
  VideoItem _currVideoItem;
  IjkMediaController _controller = IjkMediaController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    refreshController = RefreshController(initialRefresh: true);
    viewModel = VideoDetailViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Logger.log("$this,dispose");
    if (_controller.isPlaying) {
      _controller.stop();
    }
    _controller.dispose();
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as VideoDetailViewModel)
        .loadData(viewModel.page, widget.videoData)
        .then((trending) {
      viewModel.setData(trending.itemList);
      if (trending.itemList != null && trending.itemList.length > 1) {
        VideoItem videoItem = trending.itemList[1];
        if (videoItem.type == "videoSmallCard") {
          _currVideoItem = videoItem;
        }
        Logger.log("video:$videoItem");
      }
      setState(() {
        Logger.log("refresh end.${viewModel.page}, ${viewModel.getCount()}");
        if (trending.itemList == null || trending.itemList.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        setPlayer(_currVideoItem);
      });
    }).catchError((e) => setState(() {
              Logger.log("refresh error,$e");
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
    //return Scaffold(
    //  appBar: AppBar(
    //    title: Text(widget.videoData.title),
    //  ),
    //  body: PullWidget(
    //    pullController: refreshController,
    //    listCount: viewModel.getCount(),
    //    itemBuilder: (BuildContext context, int index) =>
    //        _renderItem(context, index),
    //    header: MaterialClassicHeader(),
    //    footer: ClassicFooter(
    //      loadStyle: LoadStyle.HideAlways,
    //    ),
    //    onLoadMore: loadMore,
    //    onRefresh: refresh,
    //  ),
    //);
    return buildL(context);
  }

  //列表的ltem
  Widget _renderItem(context, index) {
    var item = viewModel.data[index] as VideoItem;
    Logger.log("render:$item");
    //return GestureDetector(
    //  onTap: () {
    //    Navigator.of(context).push(
    //      CupertinoPageRoute<void>(
    //        builder: (BuildContext context) {
    //          return VideoPlayerPage(
    //            videoData: item.data,
    //          );
    //        },
    //      ),
    //    );
    //  },
    //  child: VideoListItem(bean: item),
    //);
    if (item.type == 'videoSmallCard') {
      return GestureDetector(
        onTap: () {
          if (_controller.isPlaying) {
            _controller.pause();
          }
          setPlayer(item);
        },
        child: VideoListItem(
          bean: item,
        ),
      );
    } else { //textCard
      return Container(
        color: Colors.black,
        child: Padding(
          padding:
          EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: Text(
            item.data?.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
  }

  Widget buildL(BuildContext context) {
    if (_currVideoItem == null) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.all(30),
          alignment: Alignment.topCenter,
          child: RefreshProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Container(
        /// 设置背景图片
        //decoration: BoxDecoration(
        //  image: DecorationImage(
        //    fit: BoxFit.cover,
        //    image: CachedNetworkImageProvider(
        //      '${item.data.cover.feed}',
        //    ),
        //  ),
        //),
        child: Column(
          children: <Widget>[
            /// 视频播放器
            Container(
              height: 230,
              child: IjkPlayer(mediaController: _controller),
            ),
            Divider(
              height: .2,
              color: Color(0xFFDDDDDD),
            ),
            Flexible(
              flex: 1,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// 标题栏
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                              bottom: 5,
                            ),
                            child: Text(
                              _currVideoItem.data.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),

                          /// 标签/时间栏
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              '#${_currVideoItem.data.category}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          /// 视频描述
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            child: Text(
                              _currVideoItem.data.description,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          /// 点赞、分享、评论栏
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    //Image.asset(
                                    //  'images/icon_like.png',
                                    //  width: 22,
                                    //  height: 22,
                                    //),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        '${_currVideoItem.data.consumption.collectionCount}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    children: <Widget>[
                                      //Image.asset(
                                      //  'images/icon_share_white.png',
                                      //  width: 22,
                                      //  height: 22,
                                      //),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3),
                                        child: Text(
                                          '${_currVideoItem.data.consumption.shareCount}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    //Image.asset(
                                    //  'images/icon_comment.png',
                                    //  width: 22,
                                    //  height: 22,
                                    //),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        '${_currVideoItem.data.consumption.replyCount}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Divider(
                              height: .5,
                              color: Color(0xFFDDDDDD),
                            ),
                          ),

                          /// 作者信息
                          InkWell(
                            onTap: () {
                              //String itemJson =
                              //FluroConvertUtils.object2string(
                              //    item);
                              //RouterManager.router.navigateTo(
                              //  context,
                              //  RouterManager.author +
                              //      "?itemJson=$itemJson",
                              //  transition: TransitionType.inFromRight,
                              //);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                top: 10,
                                right: 15,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      width: 40,
                                      height: 40,
                                      imageUrl: _currVideoItem.data.author.icon,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        backgroundColor: Colors.deepPurple[600],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _currVideoItem.data.author.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(
                                              _currVideoItem.data.author.description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        '+ 关注',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF4F4F4),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    onTap: (() {
                                      Logger.log('点击关注');
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Divider(
                            height: .5,
                            color: Color(0xFFDDDDDD),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 相关视频列表
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _renderItem(context, index);
                      },
                      childCount: viewModel.getCount(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setPlayer(VideoItem item) {
    if (null != item.data) {
      _controller.setNetworkDataSource(
        item.data.playUrl,
        autoPlay: true,
      );
    } else {
      _controller.stop();
    }
  }
}
