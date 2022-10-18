import 'package:aeyepetizer/entity/NewsModel.dart';
import 'package:aeyepetizer/model/NewsController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 视图层
class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key) {
    final counter = Get.put(NewsController());
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
      body: GetBuilder<NewsController>(
        builder: (counter) {
          if (counter.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: counter.newsList.length,
              itemBuilder: (_, index) {
                NewsModel newsModel = counter.newsList[index];
                return Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              image: CachedNetworkImageProvider(
                                  '${newsModel.itemCover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Text(
                            newsModel.title,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
