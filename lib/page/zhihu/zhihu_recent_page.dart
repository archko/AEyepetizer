import 'package:aeyepetizer/entity/zhihu.dart';
import 'package:aeyepetizer/model/zhihu_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/widget/browser.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZhihuRecentPage extends StatefulWidget {
  ZhihuRecentPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ZhihuRecentPageState();
  }

  @override
  String toStringShort() {
    return "知乎热门";
  }
}

class _ZhihuRecentPageState extends State<ZhihuRecentPage>
    with BaseListState<ZhihuRecentPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late ZhihuController _zhihuController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: false);
    _zhihuController = ZhihuController();
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ZhihuController>(
      init: _zhihuController,
      initState: (data) => _zhihuController.refreshList(),
      builder: (controller) {
        if (controller.getCount() < 1) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            margin: EdgeInsets.all(4),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: controller.refreshList,
              header: MaterialClassicHeader(),
              footer: ClassicFooter(
                loadStyle: LoadStyle.HideAlways,
              ),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: controller.getCount(),
                itemBuilder: (BuildContext context, int index) => _renderItem(
                    context, index, controller.getRecents()![index]),
              ),
            ),
          );
        }
      },
    );
  }

  //列表的ltem
  Widget _renderItem(BuildContext context, int index, Zhihu item) {
    return GestureDetector(
      onTap: () {
        Browser.open(context, item.url, item.title, "");
      },
      child: _zhihuRecentItem(context, item),
    );
  }

  Widget _zhihuRecentItem(BuildContext context, Zhihu bean) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: CachedNetworkImageProvider('${bean.thumbnail}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.title}',
                      style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
