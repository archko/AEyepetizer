import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/model/provider/video_by_category_provider.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/model/provider_widget.dart';
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

  @override
  void initState() {
    super.initState();
    refreshController = new RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name!),
      ),
      body: ProviderWidget<VideoByCategoryProvider>(
        model: VideoByCategoryProvider(
            refreshController: refreshController, category: widget.category),
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
                physics: BouncingScrollPhysics(),
                itemCount: model.getCount(),
                itemBuilder: (BuildContext context, int index) =>
                    _renderItem(context, index, model.getVideos()[index]),
              ),
            ),
          );
        },
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
