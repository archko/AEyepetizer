import 'package:aeyepetizer/model/provider/movie_controller.dart';
import 'package:aeyepetizer/page/movie/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieListPageState();
  }

  @override
  String toStringShort() {
    return "Movie";
  }
}

class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late RefreshController refreshController;
  late MovieController _movieController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    _movieController =
        Get.put(MovieController(refreshController: refreshController));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MovieController>(
      init: _movieController,
      initState: (data) => _movieController.loadMovie(),
      builder: (controller) {
        Logger.d("${_movieController.data}");
        if (_movieController.data.length > 0) {
          return Container(
            margin: EdgeInsets.all(4),
            child: SmartRefresher(
              physics: BouncingScrollPhysics(),
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: _movieController.loadMovie,
              //onLoading: _movieProvider.loadMore,
              header: MaterialClassicHeader(),
              footer: ClassicFooter(),
              child: ListView.builder(
                itemCount: _movieController.getCount(),
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
    var item = _movieController.data[index];
    return GestureDetector(
      onTap: () {},
      child: MovieListItem(bean: item),
    );
  }
}
