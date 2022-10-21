import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/model/provider/video_by_category_controller.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoByCategoryPage extends StatefulWidget {
  VideoByCategoryPage({Key? key, required this.category}) : super(key: key);
  final ACategory category;

  @override
  State<StatefulWidget> createState() {
    return _VideoByCategoryPageState();
  }
}

class _VideoByCategoryPageState extends State<VideoByCategoryPage>
    with BaseListState<VideoByCategoryPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late VideoByCategoryController _videoByCategoryController;

  @override
  void initState() {
    super.initState();
    refreshController = new RefreshController(initialRefresh: true);
    _videoByCategoryController = VideoByCategoryController(
        refreshController: refreshController, category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoByCategoryController>(
      init: _videoByCategoryController,
      initState: (data) => _videoByCategoryController.refreshList(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name!),
        ),
        body: Container(
          margin: EdgeInsets.all(4),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            onRefresh: _videoByCategoryController.refreshList,
            onLoading: _videoByCategoryController.loadMore,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _videoByCategoryController.getCount(),
              itemBuilder: (BuildContext context, int index) => _renderItem(
                  context,
                  index,
                  _videoByCategoryController.getVideos()[index]),
            ),
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
          new MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return new VideoDetailListPage(
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
