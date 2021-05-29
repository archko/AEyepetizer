import 'package:aeyepetizer/entity/gank_bean.dart';
import 'package:aeyepetizer/entity/gank_category.dart';
import 'package:aeyepetizer/model/provider/gank_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/model/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'gank_girl_detail_page.dart';
import 'gank_girl_list_image_item.dart';
import 'gank_list_noimage_item.dart';

class GankGirlListPage extends StatefulWidget {
  GankGirlListPage({Key? key, this.category, required this.categoryType}) : super(key: key);
  final GankCategory? category;
  final String categoryType;

  @override
  _GankGirlListPageState createState() => _GankGirlListPageState();

  @override
  String toStringShort() {
    return category!.title!;
  }
}

class _GankGirlListPageState extends State<GankGirlListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

 late RefreshController _refreshController;
  late GankProvider _gankProvider;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _gankProvider = GankProvider(
      category: widget.categoryType,
      type: widget.category!.type!,
      refreshController: _refreshController,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<GankProvider>(
      model: _gankProvider,
      onModelInitial: (m) {
        _gankProvider.loadData();
      },
      builder: (context, model, childWidget) {
        return Container(
          child: SmartRefresher(
            //physics: BouncingScrollPhysics(),
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: model.loadData,
            onLoading: model.loadMore,
            header: MaterialClassicHeader(),
            child: ListView.builder(
              itemCount: model.getCount(),
              itemBuilder: (BuildContext context, int index) =>
                  _renderItem(context, index, model.getCount()),
            ),
          ),
        );
      },
    );
  }

  void detail(GankBean bean) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return GankGirlDetailPage(
            bean: bean,
          );
        },
      ),
    );
  }

  //列表的ltem
  _renderItem(context, index, int count) {
    GankBean bean = _gankProvider.getData()[index];
    if (bean.images == null || bean.images!.length < 1) {
      return GankListNoImageItem(
        bean: bean,
        onPressed: () {
          detail(bean);
        },
      );
    } else {
      return GankGirlListImageItem(
        bean: bean,
        onPressed: () {
          detail(bean);
        },
      );
    }
  }
}
