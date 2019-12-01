import 'package:aeyepetizer/model/movie_view_model.dart';
import 'package:aeyepetizer/page/list/base_list_state.dart';
import 'package:aeyepetizer/page/movie/movie_list_item.dart';
import 'package:aeyepetizer/widget/list/list_more_widget.dart';
import 'package:aeyepetizer/widget/list/pull_to_refresh_widget.dart';
import 'package:flutter/material.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieListPageState();
  }
}

class _MovieListPageState extends State<MovieListPage>
    with BaseListState<MovieListPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var loadMoreStatus = LoadMoreStatus.IDLE;

  @override
  void initState() {
    super.initState();
    viewModel = new MovieViewModel();
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.getCount() < 1 && loadMoreStatus == LoadMoreStatus.IDLE) {
      refresh();
    }
    return PullToRefreshWidget(
      itemBuilder: (BuildContext context, int index) =>
          _renderItem(index, context),
      listCount: viewModel.getCount() + 1,
      onLoadMore: loadMore,
      onRefresh: refresh,
      loadMoreStatus: loadMoreStatus,
    );
  }

  /**
   * 列表的ltem
   */
  _renderItem(index, context) {
    if (index == viewModel.getCount()) {
      return ListMoreWidget(
        loadMoreStatus: loadMoreStatus,
        retry: retry,
      );
    } else {
      return MovieListItem(bean: viewModel.data[index]);
    }
  }

  Future refresh() async {
    loadMoreStatus = (LoadMoreStatus.LOADING);
    viewModel.setPage(startPage);
    await viewModel.loadData(viewModel.page).then((list) {
      viewModel.setData(list);
      setState(() {
        print("refresh end.${viewModel.page}, ${viewModel.getCount()}");
        if (list.length < 1) {
          loadMoreStatus = (LoadMoreStatus.NOMORE);
        } else {
          loadMoreStatus = (LoadMoreStatus.IDLE);
        }
      });
    }).catchError((_) => setState(() {
          print("refresh error");
          loadMoreStatus = (LoadMoreStatus.FAIL);
        }));
  }

  Future<void> loadMore() async {
    if (viewModel.getCount() < 1) {
      return refresh();
    }
    setState(() {
      loadMoreStatus = (LoadMoreStatus.LOADING);
    });
    await viewModel.loadMore(viewModel.page + 1).then((list) {
      viewModel.updateDataAndPage(list, viewModel.page + 1);
      setState(() {
        if (list.length < 1) {
          loadMoreStatus = (LoadMoreStatus.NOMORE);
        } else {
          loadMoreStatus = (LoadMoreStatus.IDLE);
        }
        print(
            "loadMore end.$loadMoreStatus,${viewModel.page}, ${viewModel.getCount()}");
      });
    }).catchError((_) => setState(() {
          loadMoreStatus = (LoadMoreStatus.FAIL);
        }));
  }
}
