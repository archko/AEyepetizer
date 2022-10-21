import 'package:aeyepetizer/model/provider/movie_provider.dart';
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
  late MovieProvider _movieProvider;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    _movieProvider =
        Get.put(MovieProvider(refreshController: refreshController));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MovieProvider>(
      init: _movieProvider,
      initState: (data) => _movieProvider.loadData(),
      builder: (controller) {
        Logger.d(
            "loadingStatus:${_movieProvider.loadingStatus},${_movieProvider.data}");
        if (_movieProvider.data.length > 0) {
          return Container(
            margin: EdgeInsets.all(4),
            child: SmartRefresher(
              physics: BouncingScrollPhysics(),
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: _movieProvider.loadData,
              onLoading: _movieProvider.loadMore,
              header: MaterialClassicHeader(),
              footer: ClassicFooter(),
              child: ListView.builder(
                itemCount: _movieProvider.getCount(),
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
    var item = _movieProvider.data[index];
    return GestureDetector(
      onTap: () {},
      child: MovieListItem(bean: item),
    );
  }
}
