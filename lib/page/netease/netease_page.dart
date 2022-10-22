import 'package:aeyepetizer/entity/netease_news.dart';
import 'package:aeyepetizer/model/netease_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:flutter_base/widget/browser.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NeteasePage extends StatefulWidget {
  NeteasePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NeteasePageState();
  }

  @override
  String toStringShort() {
    return "网易";
  }
}

class _NeteasePageState extends State<NeteasePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late RefreshController refreshController;
  late NeteaseController _neteaseController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: false);
    _neteaseController =
        Get.put(NeteaseController(refreshController: refreshController));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<NeteaseController>(
      init: _neteaseController,
      initState: (data) => _neteaseController.refreshNews(),
      builder: (controller) {
        if (_neteaseController.getCount() > 0) {
          return Container(
            margin: EdgeInsets.all(4),
            child: SmartRefresher(
              physics: BouncingScrollPhysics(),
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: _neteaseController.refreshNews,
              onLoading: _neteaseController.loadMore,
              header: MaterialClassicHeader(),
              footer: ClassicFooter(),
              child: ListView.builder(
                itemCount: _neteaseController.getCount(),
                itemBuilder: (BuildContext context, int index) =>
                    _renderItem(context, index),
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

  _renderItem(context, index) {
    var item = _neteaseController.newsList[index];
    return GestureDetector(
      onTap: () {
        if (!StringUtils.isEmpty(item.url)) {
          Browser.open(context, item.url!, item.title, "");
        }
      },
      child: _newsItem(bean: item),
    );
  }

  _newsItem({required NeteaseNews bean}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image(
                  image: CachedNetworkImageProvider('${bean.imgsrc}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.title}',
                      style: TextStyle(fontSize: 16.0, color: Colors.blue)),
                  Row(
                    children: [
                      Text('${bean.ptime}'),
                      Text(' ${bean.commentCount}跟帖'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
