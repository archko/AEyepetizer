// ignore_for_file: must_be_immutable

import 'package:aeyepetizer/entity/douyin_news_model.dart';
import 'package:aeyepetizer/model/douyin_news_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/widget/browser.dart';
import 'package:get/get.dart';

/// 视图层
class DouyinNewsPage extends StatelessWidget {
  DouyinNewsController _douyinNewsController = new DouyinNewsController();
  DouyinNewsPage({Key? key}) : super(key: key) {
    Get.put(_douyinNewsController);
  }

  @override
  String toStringShort() {
    return "新闻列表";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("新闻列表"),
      ),*/
      body: GetBuilder<DouyinNewsController>(
        init: _douyinNewsController,
        initState: (data) => _douyinNewsController.getNewsList(),
        builder: (counter) {
          if (counter.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemCount: counter.newsList.length,
                itemBuilder: (_, index) {
                  DouyinNewsModel newsModel = counter.newsList[index];
                  return _buildItem(context, newsModel);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, DouyinNewsModel newsModel) {
    return GestureDetector(
      onTap: () {
        Browser.open(context, newsModel.shareUrl, "", "loading");
      },
      child: _newsItem(newsModel),
    );
  }

  Widget _newsItem(DouyinNewsModel newsModel) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
            child: Divider(height: 1.0, color: Color(0x99000000)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
            child: Text(
              newsModel.title,
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: CachedNetworkImageProvider('${newsModel.itemCover}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
